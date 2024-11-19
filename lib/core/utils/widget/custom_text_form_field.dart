import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFromField extends StatelessWidget {
  String hintText;
  String labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final TextEditingController controller;
  TextInputType keyBordType;
  CustomTextFromField(
      {super.key,
      this.validator,
      required this.hintText,
      required this.labelText,
      required this.controller,
      this.onChanged,
      required this.keyBordType});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 1,
        helperMaxLines: 1,
        fillColor: AppColors.kWhite,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.kGray,
        ),
        labelText: labelText,
        enabled: true,
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.error)) {
            return TextStyle(color: AppColors.kError);
          } else if (states.contains(MaterialState.focused)) {
            return TextStyle(color: AppColors.kGray);
          }
          return TextStyle(color: Colors.grey);
        }),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.kGray,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.sp),
          borderSide: BorderSide(
            color: AppColors.kGray,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kGray,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kError,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kError,
          ),
        ),
        errorStyle: const TextStyle(
          color: AppColors.kError,
          fontSize: 14,
        ),
      ),
    );
  }
}
