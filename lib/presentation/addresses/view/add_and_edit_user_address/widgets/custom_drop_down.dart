import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> data;
  final String hintText;
  final String labelText;
  final String? initialTextValue;
  final int? maxLength, maxLines, minLines, errorMaxLines;
  final bool? enabled, isFilled;
  final TextStyle? inputTextStyle, hintStyle, errorStyle;
  final Color? backgroundColor, disabledBackgroundColor, suffixIconColor;
  final InputBorder? border,
      enabledBorder,
      focusedBorder,
      disabledBorder,
      errorBorder,
      focusedErrorBorder;
  final Color? borderColor,
      enabledBorderColor,
      focusedBorderColor,
      errorBorderColor,
      focusedErrorBorderColor;
  final double? borderWidth,
      enabledBorderWidth,
      focusedBorderWidth,
      disabledBorderWidth,
      errorBorderWidth,
      focusedErrorBorderWidth;
  final double? borderRadius,
      enabledBorderRadius,
      focusedBorderRadius,
      disabledBorderRadius,
      errorBorderRadius,
      focusedErrorBorderRadius;
  final num? scrollPaddingValue;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final Widget? suffixIcon, prefixIcon;
  final IconData? icon;
  final FocusNode? focusNode;

  const CustomDropDown({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.data,
    this.autovalidateMode,
    this.border,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.disabledBackgroundColor,
    this.disabledBorder,
    this.disabledBorderWidth,
    this.disabledBorderRadius,
    this.enabled,
    this.enabledBorder,
    this.enabledBorderColor,
    this.enabledBorderWidth,
    this.enabledBorderRadius,
    this.errorBorder,
    this.errorBorderColor,
    this.errorBorderWidth,
    this.errorBorderRadius,
    this.errorMaxLines,
    this.errorStyle,
    this.backgroundColor,
    this.focusNode,
    this.focusedBorder,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.focusedBorderRadius,
    this.focusedErrorBorder,
    this.focusedErrorBorderColor,
    this.focusedErrorBorderWidth,
    this.focusedErrorBorderRadius,
    this.hintStyle,
    this.icon,
    this.initialTextValue,
    this.isFilled,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.contentPadding,
    this.prefixIcon,
    this.inputTextStyle,
    this.scrollPaddingValue,
    this.suffixIcon,
    this.suffixIconColor,
    this.validator,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.data
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value.toString());
        }
      },
      dropdownColor: AppColors.kWhite,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return TextStyle(color: AppColors.kPink);
          } else if (states.contains(WidgetState.error)) {
            return TextStyle(color: AppColors.kError);
          }
          return TextStyle(color: Colors.grey);
        }),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppFonts.font14GreyWeight400,
        fillColor: (widget.enabled != null && widget.enabled == false)
            ? widget.disabledBackgroundColor ?? AppColors.kGray
            : widget.backgroundColor ?? AppColors.kWhite,
        filled: widget.isFilled ?? true,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColors.kPink,
        suffixIcon: widget.suffixIcon,
        counterText: "",
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 4.r),
              borderSide: BorderSide(
                color: widget.borderColor ?? AppColors.kGray,
                width: widget.borderWidth ?? 1,
              ),
            ),
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.enabledBorderRadius ?? 4.r),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ?? AppColors.kGray,
                width: widget.enabledBorderWidth ?? 1,
              ),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.focusedBorderRadius ?? 4.r),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.kPink,
                width: widget.focusedBorderWidth ?? 1,
              ),
            ),
        disabledBorder: widget.disabledBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.disabledBorderRadius ?? 4.r),
              borderSide: BorderSide(
                color:
                    widget.disabledBackgroundColor ?? const Color(0xFFE6E6E6),
                width: widget.disabledBorderWidth ?? 1,
              ),
            ),
        errorStyle: widget.errorStyle ??
            TextStyle(color: AppColors.kError, fontSize: 14.sp),
        errorMaxLines: widget.errorMaxLines ?? 4,
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.errorBorderRadius ?? 4.r),
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? AppColors.kError,
                width: widget.errorBorderWidth ?? 1,
              ),
            ),
        focusedErrorBorder: widget.focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.focusedErrorBorderRadius ?? 4.r),
              borderSide: BorderSide(
                color: widget.focusedErrorBorderColor ?? AppColors.kError,
                width: widget.focusedErrorBorderWidth ?? 1,
              ),
            ),
      ),
    );
  }
}
