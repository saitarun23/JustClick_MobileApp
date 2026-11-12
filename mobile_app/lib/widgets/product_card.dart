import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/cart_controller.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../navigation/open_product.dart';
import 'add_button.dart';
import 'net_image.dart';

Category categoryOf(String name) => categories.firstWhere(
      (c) => c.name == name,
      orElse: () => categories.first,
    );

/// Sticker-style card used in the home rails. Tap to open the product page.
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.imageHeight = 150,
  });

  final Product product;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final cat = categoryOf(product.category);
    final sizes = product.options.length;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => openProduct(context, product),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: AppDeco.sticker(radius: 24, shadow: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17),
                      child: NetImage(
                        url: product.image,
                        fallbackIcon: cat.icon,
                        background: cat.color,
                      ),
                    ),
                  ),
                  if (product.discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: AppDeco.sticker(
                          color: AppColors.sun,
                          radius: 10,
                          shadow: 2,
                          border: 1.8,
                        ),
                        child: Text(
                          '${product.discount}% off',
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: AddButton(product: product),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
                    ),
                  ),
                  Text(
                    sizes > 1 ? '${product.unit} · $sizes sizes' : product.unit,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
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
        ),
      ),
    );
  }
}

/// One line in the cart: a product in one size.
class ProductRow extends StatelessWidget {
  const ProductRow({super.key, required this.line});
  final CartLine line;

  @override
  Widget build(BuildContext context) {
    final product = line.product;
    final v = line.variant;
    final cat = categoryOf(product.category);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 4, 14),
      padding: const EdgeInsets.all(10),
      decoration: AppDeco.sticker(radius: 22, shadow: 3),
      child: Row(
        children: [
          Expanded(
            child: OpenOnTap(
              product: product,
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: NetImage(
                        url: product.image,
                        fallbackIcon: cat.icon,
                        background: cat.color,
                      ),
                    ),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          v.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '₹${v.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          AddButton(product: product, variant: v),
        ],
      ),
    );
  }
}