import 'dart:convert';

import '../../../../domain/entities/order/payment/credit_card_entity.dart';

class CreditPaymentResponseModel {
  final String? message;
  final Session? session;

  CreditPaymentResponseModel({this.message, this.session});

  factory CreditPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      CreditPaymentResponseModel(
        message: json['message'] as String?,
        session:
            json['session'] != null ? Session.fromJson(json['session']) : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        if (session != null) 'session': session!.toJson(),
      };

  CreditPaymentEntity toEntity() =>
      CreditPaymentEntity(message: message, session: session?.toEntity());
}

class Session {
  final String? id;
  final String? object;
  final num? amountSubtotal;
  final num? amountTotal;
  final String? currency;
  final String? customerEmail;
  final num? expiresAt;
  final Metadata? metadata;
  final String? mode;
  final List<String>? paymentMethodTypes;
  final String? paymentStatus;
  final String? status;
  final String? successUrl;
  final TotalDetails? totalDetails;
  final String? url;

  Session({
    this.id,
    this.object,
    this.amountSubtotal,
    this.amountTotal,
    this.currency,
    this.customerEmail,
    this.expiresAt,
    this.metadata,
    this.mode,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.status,
    this.successUrl,
    this.totalDetails,
    this.url,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json['id'] as String?,
        object: json['object'] as String?,
        amountSubtotal: json['amount_subtotal'] as num?,
        amountTotal: json['amount_total'] as num?,
        currency: json['currency'] as String?,
        customerEmail: json['customer_email'] as String?,
        expiresAt: json['expires_at'] as num?,
        metadata: json['metadata'] != null
            ? Metadata.fromJson(json['metadata'])
            : null,
        mode: json['mode'] as String?,
        paymentMethodTypes:
            (json['payment_method_types'] as List?)?.cast<String>(),
        paymentStatus: json['payment_status'] as String?,
        status: json['status'] as String?,
        successUrl: json['success_url'] as String?,
        totalDetails: json['total_details'] != null
            ? TotalDetails.fromJson(json['total_details'])
            : null,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'amount_subtotal': amountSubtotal,
        'amount_total': amountTotal,
        'currency': currency,
        'customer_email': customerEmail,
        'expires_at': expiresAt,
        if (metadata != null) 'metadata': metadata!.toJson(),
        'mode': mode,
        'payment_method_types': paymentMethodTypes,
        'payment_status': paymentStatus,
        'status': status,
        'success_url': successUrl,
        if (totalDetails != null) 'total_details': totalDetails!.toJson(),
        'url': url,
      };

  SessionEntity toEntity() => SessionEntity(
        id: id,
        object: object,
        amountSubtotal: amountSubtotal,
        amountTotal: amountTotal,
        currency: currency,
        customerEmail: customerEmail,
        expiresAt: expiresAt,
        metadata: metadata?.toEntity(),
        mode: mode,
        paymentMethodTypes: paymentMethodTypes,
        paymentStatus: paymentStatus,
        status: status,
        successUrl: successUrl,
        totalDetails: totalDetails?.toEntity(),
        url: url,
      );
}

class Metadata {
  final String? city;
  final String? phone;
  final String? street;

  Metadata({this.city, this.phone, this.street});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        city: json['city'] as String?,
        phone: json['phone'] as String?,
        street: json['street'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'phone': phone,
        'street': street,
      };

  Metadata toEntity() => Metadata(
        city: city,
        phone: phone,
        street: street,
      );
}

class TotalDetails {
  final num? amountDiscount;
  final num? amountShipping;
  final num? amountTax;

  TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  factory TotalDetails.fromJson(Map<String, dynamic> json) => TotalDetails(
        amountDiscount: json['amount_discount'] as num?,
        amountShipping: json['amount_shipping'] as num?,
        amountTax: json['amount_tax'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'amount_discount': amountDiscount,
        'amount_shipping': amountShipping,
        'amount_tax': amountTax,
      };

  TotalDetails toEntity() => TotalDetails(
        amountDiscount: amountDiscount,
        amountShipping: amountShipping,
        amountTax: amountTax,
      );
}
