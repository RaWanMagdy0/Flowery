import '../../../../data/model/user_model.dart';

sealed class LoginScreenState {}

class InitialState extends LoginScreenState {}

class LoadingState extends LoginScreenState {}

class ErrorState extends LoginScreenState {
  Exception? exception;

  ErrorState(this.exception);
}

class SuccessState extends LoginScreenState {
  UserModel? user;
  SuccessState(this.user);
}
