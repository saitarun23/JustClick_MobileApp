import 'package:flutter/foundation.dart';
import '../models/product.dart';

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

class SubscriptionController extends ChangeNotifier {
  SubscriptionController._();
  static final SubscriptionController instance = SubscriptionController._();

  /// Wallet balance in rupees.
  final ValueNotifier<int> wallet = ValueNotifier<int>(250);

  final Map<String, Subscription> _subs = {};

  Subscription? of(Product p) => _subs[p.id];

  bool has(Product p) => _subs.containsKey(p.id);

  int get monthlyTotal => _subs.values.fold(0, (s, e) => s + e.monthly);

  List<Subscription> deliveriesOn(DateTime date) =>
      _subs.values.where((s) => s.deliversOn(date)).toList();

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
    notifyListeners();
  }

  void addMoney(int amount) {
    wallet.value = wallet.value + amount;
  }
}