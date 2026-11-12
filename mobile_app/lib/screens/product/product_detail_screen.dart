import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cart_controller.dart';
import '../../data/dummy_data.dart';
import '../../data/subscription_controller.dart';
import '../../models/product.dart';
import '../../widgets/add_button.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_card.dart';
import '../../widgets/subscribe_sheet.dart';

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
    final top = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, top + 10, 21, 10),
      child: Container(
        height: 340,
        decoration: AppDeco.sticker(radius: 32, shadow: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29.5),
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
                top: 12,
                left: 12,
                right: 12,
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
              if (imgs.length > 1)
                Positioned(
                  bottom: 14,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imgs.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 8,
                        width: i == _image ? 24 : 8,
                        decoration: BoxDecoration(
                          color: i == _image ? AppColors.accent : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.ink, width: 1.6),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
        decoration: AppDeco.circle(shadow: 2, border: 2),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

  // ------------------------------------------------------------------ INFO

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: AppDeco.sticker(
              color: AppColors.sky,
              radius: 10,
              shadow: 2,
              border: 1.8,
            ),
            child: Text(
              p.brand.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(p.name, style: AppText.display(30)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                v.label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: AppDeco.sticker(
                  color: AppColors.mint,
                  radius: 10,
                  shadow: 2,
                  border: 1.8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: AppColors.ink),
                    const SizedBox(width: 2),
                    Text(
                      p.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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
                      decoration: AppDeco.sticker(
                        color: AppColors.sun,
                        radius: 12,
                        shadow: 2,
                        border: 1.8,
                      ),
                      child: Text(
                        '${v.discount}% off',
                        style: const TextStyle(
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
            child: Text('Choose size', style: AppText.display(21)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 116,
            child: ListenableBuilder(
              listenable: CartController.instance,
              builder: (context, _) => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 4, 10, 0),
                itemCount: options.length,
                itemBuilder: (context, i) {
                  final o = options[i];
                  final selected = i == _variantIndex;
                  final inCart = CartController.instance.qty(p, o);

                  return GestureDetector(
                    onTap: () => setState(() => _variantIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 120,
                      margin: const EdgeInsets.only(right: 14, bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: AppDeco.sticker(
                        color: selected ? AppColors.sun : Colors.white,
                        radius: 20,
                        shadow: selected ? 4 : 2,
                        border: 2,
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
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              if (inCart > 0)
                                Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: AppDeco.circle(
                                    color: AppColors.accent,
                                    shadow: 0,
                                    border: 1.6,
                                  ),
                                  child: Text(
                                    '$inCart',
                                    style: const TextStyle(
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
                                    fontWeight: FontWeight.w800,
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

  Widget _perk(IconData icon, Color color, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: AppDeco.sticker(
          color: color,
          radius: 20,
          shadow: 3,
          border: 2,
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.ink, size: 24),
            const SizedBox(height: 6),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _perks() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 24, 0),
      child: Row(
        children: [
          _perk(Icons.bolt_rounded, AppColors.sun, '10 min\ndelivery'),
          const SizedBox(width: 12),
          _perk(Icons.verified_outlined, AppColors.mint, 'Quality\nchecked'),
          const SizedBox(width: 12),
          _perk(Icons.replay_rounded, AppColors.pink, 'Easy\nreturns'),
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
          Text('About this product', style: AppText.display(21)),
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
                fontWeight: FontWeight.w800,
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
      padding: const EdgeInsets.fromLTRB(20, 26, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product details', style: AppText.display(21)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: AppDeco.sticker(radius: 24, shadow: 4),
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
            child: Text('You may also like', style: AppText.display(21)),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 256,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 4, 12, 0),
              itemCount: items.length,
              separatorBuilder: (context, i) => const SizedBox(width: 6),
              itemBuilder: (context, i) => SizedBox(
                width: 166,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: ProductCard(product: items[i], imageHeight: 150),
                ),
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
        23,
        12 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.ink, width: 2.2)),
      ),
      child: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          final qty = cart.qty(p, v);

          if (qty == 0) {
            return Row(
              children: [
                if (canSubscribe(p)) ...[
                  Expanded(flex: 2, child: _subscribeButton()),
                  const SizedBox(width: 12),
                ],
                Expanded(flex: 3, child: _addPill()),
              ],
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
                    margin: const EdgeInsets.only(right: 3, bottom: 3),
                    decoration: AppDeco.sticker(
                      color: AppColors.accent,
                      radius: 26,
                      shadow: 3,
                    ),
                    child: Text(
                      '${cart.totalItems} in basket · ₹${cart.subtotal}',
                      style: const TextStyle(fontWeight: FontWeight.w800),
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

  Widget _addPill() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        CartController.instance.add(p, v);
      },
      child: Container(
        height: 56,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 3, bottom: 3),
        decoration: AppDeco.sticker(
          color: AppColors.accent,
          radius: 28,
          shadow: 3,
        ),
        child: Text(
          'Add · ₹${v.price}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _subscribeButton() {
    final subs = SubscriptionController.instance;

    return ListenableBuilder(
      listenable: subs,
      builder: (context, _) {
        final on = subs.has(p);

        return GestureDetector(
          onTap: () => showSubscribeSheet(context, p),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 3, bottom: 3),
            decoration: AppDeco.sticker(
              color: on ? AppColors.mint : Colors.white,
              radius: 28,
              shadow: 3,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (on)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.check_rounded, size: 18),
                  ),
                Text(
                  on ? 'Subscribed' : 'Subscribe',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}