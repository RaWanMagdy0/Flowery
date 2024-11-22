import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        cursorColor: AppColors.kPink,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppFonts.font14LightGreyWeight500,
          prefixIcon: Icon(Icons.search),
          prefixIconColor: WidgetStateColor.resolveWith(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.error)) {
                return AppColors.kError;
              } else if (states.contains(WidgetState.focused)) {
                return AppColors.kPink;
              }
              return AppColors.kLightGrey;
            },
          ),
          constraints: BoxConstraints(maxHeight: 36.h),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 6.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.kPink,
            ),
          ),
        ),
      ),
    );
  }
}
