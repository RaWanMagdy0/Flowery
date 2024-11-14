import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.homeIcon)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.categoryIcon)),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.shoppingIcon)),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.personIcon)),
          label: 'Profile',
        ),
      ],
      selectedItemColor: AppColors.kPink,
      unselectedItemColor: AppColors.kGray,
      unselectedLabelStyle: TextStyle(color: AppColors.kGray),
      selectedFontSize: 16.0,
      unselectedFontSize: 12.0,
      iconSize: 30.0,
      backgroundColor: AppColors.kLightWhite,
    );
  }
}