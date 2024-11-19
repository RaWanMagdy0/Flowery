import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_category_entity.dart';

class HomeCategoryItem extends StatelessWidget {
  final HomeCategory categoryModel;

  const HomeCategoryItem({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
            vertical: 50.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.kLightPink,
          ),
          child: Image.network(
            categoryModel.imageUrl ?? '',
            width: 24.w,
            height: 24.h,
          ),
        ),
        8.verticalSpace,
        Text(
          categoryModel.name ?? '',
          style: AppFonts.font14BlackWeight400,
        ),
      ],
    );
  }
}
