import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/order_history_list.dart';

class GetOrdersHistory extends StatelessWidget {
  const GetOrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            "My orders",
            style: AppFonts.font20BlackWeight500,
          ),
          leading: Icon(Icons.arrow_back_ios_rounded),
          bottom: TabBar(
            unselectedLabelStyle: AppFonts.font16LightGreyWeight400,
            labelStyle: AppFonts.font16PinkWeight400,
            dividerColor: AppColors.kLighterGrey,
            indicatorWeight: 4.w,
            dividerHeight: 4.h,
            indicatorColor: AppColors.kPink,
            tabs: [
              Tab(
                child: Text("Active"),
              ),
              Tab(
                child: Text("Completed"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: ScrollPhysics(),
          children: [
            OrderHistoryList(),
            OrderHistoryList(),
          ],
        ),
      ),
    );
  }
}
