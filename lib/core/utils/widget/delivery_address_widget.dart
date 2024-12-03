import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';
import '../../styles/images/app_images.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final VoidCallback? onChanged;

  const DeliveryAddressWidget({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
