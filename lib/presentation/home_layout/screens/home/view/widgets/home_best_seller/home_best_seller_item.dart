import 'package:flowery/core/utils/widget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_best_seller_product_entity.dart';

class HomeBestSellerItem extends StatelessWidget {
  final HomeBestSellerProduct productModel;

  const HomeBestSellerItem({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 131.w,
      child: Padding(
        padding: EdgeInsets.only(right: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedNetworkImage(
              imageUrl: productModel.imageUrl,
              width: 131.w,
              height: 151.h,
              shimmerRadiusValue: 0,
              fit: BoxFit.cover,
            ),
            8.verticalSpace,
            Text(
              productModel.title ?? '',
              style: AppFonts.font12BlackWeight400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${productModel.priceAfterDiscount} EGP',
              style: AppFonts.font14BlackWeight500,
            ),
          ],
        ),
      ),
    );
  }
}
