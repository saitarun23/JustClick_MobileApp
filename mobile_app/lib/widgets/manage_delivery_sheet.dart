import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/subscription_controller.dart';
import 'net_image.dart';
import 'product_card.dart';
import 'subscribe_sheet.dart';

const _wd = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _mn = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _fmt(DateTime d) => '${_wd[d.weekday - 1]}, ${d.day} ${_mn[d.month - 1]}';

/// Opens the "Pause deliveries" sheet. Tap one day, several days, or any mix.
Future<void> pickPause(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => const _PauseSheet(),
  );
}

class _PauseSheet extends StatefulWidget {
  const _PauseSheet();

  @override
  State<_PauseSheet> createState() => _PauseSheetState();
}

class _PauseSheetState extends State<_PauseSheet> {
  static const _letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  final SubscriptionController subs = SubscriptionController.instance;

  late final DateTime _first;
  late final List<DateTime> _days;
  late final Set<DateTime> _selected;
  late final bool _hadPause;
  bool _limitHit = false;

  @override
  void initState() {
    super.initState();
    _first = subs.earliestChangeable;
    _days = List.generate(
      28,
      (i) => DateTime(_first.year, _first.month, _first.day + i),
    );
    _selected = _days.where(subs.isPaused).toSet();
    _hadPause = _selected.isNotEmpty;
  }

  void _toggle(DateTime d) {
    setState(() {
      if (_selected.contains(d)) {
        _selected.remove(d);
        _limitHit = false;
      } else if (_selected.length >= maxPauseDays) {
        _limitHit = true;
      } else {
        _selected.add(d);
        _limitHit = false;
      }
    });
  }

  void _quick(Iterable<DateTime> days) {
    setState(() {
      _selected
        ..clear()
        ..addAll(days.take(maxPauseDays));
      _limitHit = false;
    });
  }

  void _save() {
    final messenger = ScaffoldMessenger.of(context);
    final n = _selected.length;
    subs.setPausedDays(_selected);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          n == 0
              ? 'Deliveries resumed'
              : 'Deliveries paused for $n day${n == 1 ? '' : 's'}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = _selected.length;
    final last = _days.last;
    final offset = _first.weekday - 1;
    final monthText = _first.month == last.month
        ? '${_mn[_first.month - 1]} ${_first.year}'
        : '${_mn[_first.month - 1]} to ${_mn[last.month - 1]} ${last.year}';
    final canSave = n > 0 || _hadPause;

    final quick = <(String, Iterable<DateTime>)>[
      ('Only ${_fmt(_first)}', _days.take(1)),
      ('Weekend', _days.take(9).where((d) => d.weekday >= 6).take(2)),
      ('Next 3 days', _days.take(3)),
      ('Next 7 days', _days.take(7)),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text('Pause deliveries', style: AppText.display(26)),
            const SizedBox(height: 6),
            Text(
              'Tap one day, a few days, or separate days. You can pause up '
              'to $maxPauseDays days.',
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.4,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final q in quick)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text(q.$1),
                        backgroundColor: AppColors.primarySoft,
                        side: BorderSide.none,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                        onPressed: () => _quick(q.$2),
                      ),
                    ),
                  ActionChip(
                    label: const Text('Clear'),
                    backgroundColor: AppColors.background,
                    side: const BorderSide(color: AppColors.border),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                    onPressed: () => _quick(const []),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              monthText,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              childAspectRatio: 1.6,
              children: [
                for (final l in _letters)
                  Center(
                    child: Text(
                      l,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
              children: [
                for (var i = 0; i < offset; i++) const SizedBox.shrink(),
                for (final d in _days) _cell(d),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Changes for ${_fmt(_first)} close at ${subs.cutoffText(_first)}.',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _limitHit
                  ? 'You can pause up to $maxPauseDays days at a time.'
                  : (n == 0
                      ? 'No days selected'
                      : '$n day${n == 1 ? '' : 's'} selected'),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: _limitHit ? AppColors.error : AppColors.ink,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.ink,
                  disabledBackgroundColor: AppColors.border,
                ),
                onPressed: canSave ? _save : null,
                child: Text(
                  n == 0
                      ? 'Resume all deliveries'
                      : 'Pause $n day${n == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Pausing stops every product on those days. To skip just one '
              'product, tap it in Upcoming deliveries.',
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cell(DateTime d) {
    final on = _selected.contains(d);

    return GestureDetector(
      onTap: () => _toggle(d),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: on ? AppColors.accent : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: on ? AppColors.ink : AppColors.border,
            width: on ? 2 : 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${d.day}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
            if (d.day == 1 || d == _first)
              Text(
                _mn[d.month - 1],
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
              ),
          ],
        ),
      ),
    );
  }
}

/// Opens the "manage this delivery" sheet for one product on one day.
Future<void> showManageDeliverySheet(
  BuildContext context,
  Subscription sub,
  DateTime date,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => _ManageSheet(sub: sub, date: date, parent: context),
  );
}

class _ManageSheet extends StatelessWidget {
  const _ManageSheet({
    required this.sub,
    required this.date,
    required this.parent,
  });

  final Subscription sub;
  final DateTime date;
  final BuildContext parent;

  @override
  Widget build(BuildContext context) {
    final subs = SubscriptionController.instance;
    final p = sub.product;
    final cat = categoryOf(p.category);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
        child: ListenableBuilder(
          listenable: subs,
          builder: (context, _) {
            final paused = subs.isPaused(date);
            final skipped = subs.isSkipped(p, date);
            final canChange = subs.canChange(date);

            final IconData icon;
            final String message;
            final Color bg;
            final Color fg;

            if (paused) {
              icon = Icons.flight_takeoff_rounded;
              message = 'Your deliveries are paused for this day, '
                  'so nothing will arrive.';
              bg = AppColors.accentSoft;
              fg = AppColors.accent;
            } else if (skipped) {
              icon = Icons.event_busy_outlined;
              message = 'This delivery is skipped. You will not be charged '
                  'for it.';
              bg = const Color(0xFFF1EFE9);
              fg = AppColors.textSecondary;
            } else if (!canChange) {
              icon = Icons.lock_outline_rounded;
              message = 'This order is already being prepared, so it can '
                  'no longer be changed.';
              bg = AppColors.accentSoft;
              fg = AppColors.accent;
            } else {
              icon = Icons.schedule_rounded;
              message = 'Arrives on ${_fmt(date)} morning. You can skip or '
                  'change it until ${subs.cutoffText(date)}.';
              bg = AppColors.primarySoft;
              fg = AppColors.primary;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 44,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: NetImage(
                          url: p.image,
                          fallbackIcon: cat.icon,
                          background: cat.color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: AppText.display(21)),
                          const SizedBox(height: 4),
                          Text(
                            '${sub.qty} × ${p.unit} · ${sub.plan.label} plan',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _fmt(date),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: fg, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: fg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (!paused)
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            skipped ? AppColors.ink : AppColors.accent,
                        disabledBackgroundColor: AppColors.border,
                      ),
                      onPressed: canChange
                          ? () {
                              final messenger = ScaffoldMessenger.of(context);
                              final wasSkipped = skipped;

                              if (wasSkipped) {
                                subs.unskip(p, date);
                              } else {
                                subs.skip(p, date);
                              }
                              Navigator.pop(context);

                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    wasSkipped
                                        ? '${p.name} will arrive on '
                                            '${_fmt(date)}'
                                        : '${p.name} skipped for '
                                            '${_fmt(date)}',
                                  ),
                                  action: wasSkipped
                                      ? null
                                      : SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () =>
                                              subs.unskip(p, date),
                                        ),
                                ),
                              );
                            }
                          : null,
                      child: Text(
                        skipped
                            ? 'Resume this delivery'
                            : 'Skip this delivery',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.ink,
                          side: const BorderSide(color: AppColors.border),
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () async {
                          await pickPause(context);
                          if (context.mounted) Navigator.pop(context);
                        },
                        icon: const Icon(Icons.flight_takeoff_rounded,
                            size: 18),
                        label: const Text('Going away?'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.ink,
                          side: const BorderSide(color: AppColors.border),
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          if (parent.mounted) showSubscribeSheet(parent, p);
                        },
                        icon: const Icon(Icons.tune_rounded, size: 18),
                        label: const Text('Edit plan'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'You only pay for deliveries that go out. You can pause up '
                  'to $maxPauseDays days at a time.',
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}