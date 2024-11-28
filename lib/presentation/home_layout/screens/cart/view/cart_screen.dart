import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/cart_app_bar.dart';
import 'widgets/cart_product_item.dart';
import 'widgets/cart_total_price_and_checkout_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: index == 4 ? 0 : 24.h),
          child: CartProductItem(),
        ),
      ),
      bottomNavigationBar: TotalPriceAndCheckoutButton(),
    );
  }
}
