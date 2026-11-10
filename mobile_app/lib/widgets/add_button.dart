import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/cart_controller.dart';
import '../models/product.dart';

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
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.ink,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 22),
                  ),
                )
              : Container(
                  height: 40,
                  width: 108,
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Step(
                        icon: Icons.remove,
                        onTap: () => cart.remove(product, variant),
                      ),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      _Step(
                        icon: Icons.add,
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
        width: 36,
        height: 40,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}