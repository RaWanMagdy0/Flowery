import '../../../../../domain/entities/address/saved_addresses_entity.dart';

class AddressModel {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;

  AddressModel({
    this.id,
    this.street,
    this.phone,
    this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      street: json['street'],
      phone: json['phone'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'street': street,
      'phone': phone,
      'city': city,
    };
  }

  SavedAddressesEntity toEntity() {
    return SavedAddressesEntity(
      id: id ?? "",
      city: city ?? "",
      street: street ?? "",
      phone: phone ?? "",
    );
  }
}
