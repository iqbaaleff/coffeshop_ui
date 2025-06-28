import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/coffee_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addToCart(CoffeeItem item) {
    final index = _items.indexWhere((e) => e.product.name == item.name);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: item));
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
