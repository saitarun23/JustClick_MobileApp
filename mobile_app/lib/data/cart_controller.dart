import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  CartController._();
  static final CartController instance = CartController._();

  final Map<Product, int> _items = {};

  Map<Product, int> get items => Map.unmodifiable(_items);

  int qty(Product p) => _items[p] ?? 0;

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  int get subtotal =>
      _items.entries.fold(0, (s, e) => s + e.key.price * e.value);

  int get savings =>
      _items.entries.fold(0, (s, e) => s + (e.key.mrp - e.key.price) * e.value);

  int get deliveryFee => (subtotal == 0 || subtotal >= 199) ? 0 : 25;

  int get handlingFee => subtotal == 0 ? 0 : 5;

  int get total => subtotal + deliveryFee + handlingFee;

  void add(Product p) {
    _items[p] = qty(p) + 1;
    notifyListeners();
  }

  void remove(Product p) {
    final current = qty(p);
    if (current <= 1) {
      _items.remove(p);
    } else {
      _items[p] = current - 1;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}