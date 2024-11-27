import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 265.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.kLighterGrey,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle:
                    AppFonts.font14LightGreyWeight500.copyWith(fontSize: 12.sp),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kLighterGrey,
                  size: 25,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 60.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.kLighterGrey,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.sort,
              color: AppColors.kLighterGrey,
              size: 25,
            ),
            onPressed: () {
              // Add menu button functionality here
            },
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
