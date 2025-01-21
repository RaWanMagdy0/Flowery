import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';


class SavedAddressesCard extends StatefulWidget {
  final String address;
  final String lat;
  final String long;
  final String city;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const SavedAddressesCard({
    required this.onEdit,
    required this.address,
    required this.long,
    required this.lat,
    required this.city,
    required this.onDelete,
    super.key,
  });

  @override
  State<SavedAddressesCard> createState() => _SavedAddressesCardState();
}
class _SavedAddressesCardState extends State<SavedAddressesCard> {
  String? formattedAddress;

  @override
  void initState() {
    super.initState();
  }

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
            Image.asset(
              AppImages.location,
              color: AppColors.kBlack,
              width: 24.w,
              height: 24.h,
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.city.split(",")[1],
                    style: AppFonts.font16BlackWeight500,
                  ),
                  4.verticalSpace,
                  Text(
                    widget.city,
                    style: AppFonts.font14GreyWeight400,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: widget.onDelete,
                  icon: SvgPicture.asset(
                    AppImages.trashIcon,
                    width: 20.sp,
                    height: 20.sp,
                  ),
                ),
                IconButton(
                  onPressed: widget.onEdit,
                  icon: Image.asset(
                    AppImages.editIcon,
                    color: AppColors.kBlack,
                    width: 20.sp,
                    height: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
