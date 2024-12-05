import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/custom_app_bar.dart';
import '../widget/delivery_address.dart';
import '../widget/it_is_gift.dart';
import '../widget/payment_method.dart';
import '../widget/total.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const String routeName = "CheckoutScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 160.h,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.kBackGroundGrey,
              height: 25.h,
            ),
            Column(
              children: [
                DeliveryAddress(onChanged: (String? value) {  },),
              ],
            ),
            Container(
              color: AppColors.kBackGroundGrey,
              height: 25.h,
            ),
            PaymentMethod(onChanged: (String? value) {  },),
            Container(
              color: AppColors.kBackGroundGrey,
              height: 25.h,
            ),
            ItIsGift(),
            Container(
              color: AppColors.kBackGroundGrey,
              height: 25.h,
            ),
            Total(),
          ],
        ),
      ),

    );
  }
}
