import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class _BannerData {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> colors;
  const _BannerData(this.title, this.subtitle, this.emoji, this.colors);
}

const _banners = [
  _BannerData('Fresh & Fast', 'Fruits at your door\nin 10 minutes', '🍉',
      [Color(0xFF245C45), Color(0xFF3F8F6B)]),
  _BannerData('Dairy Days', 'Up to 15% off\non milk & eggs', '🥚',
      [Color(0xFFE08A3C), Color(0xFFF2A65A)]),
  _BannerData('Snack Time', 'Munchies for\nevery mood', '🍿',
      [Color(0xFF5B4B8A), Color(0xFF8A78C4)]),
];

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final PageController _bannerController =
      PageController(viewportFraction: 0.9);

  String _query = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildBanners()),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Text(
                _selectedCategory ?? 'Popular picks',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          if (items.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    'No products found 🙈',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ProductCard(product: items[i]),
                  childCount: items.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 262,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, MediaQuery.of(context).padding.top + 14, 16, 18),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '⚡ 10 MIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'JUST CLICK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Deliver to',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const Row(
            children: [
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search "milk", "apples"...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanners() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 140,
        child: PageView.builder(
          controller: _bannerController,
          itemCount: _banners.length,
          itemBuilder: (context, i) {
            final b = _banners[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: b.colors),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          b.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          b.subtitle,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Text(b.emoji, style: const TextStyle(fontSize: 64)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 108,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final c = categories[i];
          final selected = _selectedCategory == c.name;

          return GestureDetector(
            onTap: () => setState(
              () => _selectedCategory = selected ? null : c.name,
            ),
            child: Container(
              width: 76,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: c.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            selected ? AppColors.primary : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: Text(c.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      color:
                          selected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}