import 'package:flowery/core/di/di.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/functions/validators/validators.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/core/utils/widget/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/const/app_string.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    var viewModel = getIt.get<ProfileCubit>();
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text("Edit Profile"),
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_outlined,
              ),
            )
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: viewModel..getLoggedUserInfo(),
            builder: (context, state) {
              if (state is GetLoggedUserInfoLoadingState) {
                return Center(
                    child: Lottie.asset(AppImages.pinkLoadingAnimation));
              } else if (state is GetLoggedUserInfoErrorState) {
                return Center(
                  child: Text(state.errorMessage ?? ''),
                );
              } else if (state is GetLoggedUserInfoSuccessState) {
                gender = state.user!.gender!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            child: Image.network(
                              state.user!.photo??"",
                              width: 90.w,
                              height: 90.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 60.h,
                              right: 0.1.w,
                              child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.kBabyPink),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 15.sp,
                                    color: AppColors.kGray,
                                  )))
                        ],
                      ),
                      20.verticalSpace,
                      Form(
                        key: viewModel.formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: viewModel.firstNameController,
                                    hintText: viewModel.firstNameController.text,
                                    labelText: "first Name",
                                    validator: (value) =>
                                        Validators.validateNotEmpty(
                                      value: value,
                                      title: viewModel.firstNameController.text,
                                    ),
                                  ),
                                ),
                                16.horizontalSpace,
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: viewModel.lastNameController,
                                    hintText: viewModel.lastNameController.text,
                                    labelText: "last Name",
                                    validator: (value) =>
                                        Validators.validateNotEmpty(
                                      value: value,
                                      title: viewModel.lastNameController.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            24.verticalSpace,
                            CustomTextFormField(
                              controller: viewModel.emailController,
                              hintText: viewModel.emailController.text,
                              labelText: " email",
                              validator: (value) => Validators.validateNotEmpty(
                                value: value,
                                title: viewModel.emailController.text,
                              ),
                            ),
                            24.verticalSpace,
                            CustomTextFormField(
                              controller: viewModel.phoneController,
                              hintText: viewModel.phoneController.text,
                              labelText: " phone",
                              validator: (value) => Validators.validateNotEmpty(
                                value: value,
                                title: viewModel.phoneController.text,
                              ),
                            ),
                            24.verticalSpace,
                            CustomTextFormField(
                              hintText: "***********",
                              labelText: "",
                              controller:
                                  TextEditingController(text: "**********"),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {},
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
                                    AppStrings.gender,
                                    style: AppFonts.font18BlackWeight500
                                        .copyWith(color: AppColors.kGray),
                                  ),
                                  50.horizontalSpace,
                                  Row(
                                    children: [
                                      Radio(
                                        value: AppStrings.female,
                                        groupValue: gender,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value as String;
                                          });
                                        },
                                      ),
                                      Text(
                                        AppStrings.female,
                                        style: AppFonts.font14BlackWeight400,
                                      ),
                                      16.horizontalSpace,
                                      Radio(
                                        value: AppStrings.male,
                                        groupValue: gender,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value as String;
                                          });
                                        },
                                      ),
                                      Text(
                                        AppStrings.male,
                                        style: AppFonts.font14BlackWeight400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            24.verticalSpace,
                            CustomButton(
                              onPressed: () {},
                              text: "Update",
                              textStyle: AppFonts.font16WhiteWeight500,
                              height: 53.h,
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }));
  }
}
