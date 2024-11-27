sealed class LoginScreenState {}

class InitialState extends LoginScreenState {}

class LoadingState extends LoginScreenState {}

class ErrorState extends LoginScreenState {
  String? message;

  ErrorState(this.message);
}

class SuccessState extends LoginScreenState {
  String? user;
  SuccessState(this.user);
}
