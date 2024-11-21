import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/widget/shimmer_loading_widget.dart';

class HomeOccasionsLoading extends StatelessWidget {
  const HomeOccasionsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ShimmerLoadingWidget(
            width: 100.w,
            height: 20.h,
            borderRadius: 0,
          ),
        ),
        8.verticalSpace,
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) {
              return 16.horizontalSpace;
            },
            itemBuilder: (context, index) {
              return ShimmerLoadingWidget(
                width: 131.w,
                height: 74.h,
                borderRadius: 0,
              );
            },
          ),
        ),
      ],
    );
  }
}
