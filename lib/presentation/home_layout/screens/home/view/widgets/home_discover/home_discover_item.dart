import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../../core/utils/widget/blur_effect.dart';
import '../../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../../domain/entities/home/home_discovery_entity.dart';

class HomeDiscoverItem extends StatelessWidget {
  final HomeDiscovery discoveryModel;

  const HomeDiscoverItem({
    super.key,
    required this.discoveryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 223.w,
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.only(
        top: 165.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: NetworkImage(discoveryModel.imageUrl ?? ''),
          fit: BoxFit.fitHeight,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: BlurEffect(
        sigmaX: 10,
        sigmaY: 10,
        bottomLeftBorderRadius: 10.r,
        bottomRightBorderRadius: 10.r,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                discoveryModel.title ?? '',
                style: AppFonts.font14LightWhiteWeight500,
              ),
              8.verticalSpace,
              CustomButton(
                onPressed: () {},
                borderColor: AppColors.kWhite,
                color: Colors.transparent,
                text: "Gift now",
                textStyle: AppFonts.font14LightWhiteWeight500,
                borderRadius: 8.r,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                height: 32.h,
                width: 80.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
