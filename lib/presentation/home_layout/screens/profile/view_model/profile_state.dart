import '../../../../../domain/entities/home_layout/profile/User.dart';

sealed class ProfileState {}
final class ProfileInitialState extends ProfileState {}
class GetLoggedUserInfoLoadingState extends ProfileState {}

class GetLoggedUserInfoSuccessState extends ProfileState {
  final User? user;
  GetLoggedUserInfoSuccessState({this.user});
}

class GetLoggedUserInfoErrorState extends ProfileState {
  final String? errorMessage;
  GetLoggedUserInfoErrorState({this.errorMessage});
}
