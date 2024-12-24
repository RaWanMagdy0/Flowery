import 'address_model.dart';

class AddressResponseModel {
  final String? message;
  final List<AddressModel>? addresses;

  AddressResponseModel({
    this.message,
    this.addresses,
  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) =>
      AddressResponseModel(
        message: json['message'],
        addresses: json['addresses'] != null
            ? List<AddressModel>.from(
                json['addresses'].map((x) => AddressModel.fromJson(x)))
            : [],
      );
}
