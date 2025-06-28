import 'package:coffeshop_ui/providers/cart_provider.dart';
import 'package:coffeshop_ui/providers/order_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffeshop_ui/models/cart_item.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final int totalPrice;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  String formatCurrency(int value) {
    return 'IDR ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3E5AB),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(title: 'Pesanan Anda:'),
            const SizedBox(height: 10),
            Expanded(child: _buildCartList()),
            const Divider(color: Color(0xff4B2E2B)),
            _buildTotalRow(),
            const SizedBox(height: 20),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Color(0xff4B2E2B)),
      centerTitle: true,
      title: const Text(
        'Checkout',
        style: TextStyle(color: Color(0xff6C9A8B), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            item.product.name,
            style: const TextStyle(color: Color(0xff4B2E2B)),
          ),
          subtitle: Text(
            '${item.quantity}x ${item.product.price}',
            style: const TextStyle(color: Color(0xff6C9A8B)),
          ),
          trailing: Text(
            item.totalPrice.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _buildTotalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff4B2E2B),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          formatCurrency(totalPrice),
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xff4B2E2B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleOrder(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff6C9A8B),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Konfirmasi Pesanan',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _handleOrder(BuildContext context) {
    if (cartItems.isEmpty) return;

    final orderProvider = Provider.of<OrderHistoryProvider>(
      context,
      listen: false,
    );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final order = OrderItem(
      id: DateTime.now().millisecondsSinceEpoch,
      date: DateTime.now().toString().split(' ')[0],
      total: totalPrice,
      address: 'Alamat default',
      notes: '',
      items:
          cartItems
              .map(
                (e) => {
                  'name': e.product.name,
                  'price': e.product.price,
                  'quantity': e.quantity,
                },
              )
              .toList(),
    );

    orderProvider.addOrder(order);
    cartProvider.clearCart();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Terima kasih!'),
            content: const Text('Pesanan Anda sedang diproses.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(); // tutup dialog
                  Navigator.of(context).pop(); // kembali ke halaman sebelumnya
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff4B2E2B),
      ),
    );
  }
}
