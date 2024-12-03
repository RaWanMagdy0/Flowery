import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/widget/shimmer_loading_widget.dart';

class CartProductsLoading extends StatelessWidget {
  const CartProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: index == 4 ? 0 : 24.h),
        child: ShimmerLoadingWidget(
          height: 117.h,
        ),
      ),
    );
  }
}
