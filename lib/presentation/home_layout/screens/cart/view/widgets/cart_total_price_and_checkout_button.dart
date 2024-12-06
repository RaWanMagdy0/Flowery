import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../view_model/cart_view_model.dart';
import 'cart_price_info_widget.dart';

class TotalPriceAndCheckoutButton extends StatefulWidget {
  const TotalPriceAndCheckoutButton({super.key});

  @override
  State<TotalPriceAndCheckoutButton> createState() =>
      _TotalPriceAndCheckoutButtonState();
}

class _TotalPriceAndCheckoutButtonState
    extends State<TotalPriceAndCheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartViewModel, CartState>(
      builder: (context, state) {
        if (state is NoUserLogged || state is CartEmpty || state is CartError) {
          return SizedBox();
        } else if (state is CartLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerLoadingWidget(
                  height: 20.h,
                  width: 1.sw,
                ),
                16.verticalSpace,
                ShimmerLoadingWidget(
                  height: 20.h,
                  width: 1.sw,
                ),
                32.verticalSpace,
                ShimmerLoadingWidget(
                  height: 20.h,
                  width: 1.sw,
                ),
                16.verticalSpace,
              ],
            ),
          );
        } else {
          final num deliveryFees = 10;
          final num subTotalPrice =
              context.read<CartViewModel>().cart.totalPrice ?? 0;
          final num totalPrice = subTotalPrice + deliveryFees;

          return Container(
            margin: EdgeInsets.only(
              top: 8.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CartPriceInfoWidget(
                  title: 'Sub Total',
                  value: subTotalPrice.toString(),
                  titleStyle: AppFonts.font16GreyWeight400,
                  valueStyle: AppFonts.font16GreyWeight400,
                ),
                8.verticalSpace,
                CartPriceInfoWidget(
                  title: 'Delivery Fee',
                  value: deliveryFees.toString(),
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
                  value: totalPrice.toStringAsFixed(2),
                ),
                24.verticalSpace,
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, PageRouteName.addAndEditUserAddress);
                  },
                  text: 'Checkout',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
