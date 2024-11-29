class UserModel {
  UserModel({
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

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    gender = json['gender'] ?? '';
    phone = json['phone'] ?? '';
    photo = json['photo'] ?? '';
    role = json['role'] ?? '';
    if (json['wishlist'] != null) {
      wishlist = [];
      json['wishlist'].forEach((v) {
        wishlist?.add(WishlistItemModel.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(AddressItemModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<WishlistItemModel>? wishlist;
  List<AddressItemModel>? addresses;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    map['role'] = role;
    if (wishlist != null) {
      map['wishlist'] = wishlist?.map((v) => v.toJson()).toList();
    }
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    return map;
  }
}

class WishlistItemModel {
  WishlistItemModel({this.id, this.name});

  WishlistItemModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class AddressItemModel {
  AddressItemModel({this.street, this.city});

  AddressItemModel.fromJson(dynamic json) {
    street = json['street'];
    city = json['city'];
  }

  String? street;
  String? city;

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
    };
  }
}