import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';

class SavedAddressesCard extends StatefulWidget {
  final String address;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SavedAddressesCard({
    required this.onEdit,
    required this.address,
    required this.onDelete,
    super.key,
  });

  @override
  State<SavedAddressesCard> createState() => _SavedAddressesCardState();
}

class _SavedAddressesCardState extends State<SavedAddressesCard> {
  String city = 'Unknown City';
  String locationDetails = 'Unknown Location';

  @override
  void initState() {
    super.initState();
    _loadAddress();
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
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.address.split(",").last.trim(),
                    style: AppFonts.font16BlackWeight500,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    locationDetails,
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

  Future<void> _loadAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('city') ?? 'Unknown City';
      String lat = prefs.getString('lat') ?? '';
      String lang = prefs.getString('lang') ?? '';
      if (lat.isNotEmpty && lang.isNotEmpty) {
        double latitude = double.parse(lat);
        double longitude = double.parse(lang);
        getAddressFromCoordinates(latitude, longitude).then((address) {
          setState(() {
            locationDetails = address;
          });
        });
      } else {
        locationDetails = 'Unknown Location';
      }
    });
  }
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return 'Unknown Location';
      Placemark placemark = placemarks[0];
      String address = '${placemark.name}, ${placemark.locality}';
      return address;
    } catch (e) {
      print("Error getting address from coordinates: $e");
      return 'Unknown Location';
    }
  }
}
