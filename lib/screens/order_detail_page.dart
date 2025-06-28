import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailPage({super.key, required this.order});

  String formatCurrency(int number) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(number);
  }

  @override
  Widget build(BuildContext context) {
    final items = order['items'] as List<Map<String, dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        backgroundColor: Colors.brown[800],
      ),
      backgroundColor: const Color(0xfff9f4ee),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #${order['id']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown[900]),
              ),
              const SizedBox(height: 4),
              Text(
                "Date: ${order['date']}",
                style: TextStyle(fontSize: 16, color: Colors.brown[600]),
              ),
              const SizedBox(height: 16),
              const Divider(),

              const Text(
                "Items:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.local_cafe, color: Colors.brown),
                        title: Text(
                          "${item['name']} x${item['quantity']}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          formatCurrency(item['price'] * item['quantity']),
                          style: const TextStyle(color: Colors.brown),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatCurrency(order['total']),
                    style: const TextStyle(fontSize: 18, color: Colors.brown),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (order['address'] != null && order['address'].toString().isNotEmpty)
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.brown),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            order['address'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (order['notes'] != null && order['notes'].toString().isNotEmpty)
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.note, color: Colors.brown),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            order['notes'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
