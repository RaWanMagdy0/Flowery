import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../../../domain/entities/home_layout/profile/user.dart';
import '../view_model/profile_cubit.dart';
import 'custom_gender_row.dart';

class EditProfileForm extends StatefulWidget {
  EditProfileForm({super.key, required this.user});
  User user;
  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late ProfileCubit viewModel;
  bool hasChanges = false;
  String? gender;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    hintText: widget.user.firstName ?? '',
                    labelText: "First Name",
                    validator: (value) => Validators.validateNotEmpty(
                      value: value,
                      title: "First Name",
                    ),
                    onChanged: (value) => _checkChanges(widget.user),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomTextFormField(
                    controller: viewModel.lastNameController,
                    hintText: widget.user.lastName ?? '',
                    labelText: "Last Name",
                    validator: (value) => Validators.validateNotEmpty(
                      value: value,
                      title: "Last Name",
                    ),
                    onChanged: (value) => _checkChanges(widget.user),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.emailController,
              hintText: widget.user.email ?? '',
              labelText: "Email",
              validator: (value) => Validators.validateEmail(value),
              onChanged: (value) => _checkChanges(widget.user),
            ),
            24.verticalSpace,
            CustomTextFormField(
              controller: viewModel.phoneController,
              hintText: widget.user.phone ?? '',
              labelText: "Phone",
              validator: (value) => Validators.validatePhoneNumber(value),
              onChanged: (value) => _checkChanges(widget.user),
            ),
            24.verticalSpace,
            CustomTextFormField(
              onChanged: (value) => _checkChanges(widget.user),
              hintText: "***********",
              labelText: "",
              controller: TextEditingController(text: "**********"),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageRouteName.changePassword);
                  },
                  child: Text(
                    "Change",
                    style: AppFonts.font12PinkWeight600,
                  ),
                ),
              ),
            ),
            24.verticalSpace,
            CustomGenderRow(
                gender: viewModel.gender.toString(),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                    _checkChanges;
                  });
                }),
            24.verticalSpace,
            CustomButton(
              onPressed: hasChanges
                  ? () async {
                      if (viewModel.formKey.currentState!.validate()) {
                        await viewModel.editeProfile();
                        setState(() {
                          widget.user.firstName =
                              viewModel.firstNameController.text;
                          widget.user.lastName =
                              viewModel.lastNameController.text;
                          widget.user.email = viewModel.emailController.text;
                          widget.user.phone = viewModel.phoneController.text;
                          widget.user.gender = viewModel.gender;
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
    );
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
