import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../styles/colors/app_colors.dart';
import '../../../styles/fonts/app_fonts.dart';
import '../../../styles/images/app_images.dart';

class AppDialogs {
  static Future<void> showLoading({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Lottie.asset(
            AppImages.pinkLoading,
            height: 50.h,
            width: 20.w,
          );
        });
  }
  static void showErrorDialog(
      {required BuildContext context, required String errorMassage}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(AppImages.pinkError,  height: 80.h),
        content: Text(
          textAlign: TextAlign.center,
          errorMassage,
          style: AppFonts.font18BlackWeight500,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Got it',
              style: AppFonts.font20BlackWeight400,
            ),
          ),
        ],
      ),
    );
  }
  static void showSuccessDialog(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(AppImages.pinkDone,  height: 80.h),
        content: Text(
          textAlign: TextAlign.center,
          message,
          style: AppFonts.font18BlackWeight500,
        ),

      ),
    );
  }


}
