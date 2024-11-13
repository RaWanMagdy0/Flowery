import 'package:flowery/core/di/di.dart';
import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/presentation/auth/forgot_password/view/widgets/custom_text_form_field.dart';
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import 'package:flowery/presentation/auth/forgot_password/view_model/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/my_validators.dart';

class ForgetPassword extends StatefulWidget {
  static String routeName = "ForgetPassword";

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
class _ForgetPasswordState extends State<ForgetPassword> {
  var viewModel = getIt.get<ForgetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgotPasswordStates>(
      bloc: viewModel,
        listener: (context, state) => _handelStateChange(state),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined),
                    Text("Password", style: AppFonts.font20BlackWeight500),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "Forget password",
                  style: AppFonts.font20BlackWeight500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("please enter your email associates to \n your account",
                    textAlign: TextAlign.center,
                    style: AppFonts.font14GreyWeight400),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    onChanged: () => viewModel.updateValidationState(),
                    key: viewModel.formKey,
                    child: CustomTextFromField(
                      hintText: "Enter your email",
                      labelText: "Email",
                      validator: (value) => MyValidators.validateEmail(value),
                      keyBordType: TextInputType.text,
                      controller: viewModel.emailController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 130.w, vertical: 13.h),
                        backgroundColor: AppColors.kPink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r))),
                    onPressed: () => viewModel.submitForgotPassword(),
                    child:
                        Text("Confirm", style: AppFonts.font15WhiteWeight500))
              ],
            ),
          ),
        ));
  }

  dynamic _handelStateChange(ForgotPasswordStates state) {
    if (state is ForgotPasswordSuccessState) {
      Navigator.pushReplacementNamed(
          context, PageRouteName.passwordVerification);
    } else if (state is ForgotPasswordErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is ForgotPasswordLoadingState) {
      AppDialogs.showLoading(
        context: context,
      );
    }
  }
}
