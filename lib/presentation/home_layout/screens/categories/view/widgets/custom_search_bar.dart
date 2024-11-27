import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../widgets/search_bar_widget.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            maxHeight: 45.h,
          ),
          // Container(
          //   width: 265.w,
          //   height: 45.h,
          //   decoration: BoxDecoration(
          //     color: AppColors.kWhite,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(
          //       color: AppColors.kLighterGrey,
          //     ),
          //   ),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       hintStyle:
          //           AppFonts.font14LightGreyWeight500.copyWith(fontSize: 12.sp),
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: AppColors.kLighterGrey,
          //         size: 25,
          //       ),
          //       border: InputBorder.none,
          //       contentPadding: const EdgeInsets.symmetric(
          //         horizontal: 16,
          //         vertical: 12,
          //       ),
          //     ),
          //   ),
          // ),
        ),
        8.horizontalSpace,
        Container(
          width: 60.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.kLightGrey,
              width: 1.r,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.sort,
              color: AppColors.kLightGrey,
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
