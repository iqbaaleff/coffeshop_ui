import 'coffee_item.dart';

class CartItem {
  final CoffeeItem product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  int get totalPrice => product.price * quantity;
}
