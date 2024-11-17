import '../../../../domain/entities/auth/User.dart';

class UserDto {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? token;

  UserDto({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.gender,
    this.token,
  });

  User toUser() {
    return User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        token: token,
        gender: gender);
  }

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'token': token,
        'gender': gender,
      };
}
