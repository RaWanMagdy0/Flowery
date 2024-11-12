import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/colors/app_colors.dart';
class AppTheme{
  static ThemeData appTheme=ThemeData(
      scaffoldBackgroundColor: AppColors.kWhite,
      appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: AppColors.kWhite,
          titleTextStyle:  TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.kBlack)
      ),
  );
}