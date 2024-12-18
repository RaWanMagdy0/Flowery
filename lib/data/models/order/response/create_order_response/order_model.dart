import '../../../../../domain/entities/order/create_order/order_entity.dart';
import 'order_item_model.dart';

class OrderModel {
  OrderModel({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.message,
  });

  OrderModel.fromJson(dynamic json) {
    final orders = json['orders'];
    if (orders != null) {
      user = orders['user'];
      if (orders['orderItems'] != null) {
        orderItems = [];
        orders['orderItems'].forEach((v) {
          orderItems?.add(OrderItemModel.fromJson(v));
        });
      }
      totalPrice = orders['totalPrice'];
      paymentType = orders['paymentType'];
      isPaid = orders['isPaid'];
      isDelivered = orders['isDelivered'];
      id = orders['_id'];
      createdAt = orders['createdAt'];
      updatedAt = orders['updatedAt'];
      v = orders['__v'];
    }
    message = json['message'];
  }

  String? user;
  List<OrderItemModel>? orderItems;
  int? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['message'] = message;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['_id'] = id;
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