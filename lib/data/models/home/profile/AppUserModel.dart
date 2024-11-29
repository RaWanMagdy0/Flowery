
import '../../../../domain/entities/home_layout/profile/User.dart';
import 'UserModel.dart';

class AppUserModel {
  AppUserModel({
    this.message,
    this.user,
  });

  AppUserModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
  String? message;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

  User? toUser() {
    return User(
      id: user?.id,
      phone: user?.phone,
      firstName: user?.firstName,
      lastName: user?.lastName,
      username: user?.username,
      email: user?.email,
      passwordChangedAt: user?.passwordChangedAt,
      passwordResetCode: user?.passwordResetCode,
      passwordResetExpires: user?.passwordResetExpires,
      resetCodeVerified: user?.resetCodeVerified,
      isVerified: user?.isVerified,

    );
  }
}
