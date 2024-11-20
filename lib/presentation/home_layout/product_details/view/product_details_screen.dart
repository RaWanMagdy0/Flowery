import 'package:flowery/presentation/home_layout/product_details/view_model/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/const/app_string.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../domain/entities/home_layout/ProductDetailsEntity.dart';
import '../view_model/product_details_states.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = "ProductDetails";

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  var viewModel = getIt.get<ProductDetailsCubit>();
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as ProductEntity;

    return BlocListener<ProductDetailsCubit, ProductDetailsStates>(
        bloc: viewModel,
        listener: (context, state) => _handleStateChange(state),
        child: Scaffold(
          body: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: AppColors.kBabyPink,
                          height: 390.h,
                          width: 356.w,
                          child:
                          ClipRRect(
                            child: ImageSlideshow(
                              initialPage: 0,
                              indicatorColor: Colors.pink,
                              indicatorPadding: 10.h,
                              indicatorRadius: 5.w,
                              indicatorBackgroundColor: Colors.grey,
                              isLoop: true,
                              children:
                              args.images!
                                  .map((url) => Image.network(
                                url,
                                fit: BoxFit.scaleDown,
                                // height: 300.h,
                                width: double.infinity,
                              ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25.h,
                          left: 2.h,
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 25.sp,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                args.price.toString(),
                                style: AppFonts.font20BlackWeight700,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.status,
                                    style: AppFonts.font16BlackWeight500,
                                  ),
                                  Text(" In stock", style: AppFonts.font14GreyWeight400)
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(AppStrings.allPricesIncludeTax,
                                  style: AppFonts.font13BlackWeight400),
                            ],
                          ),
                          Row(
                            children: [
                              Text("15 pink Rose Bouquet",
                                  style: AppFonts.font16BlackWeight500),
                            ],
                          ),
                          15.verticalSpace,
                          Row(
                            children: [
                              Text(AppStrings.description,
                                  style: AppFonts.font16BlackWeight500)
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              Text(
                                args.description ?? "",
                                style: AppFonts.font14BlackWeight400,
                              ),
                            ],
                          ),
                          15.verticalSpace,
                          Row(
                            children: [
                              Text("Bouquet include",
                                  style: AppFonts.font16BlackWeight500)
                            ],
                          ),
                          5.verticalSpace,
                          Row(
                            children: [Text("Ponl reses : "), Text("15")],
                          ),
                          Row(
                            children: [
                              Text("White wrap"),
                            ],
                          ),
                          15.verticalSpace,
                          CustomButton(
                            onPressed: () {},
                            color: AppColors.kPink,
                            text: AppStrings.addToCart,
                            textStyle: AppFonts.font16WhiteWeight500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              ),
        ));
  }

  dynamic _handleStateChange(ProductDetailsStates state) {
    if (state is ProductDetailsSuccessState) {
      Navigator.pop(context);
    } else if (state is ProductDetailsLoadingState) {
      AppDialogs.showLoading(context: context);
    } else if (state is ProductDetailsErrorState) {
      Navigator.pop(context);
      AppDialogs.showErrorDialog(
        context: context,
        errorMassage: state.errorMessage ?? "An unknown error occurred",
      );
    }
  }
}
