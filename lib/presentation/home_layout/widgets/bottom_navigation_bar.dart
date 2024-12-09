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
    return BottomNavigationBar(
      backgroundColor: AppColors.kWhite,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const ImageIcon(AssetImage(AppImages.homeUnselectedIcon)),
          activeIcon: ImageIcon(AssetImage(AppImages.homeSelectedIcon)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.categoryUnselectedIcon)),
          activeIcon: ImageIcon(AssetImage(AppImages.categorySelectedIcon)),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.cartUnselectedIcon)),
          activeIcon: ImageIcon(AssetImage(AppImages.cartSelectedIcon)),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.profileUnselectedIcon)),
          activeIcon: ImageIcon(AssetImage(AppImages.profileSelectedIcon)),
          label: 'Profile',
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
