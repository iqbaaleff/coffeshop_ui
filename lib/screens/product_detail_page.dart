import 'package:flutter/material.dart';
import 'package:coffeshop_ui/models/coffee_item.dart';
import 'package:provider/provider.dart';
import 'package:coffeshop_ui/providers/cart_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final CoffeeItem item;

  String formatCurrency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}';
  }

  const ProductDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xffF3E5AB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xff4B2E2B)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          item.name,
          style: const TextStyle(
            color: Color(0xff4B2E2B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  32,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: item.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        item.image,
                        width: double.infinity,
                        height: screenWidth * 0.55,
                        fit: BoxFit.cover,
                        cacheWidth: (screenWidth * 2).toInt(),
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4B2E2B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatCurrency(item.price),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff6C9A8B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff4B2E2B),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const Spacer(),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Tambah ke Keranjang',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff6C9A8B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      final cart = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      cart.addToCart(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${item.name} ditambahkan ke keranjang!',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
