import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/dummy_data.dart';
import '../../data/subscription_controller.dart';
import '../../models/product.dart';
import '../../widgets/net_image.dart';
import '../../widgets/product_actions.dart';
import '../../widgets/product_card.dart';

class _Group {
  final String name;
  final IconData icon;
  final List<String> cats;
  const _Group(this.name, this.icon, this.cats);
}

const _groups = [
  _Group('Dairy', Icons.water_drop_outlined, ['Dairy']),
  _Group('Fresh', Icons.eco_outlined, ['Fruits', 'Vegetables']),
  _Group('Pantry', Icons.shopping_basket_outlined,
      ['Snacks', 'Drinks', 'Bakery']),
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  int _group = 0;
  String? _cat; // null = all in the group
  bool _searching = false;
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Product> get _list {
    if (_query.isNotEmpty) {
      return products
          .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
          .toList();
    }
    final cats = _groups[_group].cats;
    return products
        .where((p) =>
            cats.contains(p.category) && (_cat == null || p.category == _cat))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final list = _list;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Padding(
        padding: EdgeInsets.only(top: top + 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            if (_searching) _searchField(),
            const SizedBox(height: 14),
            _tabs(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rail(),
                  Expanded(child: _productList(list)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- HEADER

  Widget _header() {
    final subs = SubscriptionController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: Text('Products', style: AppText.display(30))),
          GestureDetector(
            onTap: () => setState(() {
              _searching = !_searching;
              if (!_searching) {
                _searchCtrl.clear();
                _query = '';
              }
            }),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(
                _searching ? Icons.close_rounded : Icons.search_rounded,
                size: 22,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder<int>(
            valueListenable: subs.wallet,
            builder: (context, balance, _) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_balance_wallet_outlined,
                      color: Colors.white, size: 17),
                  const SizedBox(width: 6),
                  Text(
                    '₹$balance',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
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

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                autofocus: true,
                onChanged: (v) => setState(() => _query = v.trim()),
                decoration: const InputDecoration(
                  hintText: 'Search all products',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------- TABS

  Widget _tabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < _groups.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _group = i;
                  _cat = null;
                  _query = '';
                  _searchCtrl.clear();
                }),
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    Icon(
                      _groups[i].icon,
                      size: 22,
                      color: _group == i
                          ? AppColors.ink
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _groups[i].name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            _group == i ? FontWeight.w800 : FontWeight.w600,
                        color: _group == i
                            ? AppColors.ink
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 3,
                      width: _group == i ? 34 : 0,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(2),
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

  // ------------------------------------------------------------------- RAIL

  Widget _rail() {
    final names = <String?>[null, ..._groups[_group].cats];

    return Container(
      width: 84,
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12, bottom: 130),
        itemCount: names.length,
        itemBuilder: (context, i) {
          final n = names[i];
          final selected = _cat == n;
          final cat = n == null ? null : categoryOf(n);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() {
              _cat = n;
              _query = '';
              _searchCtrl.clear();
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primarySoft : Colors.white,
                border: Border(
                  left: BorderSide(
                    color: selected ? AppColors.accent : Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 46,
                    width: 46,
                    child: ClipOval(
                      child: cat == null
                          ? const ColoredBox(
                              color: AppColors.primarySoft,
                              child: Icon(Icons.apps_rounded,
                                  color: AppColors.primary),
                            )
                          : NetImage(
                              url: cat.image,
                              fallbackIcon: cat.icon,
                              background: cat.color,
                            ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    n ?? 'All',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          selected ? FontWeight.w800 : FontWeight.w600,
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

  // ------------------------------------------------------------ PRODUCT LIST

  Widget _productList(List<Product> list) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 130),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            _query.isNotEmpty
                ? '${list.length} results'
                : '${list.length} Products',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text(
                'Nothing here yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        for (final p in list) _tile(p),
      ],
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }

  Widget _tile(Product p) {
    final cat = categoryOf(p.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: NetImage(
                    url: p.image,
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
                      p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p.unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _chip(p.category, AppColors.primarySoft,
                            AppColors.primary),
                        if (p.discount > 0)
                          _chip('${p.discount}% off', AppColors.accentSoft,
                              AppColors.accent),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹${p.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (p.discount > 0)
                          Text(
                            '₹${p.mrp}',
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
          const SizedBox(height: 12),
          ProductActions(product: p),
        ],
      ),
    );
  }
}