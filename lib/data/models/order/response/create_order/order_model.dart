import 'package:flowery/domain/entities/order/create_order/order_entity.dart';
import 'order_item_model.dart';

class OrderModel {
  OrderModel({
      this.id,
      this.user,
      this.orderItems,
      this.paymentType,
      this.isPaid,
      this.isDelivered,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.orderNumber,
      this.v,});

  OrderModel.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItemModel.fromJson(v));
      });
    }
    paymentType = json['paymentType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderNumber = json['orderNumber'];
    v = json['__v'];
  }
  String? id;
  String? user;
  List<OrderItemModel>? orderItems;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['state'] = state;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['orderNumber'] = orderNumber;
    map['__v'] = v;
    return map;
  }

  OrderEntity? toEntity() {
    return OrderEntity(
      id: id ?? "",
      user: user ?? "",
      paymentType: paymentType ?? "",
      isPaid: isPaid ?? false,
      isDelivered: isDelivered ?? false,
      state: state ?? "",
      orderNumber: orderNumber ?? "",
      orderItems: orderItems?.map((orderItem) => orderItem.toEntity()).toList() ?? [],
    );
  }

}