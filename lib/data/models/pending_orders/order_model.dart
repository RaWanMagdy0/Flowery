import 'package:flowery/data/models/pending_orders/store_model.dart';
import 'package:flowery/data/models/pending_orders/user_model.dart';

import '../../../domain/entities/order/create_order/order_entity.dart';
import '../../../domain/entities/pending_orders/order_entity.dart';
import '../home/profile/user_model.dart';
import 'order_item_model.dart';

class OrderModelDriver {
  OrderModelDriver({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });
  OrderModelDriver.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? UserModelDriver.fromJson(json['user']) : null;
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItemModelDriver.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    paymentType = json['paymentType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderNumber = json['orderNumber'];
    v = json['__v'];
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
  }
  String? id;
  UserModelDriver? user;
  List<OrderItemModelDriver?>? orderItems;
  num? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;
  String? updatedAt;
  String? orderNumber;
  int? v;
  StoreModel? store;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (orderItems != null) {
      map['orderItems'] = orderItems?.map((v) => v?.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['state'] = state;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['orderNumber'] = orderNumber;
    map['__v'] = v;
    if (store != null) {
      map['store'] = store?.toJson();
    }
    return map;
  }

  OrderEntityDriver toEntity() {
    return OrderEntityDriver(
      id: id,
      totalPrice: totalPrice?.toInt(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      store: store?.toEntity(),
      orderItems:
          orderItems?.map((orderItem) => orderItem?.toEntity()).toList() ?? [],
      user: user!.toEntity(),
      orderNumber: orderNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
    );
  }
}
