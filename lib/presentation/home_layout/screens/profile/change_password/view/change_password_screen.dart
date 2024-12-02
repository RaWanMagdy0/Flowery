import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../view_model/change_password_state.dart';
import '../view_model/change_password_view_model.dart';

// lib/presentation/auth/change_password/view/change_password_screen.dart
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Reset password',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            AppDialogs.showSuccessDialog(context: context, message: "Change Password Successfully");
          } else if (state is ChangePasswordError) {
            AppDialogs.showErrorDialog(
                context: context, errorMassage: state.errorMessage.toString());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _currentPasswordController,
                    hintText: 'Current password',
                    isPassword: true,
                    validator: (value) =>
                        Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                    labelText: '',
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'New password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _newPasswordController,
                    hintText: 'New password',
                    isPassword: true,
                    validator: (value) =>
                        Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                    labelText: '',
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Confirm password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm password',
                    isPassword: true,
                    validator: (value) =>
                        Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                    labelText: '',
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    color: AppColors.kPink,
                    text: state is ChangePasswordLoading
                        ? 'Loading...'
                        : 'Update',
                    onPressed: state is ChangePasswordLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context
                                  .read<ChangePasswordViewModel>()
                                  .changePassword(
                                    currentPassword:
                                        _currentPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
