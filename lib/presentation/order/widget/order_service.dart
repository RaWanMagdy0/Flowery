import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/order/response/create_order/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder(OrderModel order) async {
    try {
      await _firestore.collection('orders').add(order.toJson());
      print("✅ Order added successfully to Firestore!");
    } catch (e) {
      print("❌ Error adding order: $e");
    }
  }
}
