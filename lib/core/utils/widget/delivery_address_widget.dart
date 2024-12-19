import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/fonts/app_fonts.dart';
import '../../styles/images/app_images.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final String city;
  final String lat;
  final String lang;
  final String? area;
  final VoidCallback? onChanged;

  const DeliveryAddressWidget({
    super.key,
    required this.city,
    required this.lat,
    required this.lang,
    this.onChanged,
    this.area,
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
        Expanded(
          child: Text(
            '$city - ($lat + $lang)',
            style: AppFonts.font14BlackWeight500,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
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
