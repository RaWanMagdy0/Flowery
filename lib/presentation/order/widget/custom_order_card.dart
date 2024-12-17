import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/domain/entities/home_layout/product_details_entity.dart';
import 'package:flowery/domain/entities/order/create_order/order_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/widget/custom_cached_network_image.dart';
import '../../home_layout/product_details/view_model/product_details_cubit.dart';
import '../../home_layout/product_details/view_model/product_details_states.dart';

class CustomOrderCard extends StatefulWidget {
  final OrderEntity? order;
  final OrderItemEntity? orderItem;

  const CustomOrderCard({
    super.key,
    required this.orderItem,
    required this.order,
  });

  @override
  State<CustomOrderCard> createState() => _CustomOrderCardState();
}

class _CustomOrderCardState extends State<CustomOrderCard> {
  late ProductDetailsCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProductDetailsCubit>();
    viewModel.getProductDetails(productId: widget.orderItem?.product ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is ProductDetailsLoadingState) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.kPink,
          ));
        } else if (state is ProductDetailsSuccessState) {
          final product = state.success?.products?.firstWhere(
            (p) => p.id == widget.orderItem?.product,
            orElse: () => ProductEntity(),
          );

          if (product?.id?.isNotEmpty ?? false) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageRouteName.productDetails,
                    arguments: widget.orderItem?.product);
              },
              child: Padding(
                padding: EdgeInsets.all(12.0.sp),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.kGray,
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomCachedNetworkImage(
                              imageUrl: product?.imgCover ??
                                  (product?.images != null &&
                                          product!.images!.isNotEmpty
                                      ? product.images!.first
                                      : ''),
                              width: 96.w,
                              height: 120.h,
                              shimmerRadiusValue: 8.r,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.verticalSpace,
                          Text(
                            product?.title ?? 'No Title',
                            style: AppFonts.font12BlackWeight400,
                          ),
                          4.verticalSpace,
                          Text(
                            "EGP ${widget.orderItem?.price}",
                            style: AppFonts.font12BlackWeight400
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          6.verticalSpace,
                          Row(
                            children: [
                              Text(
                                "Order Number \n#${widget.order?.id ?? ""}",
                                style: AppFonts.font12BlackWeight400
                                    .copyWith(color: AppColors.kGray),
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          CustomButton(
                            width: 140.w,
                            height: 35.h,
                            color: AppColors.kPink,
                            child: Text(
                              "Track Order",
                              style: AppFonts.font16WhiteWeight500
                                  .copyWith(fontSize: 13.sp),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('Product not found');
          }
        } else if (state is ProductDetailsErrorState) {
          return const Text('Error loading product');
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
