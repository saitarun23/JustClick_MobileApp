import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cart_controller.dart';
import '../../widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.onShop});
  final VoidCallback onShop;

  static const int _freeDeliveryAt = 199;

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: cart,
          builder: (context, _) {
            if (cart.totalItems == 0) return _empty();

            final entries = cart.items.entries.toList();

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
              children: [
                Text('Your basket', style: AppText.display(34)),
                const SizedBox(height: 4),
                Text(
                  '${cart.totalItems} items · arriving in about 10 min',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 18),
                _deliveryBar(cart.subtotal),
                const SizedBox(height: 22),
                for (final e in entries) ProductRow(product: e.key),
                const SizedBox(height: 6),
                _receipt(cart),
                const SizedBox(height: 20),
                _payButton(context, cart),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_basket_outlined,
                size: 44,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text('Your basket is empty', style: AppText.display(26)),
            const SizedBox(height: 8),
            const Text(
              'Add a few fresh things to get started.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 22),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              ),
              onPressed: onShop,
              child: const Text('Browse fresh picks'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliveryBar(int subtotal) {
    if (subtotal >= _freeDeliveryAt) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'You unlocked free delivery',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      );
    }

    final remaining = _freeDeliveryAt - subtotal;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined,
                  size: 20, color: AppColors.accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Add ₹$remaining more for free delivery',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (subtotal / _freeDeliveryAt).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.white,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _receipt(CartController cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _row('Item total', '₹${cart.subtotal}'),
          _row(
            'Delivery',
            cart.deliveryFee == 0 ? 'FREE' : '₹${cart.deliveryFee}',
          ),
          _row('Handling', '₹${cart.handlingFee}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: _DottedLine(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('To pay', style: AppText.display(22)),
              Text('₹${cart.total}', style: AppText.display(22)),
            ],
          ),
          if (cart.savings > 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Icon(Icons.savings_outlined,
                      size: 18, color: AppColors.success),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'You saved ₹${cart.savings} on this order',
                      style: const TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _payButton(BuildContext context, CartController cart) {
    return GestureDetector(
      onTap: () => _placeOrder(context, cart),
      child: Container(
        height: 64,
        padding: const EdgeInsets.fromLTRB(26, 8, 8, 8),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            const Text(
              'Place order',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Text(
                    '₹${cart.total}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(BuildContext context, CartController cart) {
    final total = cart.total;
    cart.clear();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 76,
              width: 76,
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 18),
            Text('Order placed', style: AppText.display(28)),
            const SizedBox(height: 8),
            Text(
              '₹$total · arriving in about 10 minutes',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.ink,
                ),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    ).then((_) => onShop());
  }
}

class _DottedLine extends StatelessWidget {
  const _DottedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final count = (box.maxWidth / 8).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => const SizedBox(
              width: 4,
              height: 1.5,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFCFC8B8)),
              ),
            ),
          ),
        );
      },
    );
  }
}