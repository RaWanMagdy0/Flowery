import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/const/checkout_page_string.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../home_layout/screens/cart/view_model/cart_view_model.dart';

class Total extends StatefulWidget {
  final String? selectedAddress;
  final VoidCallback onPlaceOrder;

  const Total({super.key, required this.selectedAddress, required this.onPlaceOrder});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CheckoutStrings.subTotal,
                  style: AppFonts.font16GreyWeight400,
                ),
                Text(
                  "${context.read<CartViewModel>().cart.totalPrice ?? 0}  EGP",
                  style: AppFonts.font16GreyWeight400,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CheckoutStrings.deliveryFee,
                  style: AppFonts.font16GreyWeight400,
                ),
                Text(
                  "10  EGP",
                  style: AppFonts.font16GreyWeight400,
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CheckoutStrings.total,
                  style: AppFonts.font18BlackWeight500,
                ),
                Text(
                  "${(context.read<CartViewModel>().cart.totalPrice ?? 0) + 10} EGP",
                  style: AppFonts.font18BlackWeight500,
                ),
              ],
            ),
            30.verticalSpace,
            CustomButton(
              onPressed: widget.onPlaceOrder,
              color: AppColors.kPink,
              text: CheckoutStrings.placeOrder,
              textStyle: AppFonts.font16WhiteWeight500,
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}