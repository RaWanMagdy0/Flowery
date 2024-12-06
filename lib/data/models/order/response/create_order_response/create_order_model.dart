import '../../../../../domain/entities/address/create_order/order.dart';
import 'order_model.dart';

class CreateOrderModel {
  CreateOrderModel({
    this.message,
    this.order,
  });

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

  OrderEntity? toOrder() {
    return OrderEntity(
      user: order?.user ?? '',
      totalPrice: order?.totalPrice,
      id: order?.id ?? '',
      isDelivered: order?.isDelivered ?? false,
      isPaid: order?.isPaid ?? false,
      paymentType: order?.paymentType ?? 'unknown',
      orderItems:
          order?.orderItems?.map((item) => item.toOrderItems()).toList() ?? [],
    );
  }
}
