import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/cart_controller.dart';
import '../models/product.dart';

/// Round "+" sticker that grows into a "- 2 +" pill.
/// Pass [variant] for one specific size, or leave it out for the standard one.
class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.product, this.variant});

  final Product product;
  final Variant? variant;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final qty = cart.qty(product, variant);

        return AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: Alignment.centerRight,
          child: qty == 0
              ? GestureDetector(
                  onTap: () => cart.add(product, variant),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration:
                        AppDeco.circle(color: AppColors.accent, shadow: 2),
                    child: const Icon(Icons.add_rounded,
                        color: AppColors.ink, size: 22),
                  ),
                )
              : Container(
                  height: 38,
                  width: 104,
                  decoration: AppDeco.sticker(
                    color: AppColors.sun,
                    radius: 19,
                    shadow: 2,
                    border: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Step(
                        icon: Icons.remove_rounded,
                        onTap: () => cart.remove(product, variant),
                      ),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      _Step(
                        icon: Icons.add_rounded,
                        onTap: () => cart.add(product, variant),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 34,
        height: 38,
        child: Icon(icon, color: AppColors.ink, size: 19),
      ),
    );
  }
}