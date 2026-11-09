import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/product.dart';

class CategoryImage extends StatelessWidget {
  const CategoryImage({
    super.key,
    required this.category,
    required this.size,
  });

  final Category category;
  final double size;

  String get _url {
    final raw = category.image.trim();
    if (raw.contains('google.com/imgres')) {
      final real = Uri.tryParse(raw)?.queryParameters['imgurl'];
      if (real != null && real.isNotEmpty) return real;
    }
    return raw;
  }

  Widget get _icon =>
      Icon(category.icon, size: size * 0.55, color: AppColors.primary);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: _url.startsWith('http')
            ? Image.network(
                _url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(child: _icon);
                },
                errorBuilder: (context, error, stack) {
                  debugPrint('CATEGORY IMAGE ERROR ${category.name}: $error');
                  return Center(child: _icon);
                },
              )
            : Center(child: _icon),
      ),
    );
  }
}