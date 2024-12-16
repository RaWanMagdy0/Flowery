import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/domain/entities/order/create_order/order_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';

class CustomOrderCard extends StatelessWidget {
  final OrderEntity? order;

  final OrderItemEntity? orderItem;
  const CustomOrderCard({
    super.key,
    required this.orderItem,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.kGray,
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppImages.flowerImage),
                ),
              ],
            ),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Text(
                  "",
                  style: AppFonts.font12BlackWeight400,
                ),
                4.verticalSpace,
                Text(
                  "EGP ${orderItem?.price}",
                  style: AppFonts.font12BlackWeight400
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                6.verticalSpace,
                Row(
                  children: [
                    Text(
                      order?.id ?? "",
                      style: AppFonts.font12BlackWeight400
                          .copyWith(color: AppColors.kGray),
                    ),
                  ],
                ),
                15.verticalSpace,
                CustomButton(
                  width: 140.w,
                  height: 35.h,
                  color: AppColors.kPink,
                  child: Text(
                    "Track Order",
                    style:
                        AppFonts.font16WhiteWeight500.copyWith(fontSize: 13.sp),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
