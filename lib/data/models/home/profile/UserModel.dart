class UserModel {
  UserModel({
      this.id, 
      this.username, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone, 
      this.role, 
      this.isVerified, 
      this.createdAt, 
      this.passwordChangedAt, 
      this.passwordResetCode, 
      this.passwordResetExpires, 
      this.resetCodeVerified,});

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    passwordChangedAt = json['passwordChangedAt'];
    passwordResetCode = json['passwordResetCode'];
    passwordResetExpires = json['passwordResetExpires'];
    resetCodeVerified = json['resetCodeVerified'];
  }
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? createdAt;
  String? passwordChangedAt;
  String? passwordResetCode;
  String? passwordResetExpires;
  bool? resetCodeVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['isVerified'] = isVerified;
    map['createdAt'] = createdAt;
    map['passwordChangedAt'] = passwordChangedAt;
    map['passwordResetCode'] = passwordResetCode;
    map['passwordResetExpires'] = passwordResetExpires;
    map['resetCodeVerified'] = resetCodeVerified;
    return map;
  }

}