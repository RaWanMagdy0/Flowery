import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/api_result.dart';
import '../../../../../../core/base/base_view_model.dart';
import '../../../../../../data/models/auth/requests/edite_profile_request_model.dart';
import '../../../../../../domain/entities/home_layout/profile/User.dart';
import '../../../../../../domain/use_case/auth/logout_use_case.dart';
import '../../../../../../domain/use_case/home/profile/edite_profile_use_case.dart';
import '../../../../../../domain/use_case/home/profile/get_logged_user_info_use_case.dart';
import '../../../../../../domain/use_case/home/profile/upload_photo_use_case.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedUserInfoUseCase getLoggedUserInfoUseCase;
  final EditeProfileUseCase editeProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileCubit(
      this.getLoggedUserInfoUseCase,
      this.editeProfileUseCase,
      this.logoutUseCase,
      this.uploadPhotoUseCase,
      ) : super(ProfileInitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? gender;
  String? photo;

  Future<void> getLoggedUserInfo() async {
    emit(GetLoggedUserInfoLoadingState());
    var result = await getLoggedUserInfoUseCase.invoke();

    switch (result) {
      case Success<User?>():
        var user = result.data;
        emit(GetLoggedUserInfoSuccessState(user: user));
        firstNameController.text = user?.firstName ?? '';
        lastNameController.text = user?.lastName ?? '';
        emailController.text = user?.email ?? '';
        phoneController.text = user?.phone ?? '';
        gender = user?.gender;
        photo = user?.photo;
        break;
      case Fail<User?>():
        emit(GetLoggedUserInfoErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  // Update user profile
  Future<void> editeProfile() async {
    EditeProfileRequestModel editeProfile = EditeProfileRequestModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    emit(EditProfileLoadingState());

    var result = await editeProfileUseCase.invoke(editeProfile);
    switch (result) {
      case Success<User?>():
        final updatedUser = result.data;
        firstNameController.text = updatedUser?.firstName ?? '';
        lastNameController.text = updatedUser?.lastName ?? '';
        emailController.text = updatedUser?.email ?? '';
        phoneController.text = updatedUser?.phone ?? '';
        emit(EditProfileSuccessState(user: updatedUser));
        await getLoggedUserInfo();
        break;
      case Fail<User?>():
        emit(EditProfileErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  // Profile form validation
  bool isFormField = true;
  String titleAppBar() {
    return isFormField ? "Profile" : "Update";
  }

  void changeFormField(bool isValid) {
    emit(ProfileInitialState());
    isFormField = isValid;
  }

  // Upload profile photo
  Future<void> uploadPhoto(File photo) async {
    emit(UploadPhotoLoadingState());
    var result = await uploadPhotoUseCase.invoke(photo);

    if (result is Success<String?>) {
      emit(UploadPhotoSuccessState(message: result.data));
      await getLoggedUserInfo();
    } else if (result is Fail<String?>) {
      emit(UploadPhotoErrorState(
          errorMessage: getErrorMassageFromException(result.exception)));
      debugPrint("Upload failed: ${result.exception}");
    }
  }

  // Logout the user
  Future<void> logout() async {
    final response = await logoutUseCase.invoke();
    switch (response) {
      case Success<String?>():
        emit(LogoutSuccessState(response.data));
      case Fail<String?>():
        emit(
            LogoutErrorState(getErrorMassageFromException(response.exception)));
    }
  }
}
