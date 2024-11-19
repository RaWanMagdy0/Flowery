import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? minWidth, minHeight, maxWidth, maxHeight, borderRadius;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;
  final Color? color, textColor, disabledColor, borderColor;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    this.onPressed,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.borderRadius,
    this.text,
    this.textStyle,
    this.child,
    this.color,
    this.textColor,
    this.disabledColor,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth ?? double.infinity, minHeight ?? 48.h),
        // maximumSize: Size(maxWidth ?? double.maxFinite, maxHeight ?? 50.h),
        backgroundColor: color ?? AppColors.kPink,
        disabledBackgroundColor: disabledColor ?? AppColors.kGray,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
          side: BorderSide(
            color: borderColor ?? AppColors.kPink,
            width: 1.w,
          ),
        ),
      ),
      child: Text(
        text ?? '',
        style: textStyle ??
            AppFonts.font16LightWhiteWeight500.copyWith(
              color: textColor ?? AppColors.kLightWhite,
            ),
      ),
    );
  }
}
