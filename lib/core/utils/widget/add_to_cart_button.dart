import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/home_layout/screens/cart/view_model/cart_view_model.dart';
import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';
import '../functions/dialogs/app_dialogs.dart';
import 'custom_button.dart';

class AddToCartButton extends StatelessWidget {
  final String productId;

  const AddToCartButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CartViewModel>(),
      child: BlocListener<CartViewModel, CartState>(
        listener: (context, state) {
          if (state is AddToCartLoading) {
            AppDialogs.showLoading(context: context);
          } else if (state is AddToCartSuccess) {
            Navigator.pop(context);

            AppDialogs.showSuccessDialog(
              context: context,
              message: "Product added to cart successfully",
            );
          } else if (state is AddToCartError) {
            Navigator.pop(context);

            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: state.errorMessage,
            );
          }
        },
        child: CustomButton(
          onPressed: () {
            if (context.read<CartViewModel>().isUserLoggedIn == false) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: "You need to login to add products to cart",
              );
              return;
            }
            context.read<CartViewModel>().addProductToCart(productId);
          },
          color: AppColors.kPink,
          text: "Add to Cart",
          textStyle: AppFonts.font16WhiteWeight500,
        ),
      ),
    );
  }
}
