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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          productModel.imageUrl ?? '',
          width: 131.w,
          height: 151.h,
          fit: BoxFit.cover,
        ),
        8.verticalSpace,
        Text(
          productModel.title ?? '',
          style: AppFonts.font12BlackWeight400,
        ),
        Text(
          '${productModel.priceAfterDiscount} EGP',
          style: AppFonts.font14BlackWeight500,
        ),
      ],
    );
  }
}
