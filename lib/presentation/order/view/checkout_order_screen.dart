import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/presentation/order/view_model/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../data/models/payment/request/payment_request_model.dart';
import '../../home_layout/screens/cart/view_model/cart_view_model.dart';
import '../view_model/order_state.dart';
import '../widget/custom_app_bar.dart';
import '../widget/delivery_address.dart';
import '../widget/it_is_gift.dart';
import '../widget/payment_method.dart';
import '../widget/payment_web_view.dart';
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
  bool? isCash;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<OrderCubit>();
  }

  void _handlePaymentMethod(bool isCash) {
    setState(() {
      this.isCash = isCash;
    });
  }

  void _placeOrder() {
    List<String> missingRequirements = [];
    if (selectedAddress == null) {
      missingRequirements.add("Delivery Address");
    }
    if (isCash == null) {
      missingRequirements.add("Payment Method");
    }
    if (missingRequirements.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.kBabyPink,
          content: Text(
            "Please Select ${missingRequirements.join(" & ")}",
            style: AppFonts.font14GreyWeight400,
          ),
        ),
      );
      return;
    }

    final parts = selectedAddress!.split('-');
    final shippingAddressRequest = ShippingAddressRequest(
      city: parts[1],
      street: parts[0],
      phone: parts[2],
    );

    if (isCash!) {
      viewModel.handlePaymentMethod(shippingAddressRequest, true).then((_) {
        if (viewModel.orderEntity != null) {
          FirebaseFirestore.instance.collection('orders').add({
            'id': viewModel.orderEntity!.id,
            'product': viewModel.orderEntity!.product != null
                ? {
              'name': viewModel.orderEntity!.product!.title,
              'price': viewModel.orderEntity!.product!.price,
            }
                : null,
            'user': viewModel.orderEntity!.user,
            'orderItems': viewModel.orderEntity!.orderItems
                ?.map((item) => {
              'price': item.price,
              'quantity': item.quantity,
            })
                .toList(),
            'totalPrice': viewModel.orderEntity!.totalPrice,
            'paymentType': viewModel.orderEntity!.paymentType,
            'isPaid': viewModel.orderEntity!.isPaid,
            'isDelivered': viewModel.orderEntity!.isDelivered,
            'state': viewModel.orderEntity!.state,
            'createdAt': viewModel.orderEntity!.createdAt,
            'updatedAt': viewModel.orderEntity!.updatedAt,
            'orderNumber': viewModel.orderEntity!.orderNumber,
            'v': viewModel.orderEntity!.v,
            'address': {
              'city': parts[1],
              'street': parts[0],
              'phone': parts[2],
            },
          });
        }
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentWebView(
            paymentLink:
            "https://checkout.stripe.com/c/pay/cs_test_a12wg5AMebQdH17D1baN8S26eyPQQrQj7joTlKyXxvGUWKEdnStpalfrXr#fidkdWxOYHwnPyd1blpxYHZxWjA0SHViYl1ANVYyU2pOX2hVVW9ASmZBUElpa2FLVnBUQGo2UFduUEhIXHx9aEhjanBGZ1NxZ3RKNVVtXWxcSTJ8Qzx2aWZkUEBpMXJCXVRHTkIxZzBSZmhENTUxYHVKMUpQVycpJ2N3amhWYHdzYHcnP3F3cGApJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is CheckoutSuccessState) {
          context.read<CartViewModel>().clearCart();
          AppDialogs.showSuccessDialog(
            context: context,
            message: "Order Placed Successfully",
          );
        }
      },
      child: RefreshIndicator(
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
                child: Total(
                  selectedAddress: selectedAddress,
                  onPlaceOrder: _placeOrder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
