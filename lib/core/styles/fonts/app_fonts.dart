import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class AppFonts {
  static TextStyle font16BlueWeight500 = TextStyle(
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
  static TextStyle font20BlackWeight400 = TextStyle(
      color: AppColors.kBlack, fontWeight: FontWeight.w400, fontSize: 20.sp);
  static TextStyle font18BlackWeight500 = TextStyle(
      color: AppColors.kBlack, fontWeight: FontWeight.w500, fontSize: 18.sp);
  static TextStyle font20BlackWeight500 = TextStyle(
      color: AppColors.kBlack, fontWeight: FontWeight.w500, fontSize: 20.sp);
  static TextStyle font14GreyWeight400 = TextStyle(
      color: AppColors.kGray, fontWeight: FontWeight.w400, fontSize: 14.sp);
  static TextStyle font15WhiteWeight500 = TextStyle(
      color: AppColors.kWhite, fontWeight: FontWeight.w500, fontSize: 15.sp);
  static final font16BlackWeight500 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    color: AppColors.kBlack,
  );
  static final font12GrayWeight400 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.kGray,
  );
}
