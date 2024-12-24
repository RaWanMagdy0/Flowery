class OrderResponseEntity {
  OrderResponseEntity({
    this.message,
    this.orders,
  });

  String? message;
  OrderEntity? orders;
}

class OrderEntity {
  OrderEntity(
      {this.id,
      this.user,
      this.orderItems,
      this.totalPrice,
      this.paymentType,
      this.isPaid,
      this.isDelivered,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.message});

  String? id;
  String? user;
  List<OrderItemEntity>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? message;
}

class OrderItemEntity {
  OrderItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  String? product;
  int? price;
  int? quantity;
  String? id;
}
