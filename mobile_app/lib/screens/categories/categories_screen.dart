import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../widgets/product_card.dart';
import '../../widgets/category_image.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final current = categories[_selected];
    final items = products.where((p) => p.category == current.name).toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 88,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      final c = categories[i];
                      final selected = i == _selected;

                      return InkWell(
                        onTap: () => setState(() => _selected = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primarySoft
                                : Colors.white,
                            border: Border(
                              left: BorderSide(
                                color: selected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              CategoryImage(category: c, size: 44),
                              const SizedBox(height: 4),
                              Text(
                                c.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: selected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [for (final p in items) ProductTile(product: p)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
