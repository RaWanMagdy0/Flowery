import 'dart:convert';

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.token,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        token: json['token'] as String?,
      );
}
