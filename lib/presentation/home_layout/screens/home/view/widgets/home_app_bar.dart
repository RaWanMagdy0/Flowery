import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../widgets/search_bar_widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoWithTitle,
                height: 35.h,
                width: 95.w,
              ),
              15.horizontalSpace,
              SearchBarWidget(),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Image.asset(AppImages.location),
              8.horizontalSpace,
              Text(
                'Deliver to ',
                style: AppFonts.font14BlackWeight400,
              ),
              Text(
                '2XVP+XC - Sheikh Zayed',
                style: AppFonts.font14BlackWeight500,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 32.r,
                color: AppColors.kPink,
              ),
              // Added dropdown icon
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 52.h);
}
