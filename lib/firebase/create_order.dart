import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/data/models/order/response/create_order/order_model.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create new order in Firebase
  Future<void> createOrder(OrderModel order) async {
    try {
      // Ensure we have a valid order ID
      if (order.id == null || order.id!.isEmpty) {
        throw Exception('Order ID cannot be null or empty');
      }

      // Convert OrderModel to JSON and add timestamp
      final orderData = order.toJson();
      orderData['createdAt'] = FieldValue.serverTimestamp();
      orderData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('orders').doc(order.id).set(orderData);
    } catch (e) {
      print('Error creating order: $e');
      throw e;
    }
  }

  // Get real-time updates for a specific order
  Stream<OrderModel?> getOrderUpdates(String orderId) {
    return _firestore
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return OrderModel.fromJson(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, {
    String? state,
    bool? isDelivered,
    bool? isPaid,
  }) async {
    try {
      final updates = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (state != null) updates['state'] = state;
      if (isDelivered != null) updates['isDelivered'] = isDelivered;
      if (isPaid != null) updates['isPaid'] = isPaid;

      await _firestore.collection('orders').doc(orderId).update(updates);
    } catch (e) {
      print('Error updating order status: $e');
      throw e;
    }
  }

}