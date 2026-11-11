import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../data/cart_controller.dart';
import '../data/subscription_controller.dart';
import '../models/product.dart';
import 'subscribe_sheet.dart';

class ProductActions extends StatelessWidget {
  const ProductActions({super.key, required this.product, this.height = 40});

  final Product product;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    final subs = SubscriptionController.instance;

    return Row(
      children: [
        if (canSubscribe(product)) ...[
          Expanded(
            child: ListenableBuilder(
              listenable: subs,
              builder: (context, _) {
                final on = subs.has(product);
                return GestureDetector(
                  onTap: () => showSubscribeSheet(context, product),
                  child: Container(
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: on ? AppColors.primarySoft : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: on ? AppColors.primary : AppColors.ink,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (on)
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.check_rounded,
                                size: 15, color: AppColors.primary),
                          ),
                        Text(
                          on ? 'Subscribed' : 'Subscribe',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: on ? AppColors.primary : AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: ListenableBuilder(
            listenable: cart,
            builder: (context, _) {
              final qty = cart.qty(product);

              if (qty == 0) {
                return GestureDetector(
                  onTap: () => cart.add(product),
                  child: Container(
                    height: height,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.ink,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _step(Icons.remove, () => cart.remove(product)),
                    Text(
                      '$qty',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    _step(Icons.add, () => cart.add(product)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _step(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: double.infinity,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}