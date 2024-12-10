import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../view_model/forget_passwoed_cubit.dart';
import '../../../view_model/forget_password_states.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final ForgetPasswordCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
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
                    Text(local.passwordAppBarTitle,
                        style: AppFonts.font20BlackWeight500),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  local.forgetPasswordScreenTitle,
                  style: AppFonts.font20BlackWeight500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(local.forgetPasswordScreenDescription,
                    textAlign: TextAlign.center,
                    style: AppFonts.font14GreyWeight400),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: viewModel.formKey,
                    child: CustomTextFormField(
                      hintText: local.emailHintText,
                      labelText: local.emailLabelText,
                      validator: (value) => Validators.validateEmail(value),
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
                    child: Text(local.confirmTitle,
                        style: AppFonts.font15WhiteWeight500))
              ],
            ),
          ),
        ));
  }

  dynamic _handelStateChange(ForgotPasswordStates state) {
    if (state is ForgotPasswordSuccessState) {
      AppDialogs.showSuccessDialog(
        context: context,
        message: "OTP sent to your email.\n Please check your Email",
        whenAnimationFinished: () =>
            Navigator.pushNamed(context, PageRouteName.passwordVerification),
      );
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
