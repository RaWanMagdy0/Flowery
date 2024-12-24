import '../../../../../../domain/entities/home_layout/profile/user.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

//GetLoggedUserInfo
class GetLoggedUserInfoLoadingState extends ProfileState {}

class GetLoggedUserInfoSuccessState extends ProfileState {
  final User? user;

  GetLoggedUserInfoSuccessState({this.user});
}

class GetLoggedUserInfoErrorState extends ProfileState {
  final String? errorMessage;

  GetLoggedUserInfoErrorState({this.errorMessage});
}

//EditProfile
class EditProfileLoadingState extends ProfileState {}

class EditProfileSuccessState extends ProfileState {
  final User? user;

  EditProfileSuccessState({this.user});
}

class EditProfileErrorState extends ProfileState {
  final String? errorMessage;

  EditProfileErrorState({this.errorMessage});
}

//UploadPhoto
class UploadPhotoLoadingState extends ProfileState {}

class UploadPhotoSuccessState extends ProfileState {
  final String? message;

  UploadPhotoSuccessState({this.message});
}

class UploadPhotoErrorState extends ProfileState {
  final String? errorMessage;

  UploadPhotoErrorState({this.errorMessage});
}

//LogoutStates
class LogoutSuccessState extends ProfileState {
  String? message;

  LogoutSuccessState(this.message);
}

class LogoutErrorState extends ProfileState {
  String? message;

  LogoutErrorState(this.message);
}
