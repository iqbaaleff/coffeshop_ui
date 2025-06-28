import 'package:coffeshop_ui/screens/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderHistory;

  const OrderHistoryPage({super.key, required this.orderHistory});

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.brown[800],
      ),
      backgroundColor: const Color(0xfff9f4ee),
      body:
          orderHistory.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 80, color: Colors.brown[200]),
                    const SizedBox(height: 16),
                    const Text(
                      "No order history yet.",
                      style: TextStyle(fontSize: 18, color: Colors.brown),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  final order = orderHistory[index];
                  final itemCount = (order['items'] as List).length;

                  return FadeInUp(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(
                          Icons.receipt_long,
                          color: Colors.brown,
                          size: 30,
                        ),
                        title: Text(
                          "Order #${order['id']}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[900],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "$itemCount items • ${order['date']}",
                            style: TextStyle(color: Colors.brown[600]),
                          ),
                        ),
                        trailing: Text(
                          formatCurrency(order['total']),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => OrderDetailPage(order: order),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
