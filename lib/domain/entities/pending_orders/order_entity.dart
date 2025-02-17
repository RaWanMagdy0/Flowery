import 'package:flowery/domain/entities/pending_orders/driver.dart';
import 'Store.dart';
import 'order_item.dart';

class OrderEntityDriver {
  OrderEntityDriver({
      this.id, 
      this.user, 
      this.orderItems, 
      this.totalPrice, 
      this.paymentType, 
      this.isPaid, 
      this.isDelivered, 
      this.state, 
      this.createdAt, 
      this.updatedAt, 
      this.orderNumber, 
      this.v, 
      this.store,});

  String? id;
  Driver? user;
  List<OrderItemDriver?>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;
  Store? store;


}