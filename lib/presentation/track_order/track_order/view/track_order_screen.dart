import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/presentation/track_order/track_order/view/widget/stepper_indecator.dart';
import 'package:flowery/presentation/track_order/track_order/view/widget/tracking_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/fonts/app_fonts.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Track Order",
          style: AppFonts.font20BlackWeight500.copyWith(fontSize: 20.sp),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            Center(
              child: StepperIndicator(currentStep: 3),
            ),
            40.verticalSpace,
            Image.asset(AppImages.car, fit: BoxFit.cover),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: OrderTrackingTimeline(
                steps: [
                  OrderStep(
                      title: "Received your order",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: true),
                  OrderStep(
                      title: "Preparing your order",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: true),
                  OrderStep(
                      title: "Out for delivery",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: true),
                  OrderStep(
                      title: "Delivered",
                      timestamp: "03 Sep 2024 - 2:10",
                      isCompleted: false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: () {},
                text: "Show Map",
              ),
            )
          ],
        ),
      ),
    );
  }
}
