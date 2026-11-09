import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(top: 16, bottom: 130),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Explore', style: AppText.display(34)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 4, 20, 22),
              child: Text(
                'Shelf by shelf, everything fresh.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            for (final c in categories) _Shelf(category: c),
          ],
        ),
      ),
    );
  }
}

class _Shelf extends StatelessWidget {
  const _Shelf({required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    final items =
        products.where((p) => p.category == category.name).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    final hasImage = resolveImageUrl(category.image).startsWith('http');
    final textColor = hasImage ? Colors.white : AppColors.ink;

    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    NetImage(
                      url: category.image,
                      fallbackIcon: category.icon,
                      background: category.color,
                    ),
                    if (hasImage)
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xCC000000), Color(0x1A000000)],
                          ),
                        ),
                      ),
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: AppText.display(26, color: textColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${items.length} items',
                            style: TextStyle(
                              color: hasImage
                                  ? Colors.white70
                                  : AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              separatorBuilder: (context, i) => const SizedBox(width: 14),
              itemBuilder: (context, i) => SizedBox(
                width: 150,
                child: ProductCard(product: items[i], imageHeight: 150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}