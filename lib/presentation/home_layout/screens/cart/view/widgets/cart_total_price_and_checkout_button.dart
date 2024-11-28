import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import 'cart_price_info_widget.dart';

class TotalPriceAndCheckoutButton extends StatelessWidget {
  const TotalPriceAndCheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartPriceInfoWidget(
            title: 'Sub Total',
            value: '100',
            titleStyle: AppFonts.font16GreyWeight400,
            valueStyle: AppFonts.font16GreyWeight400,
          ),
          8.verticalSpace,
          CartPriceInfoWidget(
            title: 'Delivery Fee',
            value: '10',
            titleStyle: AppFonts.font16GreyWeight400,
            valueStyle: AppFonts.font16GreyWeight400,
          ),
          16.verticalSpace,
          Divider(
            color: AppColors.kLightGrey,
          ),
          8.verticalSpace,
          CartPriceInfoWidget(
            title: 'Total',
            value: '110',
          ),
          24.verticalSpace,
          CustomButton(
            onPressed: () {},
            text: 'Checkout',
          ),
        ],
      ),
    );
  }
}
