import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/const/checkout_page_string.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/presentation/order/view_model/order_cubit.dart';
import 'package:flowery/presentation/order/view_model/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/di.dart';
import '../../../data/models/order/request/create_order_request/create_order_request.dart';
import '../../../data/models/order/request/create_order_request/shipping_address_request.dart';
import '../../home_layout/screens/cart/view_model/cart_view_model.dart';

class Total extends StatefulWidget {
  Total({super.key});
  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  late OrderCubit viewModel;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is CheckoutLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.kPink,
              ),
            );
          } else if (state is CheckoutErrorState) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          } else if (state is CheckoutSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showSuccessDialog(
                context: context,
                message: "Order placed successfully!",
              );
            });
          }
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
                        "${(context.read<CartViewModel>().cart.totalPrice ?? 0 )+ 10} EGP",
                        style: AppFonts.font18BlackWeight500,
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      if (selectedAddress != null) {
                        final shippingAddress = ShippingAddressRequest(
                          city: selectedAddress!.split('-')[0],
                          street: selectedAddress!.split('-')[1],
                        );
                        final createOrderRequest = CreateOrderRequest(
                          shippingAddress: shippingAddress,
                        );
                        viewModel.createOrder(createOrderRequest);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please select a delivery address")),
                        );
                      }
                    },
                    color: AppColors.kPink,
                    text: CheckoutStrings.placeOrder,
                    textStyle: AppFonts.font16WhiteWeight500,
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          );
        });
  }
}
