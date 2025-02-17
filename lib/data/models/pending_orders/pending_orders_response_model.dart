
import 'metadata_model.dart';
import 'order_model.dart';

class PendingOrdersResponseModel {
  PendingOrdersResponseModel({
      this.message, 
      this.metadata, 
      this.orders,});

  PendingOrdersResponseModel.fromJson(dynamic json) {
    message = json['message'];
    metadata = json['metadata'] != null ? MetadataModel.fromJson(json['metadata']) : null;
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(OrderModelDriver.fromJson(v));
      });
    }
  }
  String? message;
  MetadataModel? metadata;
  List<OrderModelDriver>? orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}