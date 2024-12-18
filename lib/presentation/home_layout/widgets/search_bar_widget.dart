import 'package:flowery/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  final double? maxHeight;

  const SearchBarWidget({super.key, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Flexible(
      child: TextField(
        cursorColor: AppColors.kPink,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintText: local.searchArabic,
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
          constraints:
              BoxConstraints(maxHeight: maxHeight ?? 36.h, maxWidth: 300.w),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 6.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.kLightGrey,
            ),
          ),
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.kLightGrey,
            ),
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
