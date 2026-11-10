import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// One basket line = a product in one specific size/variant.
class CartLine {
  const CartLine(this.product, this.variant);
  final Product product;
  final Variant variant;

  @override
  bool operator ==(Object other) =>
      other is CartLine &&
      other.product.id == product.id &&
      other.variant.label == variant.label;

  @override
  int get hashCode => Object.hash(product.id, variant.label);
}

class CartController extends ChangeNotifier {
  CartController._();
  static final CartController instance = CartController._();

  final Map<CartLine, int> _items = {};

  Map<CartLine, int> get items => Map.unmodifiable(_items);

  /// With a variant: quantity of that size. Without: total of the product.
  int qty(Product p, [Variant? v]) {
    if (v != null) return _items[CartLine(p, v)] ?? 0;
    var total = 0;
    for (final e in _items.entries) {
      if (e.key.product.id == p.id) total += e.value;
    }
    return total;
  }

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  int get subtotal =>
      _items.entries.fold(0, (s, e) => s + e.key.variant.price * e.value);

  int get savings => _items.entries.fold(
      0, (s, e) => s + (e.key.variant.mrp - e.key.variant.price) * e.value);

  int get deliveryFee => (subtotal == 0 || subtotal >= 199) ? 0 : 25;

  int get handlingFee => subtotal == 0 ? 0 : 5;

  int get total => subtotal + deliveryFee + handlingFee;

  void add(Product p, [Variant? v]) {
    final line = CartLine(p, v ?? p.defaultVariant);
    _items[line] = (_items[line] ?? 0) + 1;
    notifyListeners();
  }

  void remove(Product p, [Variant? v]) {
    CartLine? line;
    if (v != null) {
      line = CartLine(p, v);
    } else {
      for (final k in _items.keys) {
        if (k.product.id == p.id) {
          line = k;
          break;
        }
      }
    }
    if (line == null || !_items.containsKey(line)) return;

    final current = _items[line]!;
    if (current <= 1) {
      _items.remove(line);
    } else {
      _items[line] = current - 1;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}