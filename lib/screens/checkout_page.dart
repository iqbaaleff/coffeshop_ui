import 'package:flutter/material.dart';
import 'package:coffeshop_ui/cart_data.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.brown[800],
      ),
      backgroundColor: Colors.brown[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ringkasan Pesanan
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text('${item['name']} x${item['quantity']}'),
                    trailing: Text('Rp ${item['price'] * item['quantity']}'),
                  );
                },
              ),
            ),

            const Divider(),

            // Input alamat
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Delivery Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),

            // Catatan
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Total + Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Rp $totalPrice',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter delivery address")),
                  );
                  return;
                }

                // TODO: Kirim ke backend / simpan pesanan
                cartItems.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );

                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}
