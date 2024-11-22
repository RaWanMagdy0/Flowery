import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_occasion_entity.dart';

class HomeOccasionItem extends StatelessWidget {
  final HomeOccasion occasionModel;

  const HomeOccasionItem({
    super.key,
    required this.occasionModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            occasionModel.imageUrl ?? '',
            width: 131.w,
            height: 151.h,
            fit: BoxFit.cover,
          ),
          3.verticalSpace,
          Text(
            occasionModel.name ?? '',
            style: AppFonts.font16BlackWeight400,
          ),
        ],
      ),
    );
  }
}
