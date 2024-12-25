import '../../../payment/request/payment_request_model.dart';

class CreateOrderRequest {
  CreateOrderRequest({
    this.shippingAddress,
  });

  CreateOrderRequest.fromJson(dynamic json) {
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddressRequest.fromJson(json['shippingAddress'])
        : null;
  }
  ShippingAddressRequest? shippingAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shippingAddress != null) {
      map['shippingAddress'] = shippingAddress?.toJson();
    }
    return map;
  }
}
