import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../view_model/forget_passwoed_cubit.dart';
import '../../../view_model/forget_password_states.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _resetPasswordViewModel = GetIt.instance.get<ForgetPasswordCubit>();
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
    final local = S.of(context);
    return BlocListener<ForgetPasswordCubit, ForgotPasswordStates>(
      bloc: _resetPasswordViewModel,
      listener: (context, state) => _handelStateChange(state),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                local.resetPasswordScreenTitle,
                style: AppFonts.font18BlackWeight500.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(local.resetPasswordScreenDescription,
                  textAlign: TextAlign.center,
                  style: AppFonts.font14BlackWeight400),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                hintText: local.passwordHintText,
                labelText: local.passwordLabelText,
                controller: newPasswordController,
                keyBordType: TextInputType.text,
                isPassword: true,
                validator: (value) => Validators.validatePassword(value),
              ),
              20.verticalSpace,
              CustomTextFormField(
                hintText: local.confirmPasswordHintText,
                labelText: local.confirmPasswordHintText,
                controller: confirmPasswordController,
                keyBordType: TextInputType.text,
                isPassword: true,
                validator: (value) => Validators.validatePasswordConfirmation(
                    password: newPasswordController.text,
                    confirmPassword: value),
              ),
              40.verticalSpace,
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _resetPasswordViewModel
                        .resetPassword(newPasswordController.text);
                  }
                },
                color: AppColors.kWhite,
                text: local.confirmTitle,
                textStyle: AppFonts.font16BlackWeight500,
                borderColor: AppColors.kGray,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handelStateChange(ForgotPasswordStates state) {
    if (state is ResetPasswordSuccessState) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
        context: context,
        message: "Password Changed Successfully",
        whenAnimationFinished: () => Navigator.pop(context),
      );
    } else if (state is ResetPasswordErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is ResetPasswordLoadingState) {
      AppDialogs.showLoading(context: context);
    }
  }
}
