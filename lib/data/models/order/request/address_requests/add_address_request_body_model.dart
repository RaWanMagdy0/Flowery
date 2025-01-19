class AddAddressRequestBody {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  AddAddressRequestBody(
      {this.street, this.phone, this.city, this.username, this.long, this.lat});

  Map<String, dynamic> toJson() => {
        'street': street,
        'phone': phone,
        'city': city,
        'lat': lat,
        'long': long,
        'username': username,
      };
}
