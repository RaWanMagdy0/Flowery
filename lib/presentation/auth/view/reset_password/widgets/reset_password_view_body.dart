import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flowery/core/utils/widegts/custom_app_bar.dart';
import 'package:flowery/core/utils/widegts/custom_text_field.dart';
import 'package:flowery/core/utils/widegts/default_app_button.dart';
import 'package:flowery/presentation/auth/view_model/reset_password/reset_password_states.dart';
import 'package:flowery/presentation/auth/view_model/reset_password/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/routes/page_route_name.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../core/utils/functions/dialogs/app_dialogs.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _resetPasswordViewModel = GetIt.instance.get<ResetPasswordViewModel>();
  var confirmPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordViewModel, ResetPasswordStates>(
      bloc: _resetPasswordViewModel,
      listener: (context, state) => _handelStateChange(state),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomAppBar(title: AppStrings.resetPasswordAppbarTitle),
              SizedBox(
                height: 30.h,
              ),
              Text(
                AppStrings.resetPasswordScreenTitle,
                style: AppFonts.font18BlackWeight500.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(AppStrings.resetPasswordScreenDescription,
                  textAlign: TextAlign.center,
                  style: AppFonts.font12GrayWeight400
                      .copyWith(color: AppColors.kBlack, fontSize: 14)),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                height: 52.h,
                width: 343.w,
                labelText: AppStrings.resetPasswordLabelText,
                hintText: AppStrings.resetPasswordHintText,
                cursorColor: AppColors.kPink,
                obsecureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password";
                  }
                  final bool passwordValid =
                      AppStrings.passwordRegExp.hasMatch(value);
                  if (!passwordValid) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                height: 52.h,
                width: 343.w,
                labelText: AppStrings.resetPasswordConfirmPassword,
                hintText: AppStrings.resetPasswordConfirmPassword,
                cursorColor: AppColors.kPink,
                obsecureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your new password";
                  }
                  if (newPasswordController.text != value) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              DefaultAppButton(
                text: AppStrings.resetPasswordElevatedText,
                onPressed: confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _handelStateChange(ResetPasswordStates state) {
    if (state is ResetPasswordSuccessState) {
      AppDialogs.showSuccessDialog(
          context: context, message: "Password changed Successfully");
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, PageRouteName.forgetPassword);
      });
    } else if (state is ResetPasswordErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is ResetPasswordLoadingState) {
      AppDialogs.showLoading(
        context: context,
      );
    }
  }

  void confirm() {
    if (_formKey.currentState!.validate()) {
      _resetPasswordViewModel.resetPassword(
          confirmPasswordController.text, newPasswordController.text);
    }
  }
}
