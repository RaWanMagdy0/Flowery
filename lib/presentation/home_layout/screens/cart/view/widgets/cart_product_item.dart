import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/widget/custom_cached_network_image.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CustomCachedNetworkImage(
              imageUrl: cartProduct.product?.imgCover,
              width: 96.w,
              height: 100.h,
              shimmerRadiusValue: 8.r,
              fit: BoxFit.cover,
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        cartProduct.product?.title ?? '',
                        style: AppFonts.font16BlackWeight500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50.r),
                      onTap: () {
                        context.read<CartViewModel>().removeProductFromCart(
                              cartProduct.product?.id ?? '',
                            );
                      },
                      child: SvgPicture.asset(
                        AppImages.trashIcon,
                        matchTextDirection: true,
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                Text(
                  '15 Pink Rose Bouquet',
                  style: AppFonts.font14GreyWeight400,
                ),
                21.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "EGP ${cartProduct.totalPrice.toString()}",
                      style: AppFonts.font14BlackWeight600,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () {
                            if ((cartProduct.quantity ?? 0) > 1) {
                              final num numQuantity = cartProduct.quantity! - 1;

                              context
                                  .read<CartViewModel>()
                                  .updateCartProductQuantity(
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
                        8.verticalSpace,
                        Text(
                          cartProduct.quantity.toString(),
                          style: AppFonts.font14BlackWeight600,
                        ),
                        8.verticalSpace,
                        InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () {
                            final num numQuantity = cartProduct.quantity! + 1;

                            context
                                .read<CartViewModel>()
                                .updateCartProductQuantity(
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
