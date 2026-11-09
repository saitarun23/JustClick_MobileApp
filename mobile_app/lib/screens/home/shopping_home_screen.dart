import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_card.dart';

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  // Different image heights give the staggered magazine look.
  static const List<double> _heights = [190, 150, 172];

  final PageController _promoController =
      PageController(viewportFraction: 0.88);
  int _promoPage = 0;
  String _query = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  List<Product> get _filtered {
    return products.where((p) {
      final matchCategory =
          _selectedCategory == null || p.category == _selectedCategory;
      final matchQuery = p.name.toLowerCase().contains(_query.toLowerCase());
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final left = <Product>[];
    final right = <Product>[];
    for (var i = 0; i < items.length; i++) {
      (i.isEven ? left : right).add(items[i]);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 130),
          children: [
            _buildHeader(),
            _buildSearch(),
            const SizedBox(height: 22),
            _buildPromos(),
            const SizedBox(height: 22),
            _buildCategories(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _selectedCategory ?? 'Fresh picks',
                    style: AppText.display(26),
                  ),
                  const Spacer(),
                  Text(
                    '${items.length} items',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(Icons.search_off,
                        size: 48, color: AppColors.textSecondary),
                    SizedBox(height: 8),
                    Text(
                      'Nothing matches that',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              )
            else
              _buildMasonry(left, right),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- HEADER

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: logo + name on the left, buttons on the right
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.shopping_basket_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Just Click', style: AppText.display(26)),
                  const Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 7),
                    child: CircleAvatar(
                      radius: 3.5,
                      backgroundColor: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _roundButton(Icons.notifications_none_rounded),
              const SizedBox(width: 10),
              _roundButton(Icons.person_outline_rounded),
            ],
          ),

          const SizedBox(height: 18),

          // Row 2: delivery pill
          Container(
            padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt_rounded, size: 16, color: Colors.white),
                      SizedBox(width: 2),
                      Text(
                        '10 min',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: AppColors.ink,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.ink,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColors.ink,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Row 3: greeting + headline
          Text(
            _greeting,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text("What's on your\ntable today?", style: AppText.display(32)),
        ],
      ),
    );
  }

  Widget _roundButton(IconData icon) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, color: AppColors.ink, size: 22),
    );
  }

  // ---------------------------------------------------------------- SEARCH

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: TextField(
          onChanged: (v) => setState(() => _query = v),
          decoration: const InputDecoration(
            hintText: 'Search fresh picks',
            hintStyle: TextStyle(color: AppColors.textSecondary),
            prefixIcon: Icon(Icons.search, color: AppColors.ink),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- PROMOS

  Widget _buildPromos() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _promoController,
            itemCount: promos.length,
            onPageChanged: (i) => setState(() => _promoPage = i),
            itemBuilder: (context, i) {
              final p = promos[i];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      NetImage(
                        url: p.image,
                        fallbackIcon: Icons.local_grocery_store_outlined,
                        background: p.color,
                        iconColor: Colors.white54,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00000000), Color(0xB3000000)],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 76,
                        bottom: 18,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              style: AppText.display(26, color: Colors.white),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              p.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promos.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 7,
              width: i == _promoPage ? 22 : 7,
              decoration: BoxDecoration(
                color:
                    i == _promoPage ? AppColors.ink : const Color(0xFFD9D2C3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------ CATEGORIES

  Widget _buildCategories() {
    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _pill(
            label: 'All',
            selected: _selectedCategory == null,
            leading: const ColoredBox(
              color: AppColors.primarySoft,
              child:
                  Icon(Icons.apps_rounded, size: 18, color: AppColors.primary),
            ),
            onTap: () => setState(() => _selectedCategory = null),
          ),
          for (final c in categories)
            _pill(
              label: c.name,
              selected: _selectedCategory == c.name,
              leading: NetImage(
                url: c.image,
                fallbackIcon: c.icon,
                background: c.color,
              ),
              onTap: () => setState(
                () => _selectedCategory =
                    _selectedCategory == c.name ? null : c.name,
              ),
            ),
        ],
      ),
    );
  }

  Widget _pill({
    required String label,
    required bool selected,
    required Widget leading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 34,
              width: 34,
              child: ClipOval(child: leading),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: selected ? Colors.white : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------- PRODUCTS

  Widget _buildMasonry(List<Product> left, List<Product> right) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                for (var i = 0; i < left.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: ProductCard(
                      product: left[i],
                      imageHeight: _heights[i % 3],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 34),
              child: Column(
                children: [
                  for (var i = 0; i < right.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22),
                      child: ProductCard(
                        product: right[i],
                        imageHeight: _heights[(i + 1) % 3],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}