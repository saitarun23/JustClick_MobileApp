import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/category_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';

class _BannerData {
  final String title;
  final String subtitle;
  final List<Color> colors; // fallback background if the image fails
  final String image; // full banner image URL ('' = colours only)

  const _BannerData(
    this.title,
    this.subtitle,
    this.colors, {
    this.image = '',
  });
}

const _banners = [
  _BannerData(
    'Fresh & Fast',
    'Fruits at your door\nin 10 minutes',
    [Color(0xFF245C45), Color(0xFF3F8F6B)],
    image: 'https://www.google.com/imgres?q=frutis%20all%20products&imgurl=https%3A%2F%2Fimages.contentstack.io%2Fv3%2Fassets%2Fbltcedd8dbd5891265b%2Fbltc68b7ba7fc2156b7%2F665640d9f8aaeaadeabcf466%2Ftypes-of-fuit-hero-1-e1559313304247.jpg%3Fq%3D70%26width%3D3840%26auto%3Dwebp&imgrefurl=https%3A%2F%2Fwww.berries.com%2Farticles%2Ftastes%2Ftypes-of-fruit%3Fsrsltid%3DAYCX9vKN3ENzpf0xipq8tV1neRr4fJLLWfTiJDYsjwyaJS9UYYLBeUVM&docid=Ya_duxuXkmw07M&tbnid=quvocq2p8EIecM&vet=12ahUKEwiP7vD6zPqXAxU3SmwGHRn-E0MQnPAOegQIfBAA..i&w=3840&h=2633&hcb=2&ved=2ahUKEwiP7vD6zPqXAxU3SmwGHRn-E0MQnPAOegQIfBAA',
  ),
  _BannerData(
    'Dairy Days',
    'Up to 15% off\non milk & eggs',
    [Color(0xFFE08A3C), Color(0xFFF2A65A)],
    image: 'https://www.google.com/imgres?q=milk%20and%20egg%20all%20products&imgurl=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Fcheese-bread-milk-eggs-17775774.jpg&imgrefurl=https%3A%2F%2Fwww.dreamstime.com%2Fphotos-images%2Fmilk-eggs.html&docid=giMbmIUcX7ZCEM&tbnid=8QZBrBuQgQIrOM&vet=12ahUKEwien5LNzfqXAxWWT2wGHaqZBq8QnPAOegQIQRAA..i&w=800&h=532&hcb=2&ved=2ahUKEwien5LNzfqXAxWWT2wGHaqZBq8QnPAOegQIQRAA',
  ),
  _BannerData(
    'Snack Time',
    'Munchies for\nevery mood',
    [Color(0xFF5B4B8A), Color(0xFF8A78C4)],
    image: 'https://www.google.com/imgres?q=chips%20all%20products&imgurl=https%3A%2F%2Fm.media-amazon.com%2Fimages%2FI%2F71FAUX9wPiL._AC_UF350%2C350_QL80_.jpg&imgrefurl=https%3A%2F%2Fwww.amazon.in%2FLays-Potato-Chips-Indias-Masala%2Fdp%2FB08Q95QQQR&docid=OTD0IcQvFD0cAM&tbnid=sMU9snyR1kgmrM&vet=12ahUKEwjx1JGAzvqXAxXZWHADHUQ5FDYQnPAOegQIZRAA..i&w=350&h=350&hcb=2&ved=2ahUKEwjx1JGAzvqXAxXZWHADHUQ5FDYQnPAOegQIZRAA',
  ),
];

/// Accepts normal image links, and also Google Images "imgres" page links.
String _resolveImageUrl(String raw) {
  final url = raw.trim();
  if (url.contains('google.com/imgres')) {
    final real = Uri.tryParse(url)?.queryParameters['imgurl'];
    if (real != null && real.isNotEmpty) return real;
  }
  return url;
}
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
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'No products found',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
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
                  mainAxisExtent: 275,
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
        16,
        MediaQuery.of(context).padding.top + 14,
        16,
        18,
      ),
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, size: 14, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      '10 MIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
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
        height: 150,
        child: PageView.builder(
          controller: _bannerController,
          itemCount: _banners.length,
          itemBuilder: (context, i) {
            final b = _banners[i];
            final url = _resolveImageUrl(b.image);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: b.colors),
                borderRadius: BorderRadius.circular(22),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Full banner image
                    if (url.startsWith('http'))
                      Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) {
                          debugPrint('BANNER IMAGE ERROR ${b.title}: $error');
                          return const SizedBox.shrink();
                        },
                      ),

                    // Dark fade on the left so the text is readable
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xCC000000), Color(0x1A000000)],
                        ),
                      ),
                    ),

                    // Text
                    Padding(
                      padding: const EdgeInsets.all(18),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final c = categories[i];
          final selected = _selectedCategory == c.name;

          return GestureDetector(
            onTap: () => setState(
              () => _selectedCategory = selected ? null : c.name,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 76,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 58,
                      width: 58,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                                            child: CategoryImage(category: c, size: 46),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            selected ? FontWeight.w800 : FontWeight.w600,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}