import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/core/utils/functions/validators/my_validators.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';
import 'package:flowery/presentation/auth/view_model/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/base/exceptions.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../view_model/login/login_state.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = "login page";

  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isRememberMe = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  LoginViewModel viewModel = getIt.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                10.verticalSpace,
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {},
                    ),
                    Text(AppStrings.loginTitle,
                        style: AppFonts.font20BlackWeight500),
                  ],
                ),
                24.verticalSpace,
                BlocConsumer<LoginViewModel, LoginScreenState>(
                  listenWhen: (previous, current) {
                    return current is! InitialState;
                  },
                  listener: (context, state) {
                    switch (state) {
                      case ErrorState():
                        {
                          var exception = state.exception;
                          String? message = AppStrings.somethingWentWrong;
                          if (exception is NoInternetException) {
                            message = AppStrings.pleaseCheckInternetConnection;
                          } else if (exception is ServerError) {
                            message = exception.serverMessage;
                          }
                          return AppDialogs.showErrorDialog(
                            context: context,
                            errorMassage: message ?? "",
                          );
                        }
                      case SuccessState():
                        {
                          return AppDialogs.showSuccessDialog(
                              context: context,
                              message: AppStrings.userLoggedInSuccessfully);
                        }
                      default:
                        {}
                    }
                  },
                  builder: (context, state) {
                    isLoading = state is LoadingState;
                    return Column(
                      children: [
                        CustomTextFromField(
                          hintText: AppStrings.emailHintText,
                          labelText: AppStrings.emailLabelText,
                          controller: _emailController,
                          keyBordType: TextInputType.text,
                          validator: (value) =>
                              MyValidators.validateEmail(value),
                        ),
                        24.verticalSpace,
                        CustomTextFromField(
                          hintText: AppStrings.passwordHintText,
                          labelText: AppStrings.passwordLabelText,
                          controller: _passwordController,
                          keyBordType: TextInputType.text,
                          validator: (value) =>
                              MyValidators.validatePassword(value),
                        ),
                        15.verticalSpace,
                        Row(
                          children: [
                            Checkbox(
                              value: _isRememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _isRememberMe = value!;
                                });
                              },
                            ),
                            Text(AppStrings.rememberMeText,
                                style: AppFonts.font16BlackWeight500),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgetPassword.routeName);
                              },
                              child: Text(AppStrings.forgetPasswordText,
                                  style: AppFonts.font16BlackWeight500.copyWith(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                        64.verticalSpace,
                        isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    viewModel.login(_emailController.text,
                                        _passwordController.text);
                                  }
                                },
                                color: AppColors.kPink,
                                text: AppStrings.loginTitle,
                                textStyle: AppFonts.font16LightWhiteWeight500),
                        16.verticalSpace,
                        isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : CustomButton(
                                onPressed: () {},
                                color: AppColors.kWhite,
                                text: AppStrings.continueAsGusetText,
                                textStyle: AppFonts.font16BlackWeight500)
                      ],
                    );
                  },
                ),
                13.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.donotHaveAccountText,
                      style: AppFonts.font16BlackWeight500,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppStrings.signUpTitle,
                        style: AppFonts.font16BlackWeight500.copyWith(
                          color: Colors.pink,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
