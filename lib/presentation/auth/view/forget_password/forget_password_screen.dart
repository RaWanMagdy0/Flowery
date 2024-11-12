import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/presentation/auth/view/forget_password/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  static String routeName = "ForgetPassword";

  const ForgetPassword({super.key});
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
                Text(
                  "Password",
                  style:
                  AppFonts.font20BlackWeight500
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              "Forget password",style: AppFonts.font20BlackWeight500,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "please enter your email associates to \n your account",
              textAlign: TextAlign.center,
              style: AppFonts.font14GreyWeight400
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldItem(
                  hintText: "Enter your email",
                  labelText: "Email",
                  keyBordType: TextInputType.text),
            ),
            SizedBox(
              height: 25.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 130.w, vertical: 13.h),
                    backgroundColor: AppColors.kPink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r))),
                onPressed: () {},
                child: Text(
                  "Confirm",
                  style:
                  AppFonts.font15WhiteWeight500
                ))
          ],
        ),
      ),
    );
  }
}
