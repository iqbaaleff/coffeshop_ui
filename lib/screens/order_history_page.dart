import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeshop_ui/providers/order_history_provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  String formatCurrency(int value) {
    return 'IDR ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderHistoryProvider>(context).orders;

    return Scaffold(
      backgroundColor: const Color(0xffF3E5AB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff4B2E2B)),
        centerTitle: true,
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            color: Color(0xff6C9A8B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          orders.isEmpty
              ? const Center(
                child: Text(
                  'Belum ada pesanan.',
                  style: TextStyle(
                    color: Color(0xff4B2E2B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return _buildOrderCard(order);
                },
              ),
    );
  }

  Widget _buildOrderCard(dynamic order) {
    return Card(
      color: const Color(0xffFFF8DC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xff4B2E2B)),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal: ${order.date}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff4B2E2B),
              ),
            ),
            const SizedBox(height: 6),
            ...order.items.map<Widget>(
              (item) => Text(
                '${item['quantity']}x ${item['name']} - ${formatCurrency(item['price'])}',
                style: const TextStyle(color: Color(0xff6C9A8B)),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Total: ${formatCurrency(order.total)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff4B2E2B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
