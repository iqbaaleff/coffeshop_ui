import 'package:flutter/material.dart';

class OrderItem {
  final int id;
  final String date;
  final int total;
  final String address;
  final String notes;
  final List<Map<String, dynamic>> items;

  OrderItem({
    required this.id,
    required this.date,
    required this.total,
    required this.address,
    required this.notes,
    required this.items,
  });
}

class OrderHistoryProvider with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  void addOrder(OrderItem order) {
    _orders.insert(0, order); // ditambahkan di awal
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
