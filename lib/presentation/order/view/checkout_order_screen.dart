import 'package:flowery/presentation/order/view_model/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
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
  late OrderCubit viewModel;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<OrderCubit>();
  }

  void _handlePaymentMethod(bool isCash) {
    final parts = selectedAddress!.split('-');
    final shippingAddressRequest = ShippingAddressRequest(
      city: parts[0],
      street: parts[1],
      phone: parts[2],
    );

    viewModel.handlePaymentMethod(shippingAddressRequest, isCash);
  }

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
                      handlePaymentMethod: _handlePaymentMethod,
                      hasSelectedAddress: selectedAddress != null,
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
