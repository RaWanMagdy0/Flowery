import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/fonts/app_fonts.dart';

class SavedAddressesButton extends StatelessWidget {
  VoidCallback onPressed;
  SavedAddressesButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      child: Text(
        'Add new address',
        style: AppFonts.font18BlackWeight500.copyWith(
          color: AppColors.kWhite,
          fontSize: 16,
        ),
      ),
    );
  }
}
