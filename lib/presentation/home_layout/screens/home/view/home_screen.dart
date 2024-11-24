import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../view_model/home_view_model.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_best_seller/home_best_seller_list.dart';
import 'widgets/home_categories/home_categories_list.dart';
import 'widgets/home_discover/home_discover_list.dart';
import 'widgets/home_occasions/home_occasions_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeViewModel>().getHomeData();
        },
        backgroundColor: AppColors.kBabyPink,
        color: AppColors.kPink,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            HomeDiscoverList(),
            24.verticalSpace,
            HomeCategoriesList(),
            24.verticalSpace,
            HomeBestSellerList(),
            24.verticalSpace,
            HomeOccasionsList(),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
