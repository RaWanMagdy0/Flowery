
class EditeProfileRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  EditeProfileRequestModel(
      {this.email, this.lastName, this.firstName, this.phone,});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["email"] = email;
    map["phone"] = phone;
    return map;
  }
}
