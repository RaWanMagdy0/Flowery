import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../core/routes/page_route_name.dart'; // Add this import
import '../../../../../../../domain/entities/home/home_best_seller_product_entity.dart';
import '../../../view_model/home_view_model.dart';
import 'home_best_seller_item.dart';

class HomeBestSellerList extends StatelessWidget {
  const HomeBestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is HomeDataError) {
          return Center(
            child: Text(state.message ?? ''),
          );
        } else if (state is HomeDataLoaded) {
          final List<HomeBestSellerProduct> items =
              state.homeData?.bestSellerProducts ?? [];

          return SizedBox(
            height: 240.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Seller',
                        style: AppFonts.font18BlackWeight500,
                      ),
                      GestureDetector(
                        onTap: () => _navigateToBestSeller(context),
                        child: Text(
                          'View All',
                          style: AppFonts.font12PinkWeight500UnderlinedPink,
                        ),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: HomeBestSellerItem(
                          productModel: items[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _navigateToBestSeller(BuildContext context) {
    Navigator.pushNamed(context, PageRouteName.bestSeller);
  }
}