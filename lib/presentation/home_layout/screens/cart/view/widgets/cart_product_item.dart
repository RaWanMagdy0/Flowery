import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.kGray,
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/8/8b/Rose_flower.jpg',
                  width: 96.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              8.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rose Flower',
                    style: AppFonts.font16BlackWeight500,
                  ),
                  4.verticalSpace,
                  Text(
                    '15 Pink Rose Bouquet',
                    style: AppFonts.font14GreyWeight400,
                  ),
                  21.verticalSpace,
                  Text(
                    'EGP 600',
                    style: AppFonts.font14BlackWeight600,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 8.h,
            right: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(50.r),
              onTap: () {},
              child: SvgPicture.asset(AppImages.trashIcon),
            ),
          ),
          Positioned(
            bottom: 8.h,
            right: 0,
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {},
                  child: Icon(
                    Icons.remove,
                    color: AppColors.kBlack,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  '1',
                  style: AppFonts.font14BlackWeight600,
                ),
                8.horizontalSpace,
                InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {},
                  child: Icon(
                    Icons.add,
                    color: AppColors.kBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
