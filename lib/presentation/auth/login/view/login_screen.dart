import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/base/exceptions.dart';
import '../../../../core/local/token_manger.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/const/app_string.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/my_validators.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../view_model/login_cubit.dart';
import '../view_model/login_state.dart';

class LogInScreen extends StatefulWidget {
  static String routeName = "login page";

  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late final LoginViewModel viewModel;

  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isRememberMe = false;

  @override
  void initState() {
    viewModel = context.read<LoginViewModel>();
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(AppStrings.loginTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                24.verticalSpace,
                BlocListener<LoginViewModel, LoginScreenState>(
                  listenWhen: (previous, current) {
                    return current is! InitialState;
                  },
                  listener: (context, state) {
                    switch (state) {
                      case LoadingState():
                        {
                          AppDialogs.showLoading(context: context);
                        }
                      case ErrorState():
                        {
                          Navigator.of(context).pop();
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
                          Navigator.of(context).pop();
                          AppDialogs.showSuccessDialog(
                            context: context,
                            message: AppStrings.userLoggedInSuccessfully,
                            whenAnimationFinished: () {
                              if (_isRememberMe) {
                                var token = state.user!.token;
                                TokenManger.setToken(token: token.toString());
                              }
                              Navigator.pushReplacementNamed(
                                  context, PageRouteName.homeLayout);
                            },
                          );
                        }
                      default:
                        {}
                    }
                  },
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: AppStrings.emailHintText,
                        labelText: AppStrings.emailLabelText,
                        controller: _emailController,
                        keyBordType: TextInputType.text,
                        validator: (value) => MyValidators.validateEmail(value),
                      ),
                      24.verticalSpace,
                      CustomTextFormField(
                        hintText: AppStrings.passwordHintText,
                        labelText: AppStrings.passwordLabelText,
                        controller: _passwordController,
                        keyBordType: TextInputType.text,
                        isPassword: true,
                        validator: (value) =>
                            MyValidators.validatePassword(value),
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          Checkbox(
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return AppColors.kPink;
                              }
                              return AppColors.kWhite;
                            }),
                            value: _isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                _isRememberMe = value!;
                              });
                            },
                          ),
                          Text(AppStrings.rememberMeText,
                              style: AppFonts.font13BlackWeight400),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRouteName.forgetPassword);
                            },
                            child: Text(
                              AppStrings.forgetPasswordText,
                              style:
                                  AppFonts.font12BlackWeight400UnderlinedBlack,
                            ),
                          ),
                        ],
                      ),
                      50.verticalSpace,
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.login(_emailController.text,
                                _passwordController.text);
                          }
                        },
                        color: AppColors.kPink,
                        text: AppStrings.loginTitle,
                        textStyle: AppFonts.font16LightWhiteWeight500,
                      ),
                      16.verticalSpace,
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PageRouteName.homeLayout);
                        },
                        color: AppColors.kWhite,
                        text: AppStrings.continueAsGusetText,
                        textStyle: AppFonts.font16BlackWeight500,
                        borderColor: AppColors.kGray,
                      ),
                    ],
                  ),
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
                      onTap: () {
                        Navigator.pushNamed(context, PageRouteName.signUp);
                      },
                      child: Text(
                        AppStrings.signUpTitle,
                        style: AppFonts.font16PinkWeight500UnderlinedPink,
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
