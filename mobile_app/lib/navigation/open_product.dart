import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/product/product_detail_screen.dart';

void openProduct(BuildContext context, Product product) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => ProductDetailScreen(product: product),
    ),
  );
}

/// Wrap any widget with this to open the product page when it is tapped.
class OpenOnTap extends StatelessWidget {
  const OpenOnTap({super.key, required this.product, required this.child});

  final Product product;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => openProduct(context, product),
      child: child,
    );
  }
}