import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_category_entity.dart';
import '../../../view_model/home_view_model.dart';
import 'home_categories_loading.dart';
import 'home_category_item.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoading) {
          return HomeCategoriesLoading();
        } else if (state is HomeDataError) {
          return Center(
            child: Text(state.message ?? ''),
          );
        } else if (state is HomeDataLoaded) {
          final List<HomeCategory> items = state.homeData?.categories ?? [];

          return SizedBox(
            height: 156.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: AppFonts.font18BlackWeight500,
                      ),
                      InkWell(
                        onTap: () {},
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
                      return HomeCategoryItem(
                        categoryModel: items[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
