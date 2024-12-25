import 'dart:convert';

import '../../../../data/models/payment/response/credit_payment_response_model.dart';

class CreditPaymentEntity {
  CreditPaymentEntity({
    this.message,
    this.session,
  });

  String? message;
  SessionEntity? session;
}

class SessionEntity {
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

  SessionEntity({
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
}

class totalDetails {
  totalDetails({
    this.amountDiscount,
    this.amountShipping,
    this.amountTax,
  });

  num? amountDiscount;
  num? amountShipping;
  num? amountTax;
}

class PhoneNumberCollection {
  PhoneNumberCollection({
    this.enabled,
  });

  bool? enabled;
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  Card? card;
}

class Card {
  Card({
    this.requestThreeDSecure,
  });

  String? requestThreeDSecure;
}

class PaymentMethodConfigurationDetails {
  PaymentMethodConfigurationDetails({
    this.id,
    this.parent,
  });

  String? id;
  dynamic parent;
}

class metadata {
  metadata({
    this.city,
    this.phone,
    this.street,
  });

  String? city;
  String? phone;
  String? street;
}

class InvoiceCreation {
  InvoiceCreation({
    this.enabled,
    this.invoiceData,
  });

  bool? enabled;
  InvoiceData? invoiceData;
}

class InvoiceData {
  InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  dynamic accountTaxIds;
  dynamic customFields;
  dynamic description;
  dynamic footer;
  dynamic issuer;
  dynamic metadata;
  dynamic renderingOptions;
}

class CustomerDetails {
  CustomerDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  dynamic address;
  String? email;
  dynamic name;
  dynamic phone;
  String? taxExempt;
  dynamic taxIds;
}

class CustomText {
  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  dynamic afterSubmit;
  dynamic shippingAddress;
  dynamic submit;
  dynamic termsOfServiceAcceptance;
}

class AutomaticTax {
  AutomaticTax({
    this.enabled,
    this.liability,
    this.status,
  });

  bool? enabled;
  dynamic liability;
  dynamic status;
}

class AdaptivePricing {
  AdaptivePricing({
    this.enabled,
  });

  bool? enabled;
}
