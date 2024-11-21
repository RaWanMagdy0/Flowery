import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/const/app_string.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/functions/validators/my_validators.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../data/model/auth/requests/sign_up_request_model.dart';
import '../view_model/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _gender = '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
            SignUpRequestBodyModel(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              rePassword: _confirmPasswordController.text,
              phone: _phoneNumberController.text,
              gender: _gender.toLowerCase(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      bloc: context.read<SignUpCubit>(),
      listener: (context, state) => _handelStateChange(state),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.signUpTitle),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: AppStrings.firstNameHintText,
                          labelText: AppStrings.firstNameLabelText,
                          validator: (value) =>
                              MyValidators.validateName(value),
                          keyBordType: TextInputType.text,
                          controller: _firstNameController,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          hintText: AppStrings.lastNameHintText,
                          labelText: AppStrings.lastNameLabelText,
                          validator: (value) =>
                              MyValidators.validateName(value),
                          keyBordType: TextInputType.text,
                          controller: _lastNameController,
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: AppStrings.emailHintText,
                    labelText: AppStrings.emailLabelText,
                    validator: (value) => MyValidators.validateEmail(value),
                    keyBordType: TextInputType.text,
                    controller: _emailController,
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: AppStrings.signupPasswordHintText,
                          labelText: AppStrings.passwordLabelText,
                          isPassword: true,
                          validator: (value) =>
                              MyValidators.validatePassword(value),
                          keyBordType: TextInputType.text,
                          controller: _passwordController,
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          hintText: AppStrings.confirmPasswordHintText,
                          labelText: AppStrings.confirmPasswordLabelText,
                          isPassword: true,
                          validator: (value) =>
                              MyValidators.validatePasswordConfirmation(
                            password: _passwordController.text,
                            confirmPassword: value,
                          ),
                          keyBordType: TextInputType.text,
                          controller: _confirmPasswordController,
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  CustomTextFormField(
                    hintText: AppStrings.phoneHintText,
                    labelText: AppStrings.phoneLabelText,
                    validator: (value) =>
                        MyValidators.validatePhoneNumber(value),
                    keyBordType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: _phoneNumberController,
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        final prefix = '+2';
                        _phoneNumberController.text = prefix;
                      }
                    },
                  ),
                  24.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: Row(
                      children: [
                        Text(
                          AppStrings.gender,
                          style: AppFonts.font18BlackWeight500,
                        ),
                        50.horizontalSpace,
                        Row(
                          children: [
                            Radio(
                              value: AppStrings.female,
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
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
                              groupValue: _gender,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value!;
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
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.createAccount,
                        style: AppFonts.font12BlackWeight400,
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15.r),
                        child: RichText(
                          text: TextSpan(
                            text: AppStrings.termsAndConditions,
                            style: AppFonts.font12BlackWeight400UnderlinedBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  35.verticalSpace,
                  CustomButton(
                    onPressed: signUp,
                    text: AppStrings.signUpTitle,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: AppFonts.font16BlackWeight400,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(15.r),
                        child: RichText(
                          text: TextSpan(
                            text: AppStrings.loginTitle,
                            style: AppFonts.font16PinkWeight500UnderlinedPink,
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
      ),
    );
  }

  void _handelStateChange(SignUpState state) {
    if (state is SignUpSuccess) {
      Navigator.pop(context);
      AppDialogs.showSuccessDialog(
          context: context,
          message: "Account Created Successfully.\n Please Login to proceed");
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      });
    } else if (state is SignUpFail) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
          context: context, errorMassage: state.errorMassage ?? "");
    } else if (state is SignUpLoading) {
      AppDialogs.showLoading(context: context);
    }
  }
}
