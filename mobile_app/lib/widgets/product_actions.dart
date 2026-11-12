import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
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

    return Padding(
      padding: const EdgeInsets.only(right: 3, bottom: 3),
      child: Row(
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
                      decoration: AppDeco.sticker(
                        color: on ? AppColors.mint : Colors.white,
                        radius: 14,
                        shadow: 2,
                        border: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (on)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_rounded,
                                  size: 15, color: AppColors.ink),
                            ),
                          Text(
                            on ? 'Subscribed' : 'Subscribe',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
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
                      decoration: AppDeco.sticker(
                        color: AppColors.sun,
                        radius: 14,
                        shadow: 2,
                        border: 2,
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  height: height,
                  decoration: AppDeco.sticker(
                    color: AppColors.sun,
                    radius: 14,
                    shadow: 2,
                    border: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _step(Icons.remove_rounded, () => cart.remove(product)),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      _step(Icons.add_rounded, () => cart.add(product)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _step(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: double.infinity,
        child: Icon(icon, color: AppColors.ink, size: 19),
      ),
    );
  }
}