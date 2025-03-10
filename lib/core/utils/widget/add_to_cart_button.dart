import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../presentation/home_layout/screens/cart/view/cart_screen.dart';
import '../../../presentation/home_layout/screens/cart/view_model/cart_view_model.dart';
import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';
import '../../styles/images/app_images.dart';
import '../functions/dialogs/app_dialogs.dart';
import 'custom_button.dart';

class AddToCartButton extends StatelessWidget {
  final String productId;
  VoidCallback? whenAnimationFinished;

  AddToCartButton({
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
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: AppColors.kWhite,
                insetPadding: EdgeInsets.all(20.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          AppImages.pinkDoneAnimation,
                          height: 80.h,
                        ),
                        20.verticalSpace,
                        Text(
                          "Product added to cart successfully",
                          style: AppFonts.font18BlackWeight500
                              .copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  side: BorderSide(
                                      color: Colors.grey, width: 1.w),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                if (whenAnimationFinished != null) {
                                  whenAnimationFinished!();
                                }
                              },
                              child: Text(
                                "Continue Shopping",
                                style: AppFonts.font14GreyWeight400,
                              ),
                            ),
                            10.horizontalSpace,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kPink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  side: BorderSide(
                                      color: Colors.transparent, width: 1.w),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(),
                                  ),
                                );
                                if (whenAnimationFinished != null) {
                                  whenAnimationFinished!();
                                }
                              },
                              child: Text(
                                "View Cart",
                                style: AppFonts.font15WhiteWeight500
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
