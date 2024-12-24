import '../../../../../domain/entities/address/saved_addresses_entity.dart';

class AddressModel {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? lang;
  final String? username;

  AddressModel({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.username,
    this.lang,
    this.lat
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      street: json['street'],
      phone: json['phone'],
      city: json['city'],
      lat: json['lat'],
      lang: json['lang'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'lang': lang,
      'username': username,
    };
  }

  SavedAddressesEntity toEntity() {
    return SavedAddressesEntity(
      id: id ?? "",
      city: city ?? "",
      street: street ?? "",
      phone: phone ?? "",
      lat: lat ?? "",
      lang: lang ?? "",
      username: username ?? "",
    );
  }
}
