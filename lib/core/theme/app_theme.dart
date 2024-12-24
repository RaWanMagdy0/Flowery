import 'package:flutter/material.dart';

import '../../core/styles/colors/app_colors.dart';
import '../styles/fonts/app_fonts.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.kPink;
        }
        return AppColors.kGray;
      }),
      overlayColor: WidgetStateProperty.all(AppColors.kPink),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: AppColors.kWhite,
      titleTextStyle: AppFonts.font20BlackWeight500,
    ),
  );
}
