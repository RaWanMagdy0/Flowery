import '../../../core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          50.verticalSpace,
          Row(
            children: [
              Icon(Icons.arrow_back_ios_rounded),
              10.horizontalSpace,
              Text(
                "Checkout",
                style: AppFonts.font20BlackWeight700
                    .copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery time",
                style: AppFonts.font18BlackWeight500,
              ),
              Text(
                "Schedule",
                style: AppFonts.font12PinkWeight600.copyWith(fontSize: 18.sp),
              ),
            ],
          ),
          15.verticalSpace,
          Row(
            children: [
              Row(
                children: [Icon(Icons.access_time_rounded), Text(" instant,")],
              ),
              Text(
                "Arrive by 03 Sep 2024 , 11:00 AM",
                style: AppFonts.font14LightGreenWeight500,
              )
            ],
          )
        ],
      ),
    );
  }
}
