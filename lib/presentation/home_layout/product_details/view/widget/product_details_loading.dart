import 'package:flowery/core/utils/widget/shimmer_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/fonts/app_fonts.dart';

class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLoadingWidget(
          width: 1.sw,
          height: 1.sh/2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerLoadingWidget(
                    width: 120.w,
                    height: 25.h,
                  ),
                  ShimmerLoadingWidget(
                    width: 120.w,
                    height: 25.h,
                  )
                ],
              ),
              12.verticalSpace,
              ShimmerLoadingWidget(
                width: 125.w,
                height: 15.h,
              ),
              5.verticalSpace,
              ShimmerLoadingWidget(
                width: 125.w,
                height: 15.h,
              ),
              50.verticalSpace,
              ShimmerLoadingWidget(
                width: 100.w,
                height: 25.h,
              ),
              15.verticalSpace,
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 90.h,
              ),

            ],
          ),
        ),
      ],
    );
  }
}
