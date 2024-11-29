class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<WishlistItem>? wishlist;
  List<AddressItem>? addresses;
  String? createdAt;

}
class WishlistItem {
  WishlistItem({this.id, this.name});

  String? id;
  String? name;

}

class AddressItem {
  AddressItem({this.street, this.city});

  String? street;
  String? city;

}