import 'package:flowery/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/images/app_images.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BottomNavigationBar(
      backgroundColor: AppColors.kWhite,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.homeIcon)),
          label: local.homebottom,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.categoryIcon)),
          label: local.categories,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.shoppingIcon)),
          label: local.cart,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.personIcon)),
          label: local.profileText,
        ),
      ],
      selectedItemColor: AppColors.kPink,
      unselectedItemColor: AppColors.kGray,
      unselectedLabelStyle: TextStyle(color: AppColors.kGray),
      selectedFontSize: 15.0.sp,
      iconSize: 22.0.sp,
    );
  }
}
