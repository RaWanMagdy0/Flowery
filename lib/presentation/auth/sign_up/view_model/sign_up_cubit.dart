import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../data/models/requests/sign_up_request_model.dart';
import '../../../../domain/use_case/auth/sign_up/sign_up_use_case.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends BaseViewModel<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());

  void signUp(SignUpRequestBodyModel signUpData) async {
    emit(SignUpLoading());
    final response = await _signUpUseCase.invoke(signUpData);

    switch (response) {
      case Success<String?>():
        emit(SignUpSuccess(response.data));

      case Fail<String?>():
        emit(
          SignUpFail(getErrorMassageFromException(response.exception)),
        );
    }
  }
}
