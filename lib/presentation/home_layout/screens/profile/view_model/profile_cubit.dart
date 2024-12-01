import 'dart:io';
import 'package:flowery/core/api/api_result.dart';
import 'package:flowery/core/base/base_view_model.dart';
import 'package:flowery/data/models/auth/requests/edite_profile_request_model.dart';
import 'package:flowery/domain/use_case/home/profile/edite_profile_use_case.dart';
import 'package:flowery/domain/use_case/home/profile/upload_photo_use_case.dart';
import 'package:flowery/presentation/home_layout/screens/profile/view_model/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../../../../domain/entities/home_layout/profile/User.dart';
import '../../../../../domain/use_case/home/profile/get_logged_user_info_use_case.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final GetLoggedUserInfoUseCase getLoggedUserInfoUseCase;
  final EditeProfileUseCase editeProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;
  ProfileCubit(this.getLoggedUserInfoUseCase, this.editeProfileUseCase,
      this.uploadPhotoUseCase)
      : super(ProfileInitialState());

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
        emit(GetLoggedUserInfoSuccessState(user: result.data));
        firstNameController.text = result.data?.firstName ?? '';
        lastNameController.text = result.data?.lastName ?? '';
        emailController.text = result.data?.email ?? '';
        phoneController.text = result.data?.phone ?? '';
        gender = result.data?.gender;
        photo = result.data?.photo;
        break;
      case Fail<User?>():
        emit(GetLoggedUserInfoErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

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
        break;
      case Fail<User?>():
        emit(EditProfileErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> uploadPhoto(File imageFile) async {
    emit(UploadPhotoLoadingState());

    var result = await uploadPhotoUseCase.invoke(imageFile);
    switch (result) {
      case Success<String?>():
        emit(UploadPhotoSuccessState(message: result.data));
        await getLoggedUserInfo();
        break;
      case Fail<String?>():
        emit(UploadPhotoErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
        break;
    }
  }
}
