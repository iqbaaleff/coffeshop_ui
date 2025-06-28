import 'package:coffeshop_ui/models/coffee_item.dart';

/// Dummy data menu kopi yang digunakan untuk testing / UI preview.
const List<CoffeeItem> dummyCoffeeMenu = [
  CoffeeItem(
    name: 'Espresso',
    price: 25000,
    image: 'assets/images/espresso.jpeg',
    description: 'Kopi hitam murni yang kuat dan penuh aroma.',
  ),
  CoffeeItem(
    name: 'Cappuccino',
    price: 30000,
    image: 'assets/images/cappuccino.jpeg',
    description: 'Kopi dengan susu dan foam, lembut dan creamy.',
  ),
  CoffeeItem(
    name: 'Latte',
    price: 28000,
    image: 'assets/images/latte.jpeg',
    description: 'Perpaduan espresso dan susu panas yang seimbang.',
  ),
];
