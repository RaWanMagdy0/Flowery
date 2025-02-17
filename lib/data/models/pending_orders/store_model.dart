
import '../../../domain/entities/pending_orders/Store.dart';

class StoreModel {
  StoreModel({
      this.name, 
      this.image, 
      this.address, 
      this.phoneNumber, 
      this.latLong,});

  StoreModel.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    latLong = json['latLong'];
  }
  String? name;
  String? image;
  String? address;
  String? phoneNumber;
  String? latLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['address'] = address;
    map['phoneNumber'] = phoneNumber;
    map['latLong'] = latLong;
    return map;
  }
  Store? toEntity(){
  return  Store(
      name: name,
      image: image,
      address: address,
      phoneNumber: phoneNumber,
      latLong: latLong
    );
  }

}