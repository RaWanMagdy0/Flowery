import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../widget/custom_app_bar.dart';
import '../widget/delivery_address.dart';
import '../widget/it_is_gift.dart';
import '../widget/payment_method.dart';
import '../widget/total.dart';

class CheckoutOrderScreen extends StatefulWidget {
  const CheckoutOrderScreen({super.key});
  static const String routeName = "CheckoutScreen";

  @override
  State<CheckoutOrderScreen> createState() => _CheckoutOrderScreenState();
}

class _CheckoutOrderScreenState extends State<CheckoutOrderScreen> {
  String? selectedAddress;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.kPink,
      onRefresh: () async {},
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarHeight: 160.h,
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.kBackGroundGrey,
                      height: 25.h,
                    ),
                    DeliveryAddress(
                      onChanged: (String? value) {
                        setState(() {
                          selectedAddress = value;
                        });
                      },
                    ),
                    Container(
                      color: AppColors.kBackGroundGrey,
                      height: 25.h,
                    ),
                    PaymentMethod(
                      onChanged: (String? value) {},
                    ),
                    Container(
                      color: AppColors.kBackGroundGrey,
                      height: 25.h,
                    ),
                    ItIsGift(),
                    Container(
                      color: AppColors.kBackGroundGrey,
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Total(selectedAddress: selectedAddress),
            ),
          ],
        ),
      ),
    );
  }
}
