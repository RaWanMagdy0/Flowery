import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/functions/validators/validators.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/core/utils/widget/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/const/app_string.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  String gender = "femail";

  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.photo,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "first name",
                            labelText: "first Name",
                            validator: (value) => Validators.validateNotEmpty(
                                value: value, title: "firstName"),
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "last name",
                            labelText: "last Name",
                            validator: (value) => Validators.validateNotEmpty(
                                value: value, title: "lastName"),
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpace,
                    CustomTextFormField(
                      hintText: "email",
                      labelText: " email",
                      validator: (value) => Validators.validateNotEmpty(
                          value: value, title: "email"),
                    ),
                    24.verticalSpace,
                    CustomTextFormField(
                      hintText: "phone",
                      labelText: " phone",
                      validator: (value) => Validators.validateNotEmpty(
                          value: value, title: "phone"),
                    ),
                    24.verticalSpace,
                    CustomTextFormField(
                      hintText: "password",
                      labelText: "password",
                      validator: (value) => Validators.validateNotEmpty(
                          value: value, title: "password"),
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
                            style: AppFonts.font18BlackWeight500.copyWith(
                              color: AppColors.kGray
                            ),
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
                                      gender = value!;
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
                                      gender = value!;
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
        ));
  }
}
