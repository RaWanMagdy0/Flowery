import 'order_model.dart';

class CreateOrderModel {
  CreateOrderModel({
      this.message, 
      this.order,});

  CreateOrderModel.fromJson(dynamic json) {
    message = json['message'];
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
  }
  String? message;
  OrderModel? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (order != null) {
      map['order'] = order?.toJson();
    }
    return map;
  }

}