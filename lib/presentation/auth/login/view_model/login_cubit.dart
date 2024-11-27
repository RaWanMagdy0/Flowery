import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/use_case/auth/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginViewModel extends BaseViewModel<LoginScreenState> {
  LogInUseCase logInUseCase;

  LoginViewModel(this.logInUseCase) : super(InitialState());

  void login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoadingState());
    var result = await logInUseCase.invoke(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
    switch (result) {
      case Success<String?>():
        emit(SuccessState(result.data));
      case Fail<String?>():
        emit(ErrorState(getErrorMassageFromException(result.exception)));
    }
  }
}
