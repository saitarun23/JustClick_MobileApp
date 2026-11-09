import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/cart_controller.dart';
import '../models/product.dart';

/// "ADD" button that turns into a - 1 + stepper.
class QtyControl extends StatelessWidget {
  const QtyControl({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final qty = cart.qty(product);

        if (qty == 0) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => cart.add(product),
            child: Container(
              width: 70,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'ADD',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }

        return Container(
          width: 84,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StepButton(icon: Icons.remove, onTap: () => cart.remove(product)),
              Text(
                '$qty',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _StepButton(icon: Icons.add, onTap: () => cart.add(product)),
            ],
          ),
        );
      },
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

/// Card used in the home grid.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 105,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(product.emoji, style: const TextStyle(fontSize: 54)),
              ),
              if (product.discount > 0)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${product.discount}% OFF',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            product.unit,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    if (product.discount > 0)
                      Text(
                        '₹${product.mrp}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ),
              QtyControl(product: product),
            ],
          ),
        ],
      ),
    );
  }
}

/// Row-style tile used in the category and cart screens.
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(product.emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  product.unit,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹${product.price}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          QtyControl(product: product),
        ],
      ),
    );
  }
}