import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlowerCard extends StatelessWidget {
  final String? title;
  final String? price;
  final String? originalPrice;
  final String? discount;
  final String? imageUrl;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? priceColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? titleSize;
  final double? priceSize;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final IconData? buttonIcon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? iconColor;
  final String? descount;
  final Color? descountColor;

  const FlowerCard({
    super.key,
    this.title,
    this.price,
    this.originalPrice,
    this.discount,
    this.imageUrl,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black54,
    this.priceColor = Colors.black87,
    this.onTap,
    this.width = 150,
    this.height = 200,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.titleSize = 16.0,
    this.priceSize = 14.0,
    this.buttonColor = Colors.pink,
    this.buttonTextColor = Colors.white,
    this.buttonIcon = Icons.shopping_cart,
    this.iconColor = Colors.white,
    this.buttonText = "Add to Cart",
    this.descount,
    this.descountColor,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Container(
          width: width?.w,
          height: height?.h,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1.r,
                blurRadius: 4.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: imageUrl != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                                : Icon(Icons.local_florist, size: 40.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      title ?? 'Flower',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        Text(
                          price ?? 'EGP 0',
                          style: AppFonts.font14BlackWeight500
                        ),
                          Text(
                            originalPrice!,
                            style: TextStyle(
                              color: AppColors.kBlack,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              '$descount%',
                              style: TextStyle(
                                color: descountColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,

                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onButtonPressed ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: buttonTextColor,
                        iconColor: iconColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      icon: Icon(buttonIcon, size: 18.sp),
                      label: Text(
                        buttonText ?? "",
                        style: TextStyle(
                          color: buttonTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}