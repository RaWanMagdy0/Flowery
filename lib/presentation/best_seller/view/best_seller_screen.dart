import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late final BestSellerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<BestSellerViewModel>();
    _viewModel.getBestSellers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
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
        ),
      ),
      body: BlocBuilder<BestSellerViewModel, BestSellerState>(
        bloc: _viewModel,
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
                childAspectRatio: 0.7,
                crossAxisSpacing: 16.w,
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
                  originalPrice: 'EGP ${product.price}',
                  descount: '$discount',
                  descountColor: Colors.green,
                  backgroundColor: Colors.white,
                  buttonColor: AppColors.kPink,
                  buttonTextColor: Colors.white,
                  width: 150.w,
                  height: 200.h,
                  titleSize: 12.sp,
                  priceSize: 12.sp,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/product-details',
                    arguments: product.id,
                  ),
                  onButtonPressed: () {
                    // Add to cart logic
                  },
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