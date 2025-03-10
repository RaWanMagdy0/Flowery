import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({super.key, required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPink,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Image.asset(
                  imagePath,
                )),
          ),
          Expanded(
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.kWhite)),
          ),
        ],
      ),
    );
  }
}
