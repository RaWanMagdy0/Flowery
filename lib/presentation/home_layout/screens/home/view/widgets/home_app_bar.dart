import 'package:flowery/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/widget/delivery_address_widget.dart';
import '../../../../widgets/search_bar_widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String city;
  final String lat;
  final String lang;

  const HomeAppBar({
    super.key,
    required this.city,
    required this.lat,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logoWithTitle,
                height: 35.h,
                width: 95.w,
              ),
              15.horizontalSpace,
              SearchBarWidget(),
            ],
          ),
          16.verticalSpace,
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageRouteName.addAndEditUserAddress);
            },
            child: DeliveryAddressWidget(
              city: city,
              lat: lat,
              lang: lang,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 65.h);
}
