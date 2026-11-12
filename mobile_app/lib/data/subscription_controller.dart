import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show DateTimeRange;

import '../models/product.dart';

// ---------------------------------------------------------------------------
// BUSINESS RULES: change these two numbers to match your company policy.
// ---------------------------------------------------------------------------

/// A delivery can be skipped or changed until this hour (24h clock)
/// on the night before it is due.
const int skipCutoffHour = 22; // 10 PM

/// Most days a customer can have paused at the same time.
const int maxPauseDays = 14;

enum Plan { daily, alternate, custom }

extension PlanInfo on Plan {
  String get label => switch (this) {
        Plan.daily => 'Daily',
        Plan.alternate => 'Alternate',
        Plan.custom => 'Custom',
      };
}

/// Categories that can be subscribed to.
const Set<String> _subscribableCategories = {'Dairy', 'Bakery'};

bool canSubscribe(Product p) => _subscribableCategories.contains(p.category);

class Subscription {
  final Product product;
  final int qty;
  final Plan plan;
  final Set<int> days; // weekdays 1 (Mon) to 7 (Sun), used by Custom
  final DateTime start;

  const Subscription({
    required this.product,
    required this.qty,
    required this.plan,
    required this.days,
    required this.start,
  });

  int get perDelivery => product.price * qty;

  int get deliveriesPerMonth => switch (plan) {
        Plan.daily => 30,
        Plan.alternate => 15,
        Plan.custom => (days.length * 52 / 12).round(),
      };

  int get monthly => perDelivery * deliveriesPerMonth;

  /// Is this product part of the schedule on [date]? (ignores skips)
  bool deliversOn(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    final s = DateTime(start.year, start.month, start.day);
    final diff = d.difference(s).inDays;
    if (diff < 0) return false;

    return switch (plan) {
      Plan.daily => true,
      Plan.alternate => diff % 2 == 0,
      Plan.custom => days.contains(d.weekday),
    };
  }
}

enum DeliveryStatus { scheduled, skipped, paused }

class DeliveryEntry {
  final Subscription sub;
  final DeliveryStatus status;
  const DeliveryEntry(this.sub, this.status);
}

const _wdShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _mnShort = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);
int _dateKey(DateTime d) => d.year * 10000 + d.month * 100 + d.day;
DateTime _fromKey(int k) => DateTime(k ~/ 10000, (k % 10000) ~/ 100, k % 100);

class SubscriptionController extends ChangeNotifier {
  SubscriptionController._();
  static final SubscriptionController instance = SubscriptionController._();

  /// Wallet balance in rupees.
  final ValueNotifier<int> wallet = ValueNotifier<int>(250);

  final Map<String, Subscription> _subs = {};
  final Map<String, Set<int>> _skips = {}; // product id -> skipped date keys
  final Set<int> _pausedKeys = {}; // days when ALL deliveries are paused

  // ----------------------------------------------------------- SUBSCRIPTIONS

  Subscription? of(Product p) => _subs[p.id];

  bool has(Product p) => _subs.containsKey(p.id);

  bool get hasAny => _subs.isNotEmpty;

  int get monthlyTotal => _subs.values.fold(0, (s, e) => s + e.monthly);

  void subscribe(
    Product p,
    int qty,
    Plan plan, {
    Set<int> days = const {},
  }) {
    final now = DateTime.now();
    _subs[p.id] = Subscription(
      product: p,
      qty: qty,
      plan: plan,
      days: Set<int>.of(days),
      start: DateTime(now.year, now.month, now.day + 1), // from tomorrow
    );
    notifyListeners();
  }

  void cancel(Product p) {
    _subs.remove(p.id);
    _skips.remove(p.id);
    if (_subs.isEmpty) _pausedKeys.clear();
    notifyListeners();
  }

  void addMoney(int amount) {
    wallet.value = wallet.value + amount;
  }

  // -------------------------------------------------------- CUTOFF + CHANGES

  /// First date that can still be skipped, paused or changed.
  DateTime get earliestChangeable {
    final now = DateTime.now();
    final add = now.hour < skipCutoffHour ? 1 : 2;
    return DateTime(now.year, now.month, now.day + add);
  }

  bool canChange(DateTime date) =>
      !_dayOnly(date).isBefore(earliestChangeable);

  /// Example: "10 PM on Wed 11 Nov"
  String cutoffText(DateTime date) {
    final d = DateTime(date.year, date.month, date.day - 1);
    final h = skipCutoffHour % 12 == 0 ? 12 : skipCutoffHour % 12;
    final ap = skipCutoffHour >= 12 ? 'PM' : 'AM';
    return '$h $ap on ${_wdShort[d.weekday - 1]} ${d.day} ${_mnShort[d.month - 1]}';
  }

  // -------------------------------------------------------------- SKIPPING

  bool isSkipped(Product p, DateTime date) =>
      _skips[p.id]?.contains(_dateKey(date)) ?? false;

  bool skip(Product p, DateTime date) {
    if (!has(p) || !canChange(date)) return false;
    _skips.putIfAbsent(p.id, () => <int>{}).add(_dateKey(date));
    notifyListeners();
    return true;
  }

  bool unskip(Product p, DateTime date) {
    if (!canChange(date)) return false;
    _skips[p.id]?.remove(_dateKey(date));
    notifyListeners();
    return true;
  }

  // ------------------------------------------------------------ PAUSED DAYS

  bool isPaused(DateTime date) => _pausedKeys.contains(_dateKey(date));

  /// Replaces every paused day that can still be changed with [days].
  /// Days that are already locked keep their current state.
  void setPausedDays(Iterable<DateTime> days) {
    final earliest = earliestChangeable;
    _pausedKeys.removeWhere((k) => !_fromKey(k).isBefore(earliest));
    for (final d in days) {
      final day = _dayOnly(d);
      if (!day.isBefore(earliest)) _pausedKeys.add(_dateKey(day));
    }
    notifyListeners();
  }

  void resumeAll() => setPausedDays(const []);

  /// Upcoming paused days grouped into runs, e.g. 12 Nov and 14 to 16 Nov.
  List<DateTimeRange> get pauseRanges {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final days = _pausedKeys
        .map(_fromKey)
        .where((d) => !d.isBefore(tomorrow))
        .toList()
      ..sort();

    final ranges = <DateTimeRange>[];
    DateTime? start;
    DateTime? prev;

    for (final d in days) {
      if (start == null || prev == null) {
        start = d;
        prev = d;
      } else if (DateTime(d.year, d.month, d.day - 1) == prev) {
        prev = d;
      } else {
        ranges.add(DateTimeRange(start: start, end: prev));
        start = d;
        prev = d;
      }
    }
    if (start != null && prev != null) {
      ranges.add(DateTimeRange(start: start, end: prev));
    }
    return ranges;
  }

  // ------------------------------------------------------------- SCHEDULE

  List<DeliveryEntry> entriesOn(DateTime date) {
    final paused = isPaused(date);

    return _subs.values.where((s) => s.deliversOn(date)).map((s) {
      final status = paused
          ? DeliveryStatus.paused
          : isSkipped(s.product, date)
              ? DeliveryStatus.skipped
              : DeliveryStatus.scheduled;
      return DeliveryEntry(s, status);
    }).toList();
  }

  /// Only the deliveries that will actually go out.
  List<Subscription> deliveriesOn(DateTime date) => entriesOn(date)
      .where((e) => e.status == DeliveryStatus.scheduled)
      .map((e) => e.sub)
      .toList();
}