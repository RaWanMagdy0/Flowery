import 'package:flowery/domain/entities/order/create_order/order_item_entity.dart';

class OrderEntity {
  OrderEntity({
      this.user, 
      this.orderItems, 
      this.totalPrice, 
      this.paymentType, 
      this.isPaid, 
      this.isDelivered, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  String? user;
  List<OrderItemEntity>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

}