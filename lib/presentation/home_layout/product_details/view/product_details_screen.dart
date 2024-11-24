import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../view_model/product_details_cubit.dart';
import '../view_model/product_details_states.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = getIt.get<ProductDetailsCubit>();
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        bloc: viewModel..getProductDetails(productId: productId),
        builder: (context, state) {
          if (state is ProductDetailsLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.kPink,
            ));
          } else if (state is ProductDetailsSuccessState) {
            final productDetailsEntity = state.success;
            final product = productDetailsEntity?.products?.firstWhere(
              (p) => p.id == productId,
            );
            if (product != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 500.h,
                          width: double.infinity,
                          child: ClipRRect(
                            child: ImageSlideshow(
                              initialPage: 0,
                              indicatorColor: Colors.pink,
                              indicatorPadding: 8.h,
                              indicatorRadius: 5.w,
                              indicatorBackgroundColor: Colors.grey,
                              isLoop: true,
                              children: product.images
                                      ?.map((url) => Image.network(
                                            url,
                                            fit: BoxFit.contain,
                                          ))
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25.h,
                          left: 2.h,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_sharp, size: 25.sp),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EGP ${product.price} ",
                                style: AppFonts.font20BlackWeight700,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Status:",
                                    style: AppFonts.font16BlackWeight500,
                                  ),
                                  Text(" In stock",
                                      style: AppFonts.font14GreyWeight400),
                                ],
                              ),
                            ],
                          ),
                          8.verticalSpace,
                          Text(
                            "All prices include tax",
                            style: AppFonts.font13BlackWeight400,
                          ),
                          10.verticalSpace,
                          Text(
                            product.title ?? "Product Title",
                            style: AppFonts.font16BlackWeight500,
                          ),
                          15.verticalSpace,
                          Text(
                            "Description",
                            style: AppFonts.font16BlackWeight500,
                          ),
                          5.verticalSpace,
                          ReadMoreText(
                            product.description ?? "No description available",
                            style: AppFonts.font14BlackWeight400,
                            trimLines: 4,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: "Show More",
                            trimExpandedText: "Show Less",
                            moreStyle:
                                AppFonts.font12PinkWeight500UnderlinedPink,
                            lessStyle:
                                AppFonts.font12PinkWeight500UnderlinedPink,
                          ),
                          15.verticalSpace,
                          CustomButton(
                            onPressed: () {},
                            color: AppColors.kPink,
                            text: "Add to Cart",
                            textStyle: AppFonts.font16WhiteWeight500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Product not found."));
            }
          } else if (state is ProductDetailsErrorState) {
            return Center(
              child:
                  Text(state.errorMessage ?? "Error loading product details"),
            );
          } else {
            return Center(child: Text("Unexpected state."));
          }
        },
      ),
    );
  }
}
