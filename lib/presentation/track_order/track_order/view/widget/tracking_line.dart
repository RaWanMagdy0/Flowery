import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTrackingTimeline extends StatelessWidget {
  final List<OrderStep> steps;
  const OrderTrackingTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        bool isCompleted = steps[index].isCompleted;
        bool isLast = index == steps.length - 1;
        bool isNextCompleted = !isLast && steps[index + 1].isCompleted;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isCompleted ? AppColors.kPink : AppColors.kLightGrey,
                      width: 2.w,
                    ),
                    color: isCompleted ? Colors.white : Colors.grey[200],
                  ),
                  child: isCompleted
                      ? Icon(Icons.circle, size: 12.sp, color: Colors.pink)
                      : SizedBox.shrink(),
                ),
                if (!isLast)
                  Container(
                    width: 1.w,
                    height: 55.h,
                    color: isNextCompleted
                        ? AppColors.kPink
                        : AppColors.kLightGrey,
                  ),
              ],
            ),
            12.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  steps[index].title,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                Text(
                  steps[index].timestamp,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.kLightGrey,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class OrderStep {
  final String title;
  final String timestamp;
  final bool isCompleted;

  OrderStep(
      {required this.title,
      required this.timestamp,
      required this.isCompleted});
}
