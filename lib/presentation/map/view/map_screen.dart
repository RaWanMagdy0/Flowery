import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/presentation/map/view/wedgit/map_wiget_track.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MapWidgetTrack(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estimated arrival",
                  style: AppFonts.font14GreyWeight500,
                ),
                5.verticalSpace,
                Text(
                  "03 Sep 2024, 11:00 AM",
                  style: AppFonts.font16BlackWeight500,
                ),
              ],
            ),
          ),
          5.verticalSpace,
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: ClipOval(
                        child: Image.asset(
                          AppImages.flowerImage,
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mohamed"),
                        5.verticalSpace,
                        Text("Is your delivery hero for today")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.kPink,
                        ),
                        25.horizontalSpace,
                        Icon(
                          Icons.message,
                          color: AppColors.kPink,
                        ),
                      ],
                    )
                  ],
                ),
                20.verticalSpace,
                CustomButton(
                  text: "Order Details",
                  onPressed: () {},
                  color: AppColors.kPink,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
