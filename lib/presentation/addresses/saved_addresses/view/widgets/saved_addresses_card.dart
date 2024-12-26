import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/routes/page_route_name.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';

class SavedAddressesCard extends StatelessWidget {
  final String city;
  final String street;
  final VoidCallback onDelete;

  const SavedAddressesCard({
    required this.city,
    required this.street,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kWhite,
      elevation: 12.sp,
      shadowColor: Color.fromRGBO(83, 83, 83, 0.25),
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AppImages.location,color: AppColors.kBlack,),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: AppFonts.font16BlackWeight500.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    street,
                    style: AppFonts.font13BlackWeight400
                        .copyWith(color: AppColors.kGray),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onDelete,
                  icon:SvgPicture.asset(
                    AppImages.trashIcon,
                    width: 20.sp,
                    height: 20.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, PageRouteName.addAndEditUserAddress);
                  },
                  icon: Image.asset(AppImages.editIcon,color: AppColors.kBlack),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
