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
}
