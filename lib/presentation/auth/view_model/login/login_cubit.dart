import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/domain/use_case/auth/login_use_case.dart';
import 'package:flowery/presentation/auth/view_model/login/login_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';

@injectable
class LoginViewModel extends BaseViewModel<LoginScreenState> {
  LogInUseCase logInUseCase;

  LoginViewModel(this.logInUseCase) : super(InitialState());

  void login(String email, String password) async {
    emit(LoadingState());
    var result =
        await logInUseCase.invokeLogIn(email: email, password: password);
    switch (result) {
      case Success<String?>():
        emit(SuccessState(result.data));
      case Fail<String?>():
        emit(ErrorState(result.exception));
    }
  }
}
