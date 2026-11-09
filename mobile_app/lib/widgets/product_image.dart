import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.radius = 14,
    this.iconSize = 36,
  });

  final Product product;
  final double radius;
  final double iconSize;

  IconData get _fallbackIcon {
    return categories
        .firstWhere(
          (c) => c.name == product.category,
          orElse: () => categories.first,
        )
        .icon;
  }

  /// If a Google Images page link was pasted, pull out the real image URL.
  String get _url {
    final raw = product.image.trim();
    if (raw.contains('google.com/imgres')) {
      final real = Uri.tryParse(raw)?.queryParameters['imgurl'];
      if (real != null && real.isNotEmpty) return real;
    }
    return raw;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        _url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stack) {
          debugPrint('IMAGE ERROR for ${product.name}: $error\nURL: $_url');
          return Container(
            color: AppColors.primarySoft,
            alignment: Alignment.center,
            child:
                Icon(_fallbackIcon, size: iconSize, color: AppColors.primary),
          );
        },
      ),
    );
  }
}