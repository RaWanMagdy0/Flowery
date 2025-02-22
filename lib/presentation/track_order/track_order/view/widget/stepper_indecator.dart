import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepperIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps = ["Address", "Payment", "Track order"];

  StepperIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(steps.length, (index) {
            bool isActive = (index + 1) == currentStep;
            return Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.kPink : AppColors.kWhite,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? AppColors.kPink : AppColors.kLightGrey,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActive ? AppColors.kWhite : AppColors.kGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (index != steps.length - 1)
                  Container(
                    width: 50.w,
                    height: 2.h,
                    color: AppColors.kLightGrey,
                  ),
              ],
            );
          }),
        ),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(steps.length, (index) {
            return SizedBox(
              width: 90.w,
              child: Text(
                steps[index],
                textAlign: TextAlign.center,
                style: AppFonts.font12LightGreyWeight400,
              ),
            );
          }),
        ),
      ],
    );
  }
}
