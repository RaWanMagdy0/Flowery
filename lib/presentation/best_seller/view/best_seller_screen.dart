import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_item_card.dart';
import '../view_model/best_seller_state.dart';
import '../view_model/best_seller_view_model.dart';

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
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          forceMaterialTransparency: true,
          // TODO: use leading instead of icon button
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Sellers',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
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
            ],
          ),
          backgroundColor: AppColors.kWhite,
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
                padding: EdgeInsets.all(8.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final discount =
                      ((product.price - product.priceAfterDiscount) /
                              product.price *
                              100)
                          .round();

                  return FlowerCard(
                    title: product.title,
                    imageUrl: product.imageUrl,
                    price: 'EGP ${product.priceAfterDiscount}',
                    originalPrice: product.price.toString(),
                    descount: '$discount',
                    descountColor: Colors.green,
                    backgroundColor: Colors.white,
                    buttonColor: AppColors.kPink,
                    buttonTextColor: Colors.white,
                    width: 150.w,
                    height: 200.h,
                    titleSize: 12.sp,
                    priceSize: 15.sp,
                    onTap: () => Navigator.pushNamed(
                      context,
                      PageRouteName.productDetails,
                      arguments: product.id,
                    ),
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
