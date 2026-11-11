import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/subscription_controller.dart';
import '../models/product.dart';
import 'net_image.dart';
import 'product_card.dart';

Future<void> showSubscribeSheet(BuildContext context, Product product) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => _SubscribeSheet(product: product),
  );
}

class _SubscribeSheet extends StatefulWidget {
  const _SubscribeSheet({required this.product});
  final Product product;

  @override
  State<_SubscribeSheet> createState() => _SubscribeSheetState();
}

class _SubscribeSheetState extends State<_SubscribeSheet> {
  static const _letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  late int _qty;
  late Plan _plan;
  late Set<int> _days;

  @override
  void initState() {
    super.initState();
    final existing = SubscriptionController.instance.of(widget.product);
    _qty = existing?.qty ?? 1;
    _plan = existing?.plan ?? Plan.daily;
    _days = {...(existing?.days.isNotEmpty == true
        ? existing!.days
        : {1, 2, 3, 4, 5})};
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final subs = SubscriptionController.instance;
    final subscribed = subs.has(p);
    final cat = categoryOf(p.category);

    final preview = Subscription(
      product: p,
      qty: _qty,
      plan: _plan,
      days: _days,
      start: DateTime.now(),
    );
    final canStart = !(_plan == Plan.custom && _days.isEmpty);

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
            const SizedBox(height: 20),

            // Product row with quantity stepper
            Row(
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
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
                        'Pack of $_qty · ${p.unit} · ₹${p.price}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                _stepButton(Icons.remove, () {
                  if (_qty > 1) setState(() => _qty--);
                }),
                SizedBox(
                  width: 34,
                  child: Center(
                    child: Text(
                      '$_qty',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                _stepButton(Icons.add, () => setState(() => _qty++)),
              ],
            ),

            const SizedBox(height: 26),
            const Text(
              'Delivery plan',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const SizedBox(height: 12),

            // Daily / Alternate / Custom
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  for (final plan in Plan.values)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _plan = plan),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _plan == plan
                                ? AppColors.ink
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            plan.label,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _plan == plan
                                  ? Colors.white
                                  : AppColors.ink,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Weekday toggles for Custom
            if (_plan == Plan.custom) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var d = 1; d <= 7; d++)
                    GestureDetector(
                      onTap: () => setState(() {
                        if (_days.contains(d)) {
                          _days.remove(d);
                        } else {
                          _days.add(d);
                        }
                      }),
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _days.contains(d)
                              ? AppColors.accent
                              : AppColors.background,
                          border: Border.all(
                            color: _days.contains(d)
                                ? AppColors.accent
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          _letters[d - 1],
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: _days.contains(d)
                                ? Colors.white
                                : AppColors.ink,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                canStart
                    ? '₹${preview.perDelivery} per delivery · about '
                        '₹${preview.monthly} a month.\n'
                        'Starts tomorrow morning. Pause or stop anytime.'
                    : 'Pick at least one day for your custom plan.',
                style: const TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  disabledBackgroundColor: AppColors.border,
                ),
                onPressed: canStart
                    ? () {
                        final messenger = ScaffoldMessenger.of(context);
                        subs.subscribe(p, _qty, _plan, days: _days);
                        Navigator.pop(context);
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              '${p.name} arrives tomorrow morning',
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  subscribed ? 'Update subscription' : 'Start from tomorrow',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (subscribed)
              Center(
                child: TextButton(
                  onPressed: () {
                    subs.cancel(p);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Stop this subscription',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 18, color: AppColors.ink),
      ),
    );
  }
}