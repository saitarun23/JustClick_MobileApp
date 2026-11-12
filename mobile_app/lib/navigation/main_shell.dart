import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../data/cart_controller.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/home/shopping_home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: [
              const ShoppingHomeScreen(),
              const CategoriesScreen(),
              CartScreen(onShop: () => _go(0)),
            ],
          ),
          Positioned(
            left: 20,
            right: 24,
            bottom: MediaQuery.of(context).padding.bottom + 14,
            child: _Dock(index: _index, onChanged: _go),
          ),
        ],
      ),
    );
  }
}

class _Dock extends StatelessWidget {
  const _Dock({required this.index, required this.onChanged});
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: AppDeco.sticker(radius: 34, shadow: 4),
      child: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          final hasItems = cart.totalItems > 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _DockItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: index == 0,
                onTap: () => onChanged(0),
              ),
              _DockItem(
                icon: Icons.explore_rounded,
                label: 'Products',
                selected: index == 1,
                onTap: () => onChanged(1),
              ),
              _DockItem(
                icon: Icons.shopping_basket_rounded,
                label: hasItems
                    ? '${cart.totalItems} · ₹${cart.subtotal}'
                    : 'Basket',
                selected: index == 2,
                highlight: hasItems,
                onTap: () => onChanged(2),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  const _DockItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.highlight = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool highlight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showLabel = selected || highlight;
    final color = highlight
        ? AppColors.accent
        : selected
            ? AppColors.sun
            : Colors.transparent;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Container(
          height: 46,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: showLabel ? 14 : 12),
          decoration: showLabel
              ? AppDeco.sticker(
                  color: color,
                  radius: 23,
                  shadow: 2,
                  border: 2,
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: showLabel ? AppColors.ink : AppColors.textSecondary,
              ),
              if (showLabel) ...[
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}