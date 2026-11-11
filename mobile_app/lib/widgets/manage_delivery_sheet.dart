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

/// Lets the customer pause every delivery for a date range (going away).
Future<void> pickPause(BuildContext context) async {
  final subs = SubscriptionController.instance;
  final messenger = ScaffoldMessenger.of(context);
  final first = subs.earliestChangeable;

  final range = await showDateRangePicker(
    context: context,
    firstDate: first,
    lastDate: DateTime(first.year, first.month, first.day + 90),
    helpText: 'Pause deliveries',
    saveText: 'Pause',
  );
  if (range == null) return;

  final days = range.end.difference(range.start).inDays + 1;
  if (days > maxPauseDays) {
    messenger.showSnackBar(
      SnackBar(
        content: Text('You can pause up to $maxPauseDays days at a time.'),
      ),
    );
    return;
  }

  subs.setPause(range);
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        'Deliveries paused from ${_fmt(range.start)} to ${_fmt(range.end)}',
      ),
    ),
  );
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
                  'You only pay for deliveries that go out. Pauses can be up '
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