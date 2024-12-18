import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/routes/page_route_name.dart';
import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_occasion_entity.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../view_model/home_view_model.dart';
import 'home_occasion_item.dart';
import 'home_occasions_loading.dart';

class HomeOccasionsList extends StatelessWidget {
  const HomeOccasionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        final local = S.of(context);
        if (state is HomeDataLoading) {
          return HomeOccasionsLoading();
        } else if (state is HomeDataError) {
          return Center(
            child: Text(state.message ?? ''),
          );
        } else if (state is HomeDataLoaded) {
          final List<HomeOccasion> items = state.homeData?.occasions ?? [];

          return SizedBox(
            height: 225.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        local.occasionAppBar,
                        style: AppFonts.font18BlackWeight500,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PageRouteName.occasion);
                        },
                        child: Text(
                          local.viewAll,
                          style: AppFonts.font15PinkWeight500UnderlinedPink,
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
