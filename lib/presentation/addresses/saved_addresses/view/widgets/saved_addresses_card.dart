import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAddressesCard extends StatelessWidget {
  final String city;
  final String street;
  const SavedAddressesCard(
      {required this.city, required this.street, super.key});

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
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 20.sp,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: AppFonts.font16BlackWeight500.copyWith(fontSize: 16),
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
                  onPressed: () {},
                  icon:
                      Icon(Icons.delete, color: AppColors.kError, size: 20.sp),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: AppColors.kGray, size: 20.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
