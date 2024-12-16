
import '../../../../../domain/entities/order/create_order/order_response_entity.dart';
class OrderResponseModel {
  OrderResponseModel({
    this.message,
    this.orders,
  });

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    orders = json['orders'] != null ? OrderModel.fromJson(json['orders']) : null;
  }

  String? message;
  OrderModel? orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (orders != null) {
      map['orders'] = orders?.toJson();
    }
    return map;
  }
}
class OrderModel {
  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  OrderModel.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItemModel.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    paymentType = json['paymentType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? user;
  List<OrderItemModel>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

  OrderEntity? toEntity() {
    return OrderEntity(
      user: user,
      totalPrice: totalPrice,
      id: id,
      isDelivered: isDelivered ?? false,
      isPaid: isPaid ?? false,
      paymentType: paymentType ?? 'unknown',
      orderItems: orderItems?.map((item) => item.toOrderItems()).toList() ?? [],
    );
  }
}

class OrderItemModel {
  OrderItemModel({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  OrderItemModel.fromJson(dynamic json) {
    product = json['product'];
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  String? product;
  int? price;
  int? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product'] = product;
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }

  OrderItemEntity toOrderItems() {
    return OrderItemEntity(
      id: id,
      product: product,
      price: price,
      quantity: quantity,
    );
  }
}
