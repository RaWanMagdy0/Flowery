import 'Order.dart';

class CreateOrder {
  CreateOrder({
      this.message, 
      this.order,});

  CreateOrder.fromJson(dynamic json) {
    message = json['message'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
  String? message;
  Order? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (order != null) {
      map['order'] = order?.toJson();
    }
    return map;
  }

}