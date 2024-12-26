class PaymentRequestModel {
  final ShippingAddressRequest shippingAddress;

  PaymentRequestModel({
    required this.shippingAddress,
  });

  Map<String, dynamic> toJson() => {
        'shippingAddress': shippingAddress.toJson(),
      };

  static PaymentRequestModel fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      shippingAddress: ShippingAddressRequest.fromJson(json['shippingAddress']),
    );
  }
}

// shipping_address_request.dart
class ShippingAddressRequest {
  final String city;
  final String street;
  final String phone;

  ShippingAddressRequest({
    required this.city,
    required this.street,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'shippingAddress': {
          'city': city,
          'street': street,
          'phone': phone,
        }
      };

  static ShippingAddressRequest fromJson(Map<String, dynamic> json) {
    return ShippingAddressRequest(
      city: json['city'],
      street: json['street'],
      phone: json['phone'],
    );
  }
}
