import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/cart_controller.dart';

class CartBar extends StatelessWidget {
  const CartBar({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        if (cart.totalItems == 0) return const SizedBox.shrink();

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag, color: Colors.white),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cart.totalItems} item${cart.totalItems > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '₹${cart.subtotal}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  'View Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}