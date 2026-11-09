import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import 'add_button.dart';
import 'net_image.dart';

Category categoryOf(String name) => categories.firstWhere(
      (c) => c.name == name,
      orElse: () => categories.first,
    );

/// Borderless magazine-style card. Height follows [imageHeight].
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.imageHeight = 170,
  });

  final Product product;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final cat = categoryOf(product.category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: imageHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: NetImage(
                    url: product.image,
                    fallbackIcon: cat.icon,
                    background: cat.color,
                  ),
                ),
              ),
              if (product.discount > 0)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${product.discount}% off',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: 8,
                bottom: 8,
                child: AddButton(product: product),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.ink,
                ),
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
              Row(
                children: [
                  Text(
                    '₹${product.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (product.discount > 0)
                    Text(
                      '₹${product.mrp}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Compact row used in the cart.
class ProductRow extends StatelessWidget {
  const ProductRow({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cat = categoryOf(product.category);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            height: 76,
            width: 76,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: NetImage(
                url: product.image,
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
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.ink,
                  ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AddButton(product: product),
        ],
      ),
    );
  }
}