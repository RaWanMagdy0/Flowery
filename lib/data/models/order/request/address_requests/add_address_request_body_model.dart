class AddAddressRequestBody {
  final String? street;
  final String? phone;
  final String? city;

  AddAddressRequestBody({
    this.street,
    this.phone,
    this.city,
  });

  Map<String, dynamic> toJson() => {
        'street': street,
        'phone': phone,
        'city': city,
      };
}
