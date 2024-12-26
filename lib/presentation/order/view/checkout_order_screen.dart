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

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCubit>();

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
                      onChanged: (String? value) {
                        // Handle value change (optional)
                      },
                      handlePaymentMethod: (isCash) {
                        if (selectedAddress != null) {
                          final parts = selectedAddress!.split('-');
                          final city = parts.isNotEmpty ? parts[0] : "";
                          final street = parts.length > 1 ? parts[1] : "";
                          final phone = parts.length > 2 ? parts[2] : "";

                          final shippingAddressRequest = ShippingAddressRequest(
                              city: city, street: street, phone: phone);

                          orderCubit.handlePaymentMethod(
                              shippingAddressRequest, isCash);
                        } else {
                          // Show an error or message if no address is selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.kBabyPink,
                              content: const Text(
                                "Please select a delivery address before proceeding.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
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
