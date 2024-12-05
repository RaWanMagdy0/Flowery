import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Total extends StatelessWidget {
  const Total({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sub Total",style: AppFonts.font16GreyWeight400,),
              Text("100",style: AppFonts.font16GreyWeight400,),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("DeliveryFee",style: AppFonts.font16GreyWeight400,),
              Text("10",style: AppFonts.font16GreyWeight400,),

            ],
          ),
        Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",style: AppFonts.font18BlackWeight500,),
              Text("110",style: AppFonts.font18BlackWeight500,),

            ],
          ),
          30.verticalSpace,
          CustomButton(
            onPressed: (){},
            color: AppColors.kPink,
            text: "Place Order",
            textStyle: AppFonts.font16WhiteWeight500,
          ),
          10.verticalSpace,

        ],
      ),
    );
  }
}
