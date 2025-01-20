import 'order_model.dart';

class OrderResponseModel {
  OrderResponseModel({
      this.message, 
      this.orders,});

  OrderResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(OrderModel.fromJson(v));
      });
    }
  }
  String? message;
  List<OrderModel>? orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}