import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/colors/app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: AppColors.kWhite,
      titleTextStyle: AppFonts.font20BlackWeight500,
    ),
  );
}
