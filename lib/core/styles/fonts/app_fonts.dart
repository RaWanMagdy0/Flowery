import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class AppFonts {
  static TextStyle font20BlackWeight500 = TextStyle(
    color: AppColors.kBlack,
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
  );

  static TextStyle font20BlackWeight400 = TextStyle(
    color: AppColors.kBlack,
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
  );

  static TextStyle font18BlackWeight500 = TextStyle(
    color: AppColors.kBlack,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );

  static TextStyle font16BlackWeight500 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.kBlack,
  );

  static TextStyle font16LightWhiteWeight500 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.kLightWhite,
  );

  static TextStyle font16BlackWeight400 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.kBlack,
  );

  static TextStyle font15WhiteWeight500 = TextStyle(
    color: AppColors.kWhite,
    fontWeight: FontWeight.w500,
    fontSize: 15.sp,
  );

  static TextStyle font14GreyWeight400 = TextStyle(
    color: AppColors.kGray,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );

  static TextStyle font14BlackWeight400 = TextStyle(
    color: AppColors.kBlack,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );

  static TextStyle font12BlackWeight400 = TextStyle(
    color: AppColors.kBlack,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );

  static TextStyle font16PinkWeight500UnderlinedPink = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.kPink,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.kPink,
  );

  static TextStyle font15PinkWeight500UnderlinedPink = TextStyle(
    color: AppColors.kPink,
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    decoration: TextDecoration.underline,
    decorationColor: Colors.pinkAccent,
  );

  static TextStyle font12PinkWeight600UnderlinedBlack = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.kBlack,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.kBlack,
  );
}
