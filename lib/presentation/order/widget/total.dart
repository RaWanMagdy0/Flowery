import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/presentation/order/view_model/order_cubit.dart';
import 'package:flowery/presentation/order/view_model/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/di.dart';

class Total extends StatefulWidget {
  Total({super.key});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
 // late OrderCubit viewModel;

  @override
  void initState() {
    super.initState();
 //   viewModel = getIt.get<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return
    /*****************

    BlocBuilder<OrderCubit, OrderState>(
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
        return
        *****************/
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: AppFonts.font16GreyWeight400,
                  ),
                  Text(
                    "100",
                 //   "${viewModel.subTotal}",
                    style: AppFonts.font16GreyWeight400,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DeliveryFee",
                    style: AppFonts.font16GreyWeight400,
                  ),
                  Text(
                    "10",
                 //   "${viewModel.deliveryFee}",
                    style: AppFonts.font16GreyWeight400,
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: AppFonts.font18BlackWeight500,
                  ),
                  Text(
                    "110",
                   // "${viewModel.total}",
                    style: AppFonts.font18BlackWeight500,
                  ),
                ],
              ),
              30.verticalSpace,
              CustomButton(
                onPressed: () {
                //  viewModel.createOrder(createOrderRequest);
                },
                color: AppColors.kPink,
                text: "Place Order",
                textStyle: AppFonts.font16WhiteWeight500,
              ),
              10.verticalSpace,
            ],
          ),
        );
  }
}
