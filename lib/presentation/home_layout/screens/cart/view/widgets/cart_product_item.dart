import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../domain/entities/cart/cart_product_entity.dart';
import '../../view_model/cart_view_model.dart';

class CartProductItem extends StatelessWidget {
  final CartProduct cartProduct;

  const CartProductItem({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.kGray,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    cartProduct.product?.imgCover ?? '',
                    width: 96.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              8.horizontalSpace,
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: Text(
                        cartProduct.product?.title ?? '',
                        style: AppFonts.font16BlackWeight500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '15 Pink Rose Bouquet',
                      style: AppFonts.font14GreyWeight400,
                    ),
                    21.verticalSpace,
                    Text(
                      cartProduct.totalPrice.toString(),
                      style: AppFonts.font14BlackWeight600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.h,
            right: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(50.r),
              onTap: () {
                context.read<CartViewModel>().removeProductFromCart(
                      cartProduct.product?.id ?? '',
                    );
              },
              child: SvgPicture.asset(AppImages.trashIcon),
            ),
          ),
          Positioned(
            bottom: 8.h,
            right: 0,
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    if ((cartProduct.quantity ?? 0) > 1) {
                      final num numQuantity = cartProduct.quantity! - 1;

                      context.read<CartViewModel>().updateCartProductQuantity(
                            cartProduct.product?.id ?? '',
                            numQuantity.toInt(),
                          );
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    color: AppColors.kBlack,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  cartProduct.quantity.toString(),
                  style: AppFonts.font14BlackWeight600,
                ),
                8.horizontalSpace,
                InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    final num numQuantity = cartProduct.quantity! + 1;

                    context.read<CartViewModel>().updateCartProductQuantity(
                          cartProduct.product?.id ?? '',
                          numQuantity.toInt(),
                        );
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.kBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
