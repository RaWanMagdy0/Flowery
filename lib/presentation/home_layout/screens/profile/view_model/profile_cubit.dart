import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/presentation/home_layout/screens/profile/view_model/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entities/home_layout/profile/User.dart';
import '../../../../../domain/use_case/home/profile/get_logged_user_info_use_case.dart';
@injectable

class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedUserInfoUseCase getLoggedUserInfoUseCase;
  ProfileCubit(this.getLoggedUserInfoUseCase) : super(ProfileInitialState());

  var formKey=GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedUserInfoLoadingState());
    var result = await getLoggedUserInfoUseCase.invoke();
    switch (result) {
      case Success<User?>():
        emit(GetLoggedUserInfoSuccessState(user: result.data));
        firstNameController.text = result.data?.firstName ?? '';
        lastNameController.text = result.data?.lastName ?? '';
        emailController.text = result.data?.email ?? '';
        phoneController.text = result.data?.phone ?? '';
        break;
      case Fail<User?>():
        emit(GetLoggedUserInfoErrorState(errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

}
