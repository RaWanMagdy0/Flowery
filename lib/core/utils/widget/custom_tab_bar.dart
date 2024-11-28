import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';

class TabBarWidget extends StatelessWidget {
  final List<String> tabTitles;
  final List<Widget> tabViews;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? indicatorColor;
  final bool isScrollable;
  final Color? dividerColor;
  final Color? labelColor;
  final Color? textColor;
  final TextScaler? textScale;
  final double? dividerHeight;

  const TabBarWidget({
    super.key,
    required this.tabTitles,
    required this.tabViews,
    this.selectedTextStyle,
    this.labelColor,
    this.unselectedTextStyle,
    this.indicatorColor,
    this.isScrollable = false,
    this.dividerColor,
    this.textScale,
    this.dividerHeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TabBar Widget"),
          bottom: TabBar(
            isScrollable: isScrollable,
            indicatorColor: indicatorColor ?? Theme.of(context).primaryColor,
            labelStyle: selectedTextStyle,
            unselectedLabelStyle: unselectedTextStyle,
            indicatorWeight: 1.h,
            dividerColor: AppColors.kWhite,
            tabs: tabTitles
                .map(
                  (title) => Tab(
                    child: Text(title),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarWidget(
          tabTitles: ["All", "Vases", "Boxes", "Flowers", "Gifts"],
          tabViews: [
            Center(child: Text("All Items")),
            Center(child: Text("Vases Items")),
            Center(child: Text("Boxes Items")),
            Center(child: Text("Flowers Items")),
            Center(child: Text("Gifts Items")),
          ],
          selectedTextStyle: AppFonts.font16PinkWeight400,
          unselectedTextStyle: AppFonts.font16LightGreyWeight400,
          indicatorColor: AppColors.kPink,
        ),
      ),
    );
  }
}
