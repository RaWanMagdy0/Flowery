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

  factory AddressModel.fromJson(dynamic json) => AddressModel(
        id: json['_id'],
        street: json['street'],
        phone: json['phone'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'street': street,
        'phone': phone,
        'city': city,
      };
}
