import 'package:flowery/presentation/home_layout/screens/home/view/widgets/home_discover/home_discover_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../domain/entities/home/home_discovery_entity.dart';
import '../../../view_model/home_view_model.dart';
import 'home_discover_item.dart';

class HomeDiscoverList extends StatelessWidget {
  const HomeDiscoverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoading) {
          return HomeDiscoverLoading();
        } else if (state is HomeDataError) {
          return Center(
            child: Text(state.message ?? ''),
          );
        } else if (state is HomeDataLoaded) {
          final List<HomeDiscovery> items = state.homeData?.discovery ?? [];

          return SizedBox(
            height: 332.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Discover something now',
                    style: AppFonts.font18BlackWeight500,
                  ),
                ),
                16.verticalSpace,
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return HomeDiscoverItem(
                        discoveryModel: items[index],
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
