import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_occasion_entity.dart';
import '../../../view_model/home_view_model.dart';
import 'home_occasion_item.dart';

class HomeOccasionsList extends StatelessWidget {
  const HomeOccasionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoading) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (state is HomeDataError) {
          return Center(
            child: Text(state.message ?? ''),
          );
        } else if (state is HomeDataLoaded) {
          final List<HomeOccasion> items = state.homeData?.occasions ?? [];

          return SizedBox(
            height: 222.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Occasions',
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
                      return HomeOccasionItem(
                        occasionModel: items[index],
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
