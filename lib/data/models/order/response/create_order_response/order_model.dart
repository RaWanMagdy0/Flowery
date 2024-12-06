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
      this.v,});

  OrderModel.fromJson(dynamic json) {
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
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}