import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cart_controller.dart';
import '../../data/dummy_data.dart';
import '../../models/product.dart';
import '../../widgets/add_button.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_card.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _image = 0;
  int _variantIndex = 0;
  bool _expanded = false;
  bool _liked = false;

  Product get p => widget.product;
  Variant get v => p.options[_variantIndex];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _gallery(),
                  _info(),
                  _variants(),
                  _perks(),
                  _about(),
                  _details(),
                  _similar(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------- GALLERY

  Widget _gallery() {
    final imgs = p.gallery;
    final cat = categoryOf(p.category);

    return SizedBox(
      height: 360,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: imgs.length,
              onPageChanged: (i) => setState(() => _image = i),
              itemBuilder: (context, i) => NetImage(
                url: imgs[i],
                fallbackIcon: cat.icon,
                background: cat.color,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      _circle(
                        Icons.arrow_back_rounded,
                        () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      _circle(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        () => setState(() => _liked = !_liked),
                        color: _liked ? AppColors.accent : AppColors.ink,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (imgs.length > 1)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imgs.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 7,
                      width: i == _image ? 22 : 7,
                      decoration: BoxDecoration(
                        color: i == _image ? AppColors.ink : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _circle(IconData icon, VoidCallback onTap,
      {Color color = AppColors.ink}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  // ------------------------------------------------------------------ INFO

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p.brand.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(p.name, style: AppText.display(30)),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                v.label,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: Colors.white),
                    const SizedBox(width: 2),
                    Text(
                      p.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '(${p.ratingCount} ratings)',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Row(
              key: ValueKey('${v.label}-${v.price}'),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${v.price}', style: AppText.display(34)),
                const SizedBox(width: 10),
                if (v.discount > 0) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '₹${v.mrp}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${v.discount}% off',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Inclusive of all taxes',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------- VARIANTS

  Widget _variants() {
    final options = p.options;
    if (options.length < 2) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Choose size', style: AppText.display(20)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 104,
            child: ListenableBuilder(
              listenable: CartController.instance,
              builder: (context, _) => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final o = options[i];
                  final selected = i == _variantIndex;
                  final inCart = CartController.instance.qty(p, o);

                  return GestureDetector(
                    onTap: () => setState(() => _variantIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 116,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primarySoft : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              selected ? AppColors.primary : AppColors.border,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  o.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              if (inCart > 0)
                                CircleAvatar(
                                  radius: 9,
                                  backgroundColor: AppColors.ink,
                                  child: Text(
                                    '$inCart',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '₹${o.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          if (o.discount > 0)
                            Row(
                              children: [
                                Text(
                                  '₹${o.mrp}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${o.discount}% off',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            )
                          else
                            const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------- PERKS

  Widget _perk(IconData icon, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _perks() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        children: [
          _perk(Icons.bolt_rounded, '10 min\ndelivery'),
          const SizedBox(width: 10),
          _perk(Icons.verified_outlined, 'Quality\nchecked'),
          const SizedBox(width: 10),
          _perk(Icons.replay_rounded, 'Easy\nreturns'),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------- ABOUT

  Widget _about() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About this product', style: AppText.display(20)),
          const SizedBox(height: 10),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: Text(
              p.about,
              maxLines: _expanded ? null : 3,
              overflow:
                  _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Text(
              _expanded ? 'Show less' : 'Read more',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- DETAILS

  Widget _details() {
    final rows = <String, String>{
      'Brand': p.brand,
      'Category': p.category,
      'Pack size': v.label,
      ...p.details,
    };
    final entries = rows.entries.toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product details', style: AppText.display(20)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                for (var i = 0; i < entries.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110,
                          child: Text(
                            entries[i].key,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entries[i].value,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i != entries.length - 1)
                    const Divider(height: 1, color: AppColors.border),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- SIMILAR

  Widget _similar() {
    final items = products
        .where((x) => x.category == p.category && x.id != p.id)
        .toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('You may also like', style: AppText.display(20)),
          ),
          const SizedBox(height: 14),
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

  // ------------------------------------------------------------ BOTTOM BAR

  Widget _bottomBar() {
    final cart = CartController.instance;

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          final qty = cart.qty(p, v);

          if (qty == 0) {
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                cart.add(p, v);
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(26, 8, 8, 8),
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Add to basket',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        '₹${v.price}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Row(
            children: [
              AddButton(product: p, variant: v),
              const SizedBox(width: 14),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Text(
                      '${cart.totalItems} in basket · ₹${cart.subtotal}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}