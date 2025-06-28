import 'package:flutter/material.dart';
import 'package:coffeshop_ui/cart_data.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String price;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void _updateQuantity(int newQty) {
    setState(() => _quantity = newQty);
  }

  void _addToCart() {
    cartItems.add({
      'name': widget.name,
      'image': widget.image,
      'price': int.parse(widget.price.replaceAll(RegExp(r'[^0-9]'), '')),
      'quantity': _quantity,
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3E5AB),
      body: Column(
        children: [
          Hero(
            tag: widget.image,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                widget.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                Text(
                  widget.price,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6C9A8B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          const Divider(color: Color(0xff4B2E2B)),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quantity",
                      style: TextStyle(color: Color(0xff4B2E2B)),
                    ),
                    QuantitySelector(
                      quantity: _quantity,
                      onChanged: _updateQuantity,
                    ),
                  ],
                ),

                Expanded(
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton.icon(
                        onPressed: _addToCart,
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Color(0xffF3E5AB),
                        ),
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffF3E5AB),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[800],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
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
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final void Function(int) onChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  void _increment() => onChanged(quantity + 1);
  void _decrement() {
    if (quantity > 1) onChanged(quantity - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff4B2E2B)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrement,
            color: const Color(0xff4B2E2B),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff4B2E2B),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _increment,
            color: const Color(0xff4B2E2B),
          ),
        ],
      ),
    );
  }
}
