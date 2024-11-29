class User {
  User({
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
    this.resetCodeVerified,
  });

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
}
