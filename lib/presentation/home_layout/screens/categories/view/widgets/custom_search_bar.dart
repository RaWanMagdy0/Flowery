import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/search_bar_widget.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            maxHeight: 100.h,
          ),
        ),
        8.horizontalSpace,
        Container(
          width: 50.w,
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
