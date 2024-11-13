import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flowery/presentation/auth/forgot_password/view/widget/pin_code_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordVerification extends StatelessWidget {
  static const String routeName = "PasswordVerification";

  const PasswordVerification({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back_ios_outlined),
                SizedBox(width: 10.w,),
                Text(
                  AppStrings.passwordAppBarTitle,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.emailVerificationScreenTitle,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(AppStrings.emailVerificationScreenDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            PinCodeFile(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.didnotReceiveCode,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  AppStrings.resendText,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.pinkAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.pinkAccent),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
