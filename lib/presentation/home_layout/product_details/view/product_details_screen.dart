import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/add_to_cart_button.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';
import '../../../../domain/entities/home_layout/product_details_entity.dart';
import '../../../../generated/l10n.dart';
import '../view_model/product_details_cubit.dart';
import '../view_model/product_details_states.dart';
import 'widget/product_details_loading.dart';

class ProductDetails extends StatefulWidget {
  final String productIt;

  const ProductDetails(this.productIt, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late ProductDetailsCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProductDetailsCubit>();
    viewModel.getProductDetails(productId: widget.productIt);
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        bloc: viewModel,
        buildWhen: (previous, current) {
          return current is ProductDetailsLoadingState ||
              current is ProductDetailsSuccessState ||
              current is ProductDetailsErrorState;
        },
        builder: (context, state) {
          if (state is ProductDetailsLoadingState) {
            return ProductDetailsLoading();
          } else if (state is ProductDetailsSuccessState) {
            final productDetailsEntity = state.success;
            final product = productDetailsEntity?.products?.firstWhere(
              (p) => p.id == widget.productIt,
            );
            if (product != null) {
              return CustomScrollView(
                slivers: [
                  buildSliverAppBar(product),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "EGP ${product.price} ",
                                    style: AppFonts.font20BlackWeight700,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        local.status,
                                        style: AppFonts.font16BlackWeight500,
                                      ),
                                      Text(
                                        local.inStock,
                                        style: AppFonts.font14GreyWeight400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              8.verticalSpace,
                              Text(
                                local.allPricesIncludeTax,
                                style: AppFonts.font13BlackWeight400,
                              ),
                              10.verticalSpace,
                              Text(
                                product.title ?? local.productTitle,
                                style: AppFonts.font16BlackWeight500,
                              ),
                              15.verticalSpace,
                              Text(
                                local.description,
                                style: AppFonts.font16BlackWeight500,
                              ),
                              5.verticalSpace,
                              Text(
                                product.description ??
                                    local.noDescriptionAvailable,
                                style: AppFonts.font14BlackWeight400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text(local.productNotFound));
            }
          } else if (state is ProductDetailsErrorState) {
            return Center(
              child:
                  Text(state.errorMessage ?? local.errorLoadingProductDetails),
            );
          } else {
            return Center(child: Text(local.unexpectedState));
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is ProductDetailsSuccessState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: AddToCartButton(productId: widget.productIt),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget buildSliverAppBar(ProductEntity product) {
    return SliverAppBar(
      expandedHeight: 500.h,
      pinned: true,
      stretch: true,
      forceMaterialTransparency: true,
      backgroundColor: AppColors.kWhite,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageSlideshow(
          initialPage: 0,
          indicatorColor: Colors.pink,
          indicatorPadding: 8.h,
          indicatorRadius: 5.w,
          indicatorBackgroundColor: Colors.grey,
          isLoop: true,
          children: product.images
                  ?.map(
                    (url) => CustomCachedNetworkImage(
                      imageUrl: url,
                      shimmerRadiusValue: 0,
                      fit: BoxFit.fill,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
