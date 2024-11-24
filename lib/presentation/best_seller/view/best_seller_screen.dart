import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_item_card.dart';
import '../../../domain/repository/best_seller_repository_impl.dart';
import '../view_model/best_seller_state.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BestSellerViewModel>().getBestSellers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.kBlack),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Text(
                'Best Sellers',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kBlack,
                ),
              ),
              5.verticalSpace,
              Text(
                'Bloom with our exquisite best sellers',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: BlocBuilder<BestSellerViewModel, BestSellerState>(
        builder: (context, state) {
          return switch (state) {
            BestSellerLoading() => const Center(
              child: CircularProgressIndicator(color: AppColors.kPink),
            ),
            BestSellerError(message: final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 60.sp),
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            BestSellerLoaded(products: final products) => GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final discount = ((product.price - product.priceAfterDiscount) /
                    product.price *
                    100)
                    .round();

                return FlowerCard(
                  title: product.title,
                  imageUrl: product.imageUrl,
                  price: 'EGP ${product.priceAfterDiscount}',
                  originalPrice: '${product.price}',
                  descount: '$discount',
                  descountColor: Colors.green,
                  backgroundColor: Colors.white,
                  buttonColor: AppColors.kPink,
                  buttonTextColor: Colors.white,
                  titleSize: 12.sp,

                  priceSize: 14.sp,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      PageRouteName.productDetails,
                      arguments: product.id,
                    );
                  },
                  onButtonPressed: () {},
                );
              },
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}