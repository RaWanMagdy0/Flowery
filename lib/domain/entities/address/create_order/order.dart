import 'order_item.dart';

class Order {
  Order({
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

  Order.fromJson(dynamic json) {
    user = json['user'];
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItems.fromJson(v));
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
  List<OrderItems>? orderItems;
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