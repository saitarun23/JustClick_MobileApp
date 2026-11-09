import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
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
            right: 20,
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
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(33),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
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
                label: 'Explore',
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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Container(
          height: 46,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: showLabel ? 16 : 14),
          decoration: BoxDecoration(
            color: highlight
                ? AppColors.accent
                : selected
                    ? const Color(0x26FFFFFF)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(23),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: Colors.white),
              if (showLabel) ...[
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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