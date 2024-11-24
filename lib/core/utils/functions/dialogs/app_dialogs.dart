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
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Lottie.asset(
            AppImages.pinkLoadingAnimation,
            height: 50.h,
            width: 20.w,
          ),
        );
      },
    );
  }

  static void showErrorDialog(
      {required BuildContext context, required String errorMassage}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(AppImages.pinkErrorAnimation, height: 80.h),
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

  static void showSuccessDialog({
    required BuildContext context,
    required String message,
    VoidCallback? whenAnimationFinished,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(
          AppImages.pinkDoneAnimation,
          height: 80.h,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(
              composition.duration,
              () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  if (whenAnimationFinished != null) {
                    whenAnimationFinished();
                  }
                }
              },
            );
          },
        ),
        content: Text(
          textAlign: TextAlign.center,
          message,
          style: AppFonts.font18BlackWeight500,
        ),
      ),
    );
  }
}
