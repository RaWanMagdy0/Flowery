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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.kBabyPink,
          ),
          child: Image.network(
            categoryModel.imageUrl ?? '',
            width: 24.w,
            height: 24.h,
          ),
        ),
        8.verticalSpace,
        SizedBox(
          width: 70.w,
          child: Text(
            categoryModel.name ?? '',
            style: AppFonts.font14BlackWeight400,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
