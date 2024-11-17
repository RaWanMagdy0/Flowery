import 'dart:convert';

import '../../../../domain/entities/auth/User.dart';

ResetPasswordResponse resetPasswordResponseFromJson(String str) =>
    ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) =>
    json.encode(data.toJson());

class ResetPasswordResponse {
  ResetPasswordResponse({
    this.message,
    this.token,
  });

  ResetPasswordResponse.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }

  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }
}
