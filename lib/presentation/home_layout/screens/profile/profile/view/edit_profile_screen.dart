import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/core/di/di.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/core/utils/functions/validators/validators.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/core/utils/widget/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../domain/entities/home_layout/profile/User.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit viewModel;
  String? gender;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("Edit Profile"),
        leading: const Icon(Icons.arrow_back_ios),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is GetLoggedUserInfoLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.pinkLoadingAnimation),
            );
          } else if (state is GetLoggedUserInfoErrorState) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          } else if (state is GetLoggedUserInfoSuccessState) {
            gender = state.user?.gender;
            return _buildProfileForm(state.user!);
          } else if (state is EditProfileLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.pinkLoadingAnimation),
            );
          } else if (state is EditProfileErrorState) {
            return Center(
              child: Text(state.errorMessage ??
                  'An error occurred while updating the profile'),
            );
          } else if (state is EditProfileSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showSuccessDialog(
                  context: context,
                  message: "Profile updated successfully",
                  whenAnimationFinished: () {
                    Navigator.pop(context);
                  });
            });
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildProfileForm(User user) {
    bool isUserProfile;
    if (user.photo ==
        "https://flower.elevateegy.com/uploads/default-profile.png") {
      isUserProfile = false;
    } else {
      isUserProfile = true;
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: Stack(
              children: [
                ClipOval(
                    child: isUserProfile
                        ? Image.network(
                            user.photo ?? "",
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.kLighterGrey,
                            child: Icon(
                              Icons.person,
                              size: 90.sp,
                              color: AppColors.kGray,
                            ),
                          )),
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: () async {
                      await uploadImage();
                    },
                    child: Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.kBabyPink,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 15.sp,
                        color: AppColors.kGray,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: viewModel.firstNameController,
                          hintText: user.firstName ?? '',
                          labelText: "First Name",
                          validator: (value) => Validators.validateNotEmpty(
                            value: value,
                            title: "First Name",
                          ),
                          onChanged: (value) => _checkChanges(user),
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          controller: viewModel.lastNameController,
                          hintText: user.lastName ?? '',
                          labelText: "Last Name",
                          validator: (value) => Validators.validateNotEmpty(
                            value: value,
                            title: "Last Name",
                          ),
                          onChanged: (value) => _checkChanges(user),
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    hintText: user.email ?? '',
                    labelText: "Email",
                    validator: (value) => Validators.validateEmail(value),
                    onChanged: (value) => _checkChanges(user),
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    controller: viewModel.phoneController,
                    hintText: user.phone ?? '',
                    labelText: "Phone",
                    validator: (value) => Validators.validatePhoneNumber(value),
                    onChanged: (value) => _checkChanges(user),
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    onChanged: (value) => _checkChanges(user),
                    hintText: "***********",
                    labelText: "",
                    controller: TextEditingController(text: "**********"),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRouteName.changePassword);
                        },
                        child: Text(
                          "Change",
                          style: AppFonts.font12PinkWeight600,
                        ),
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Gender",
                          style:
                              TextStyle(fontSize: 16, color: AppColors.kGray),
                        ),
                        50.horizontalSpace,
                        Row(
                          children: [
                            Radio(
                              value: "female",
                              groupValue: viewModel.gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  viewModel.gender = value as String?;
                                });
                              },
                            ),
                            Text("Female"),
                            16.horizontalSpace,
                            Radio(
                              value: "male",
                              groupValue: viewModel.gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  viewModel.gender = value as String?;
                                });
                              },
                            ),
                            Text("Male"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  CustomButton(
                    onPressed: hasChanges
                        ? () async {
                            if (viewModel.formKey.currentState!.validate()) {
                              await viewModel.editeProfile();
                              setState(() {
                                user.firstName =
                                    viewModel.firstNameController.text;
                                user.lastName =
                                    viewModel.lastNameController.text;
                                user.email = viewModel.emailController.text;
                                user.phone = viewModel.phoneController.text;
                                user.gender = viewModel.gender;
                                hasChanges = false;
                              });
                            }
                          }
                        : null,
                    text: "Update",
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    height: 53.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: 'profile.jpg')
      });
      try {
        await viewModel.uploadPhoto(formData);
        if (mounted) {
          setState(() {
            viewModel.getLoggedUserInfo();
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error uploading image, please try again.")),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            "No image selected. Please select an image.",
          )),
        );
      }
    }
  }

  void _checkChanges(User user) {
    setState(() {
      hasChanges = viewModel.firstNameController.text != user.firstName ||
          viewModel.lastNameController.text != user.lastName ||
          viewModel.emailController.text != user.email ||
          viewModel.phoneController.text != user.phone ||
          viewModel.gender != user.gender;
    });
  }
}