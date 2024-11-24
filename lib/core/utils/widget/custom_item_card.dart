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
      child: Container(
        width: width?.w,
        height: height?.h,
        padding: EdgeInsets.only(bottom: 8.h,right: 8.w,left: 8.w,top: 1.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.kLighterGrey,width: 1.w),
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
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
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
                  8.verticalSpace,
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
                  4.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        Text(
                          price ?? 'EGP 0',
                          style: TextStyle(
                            color: priceColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        8.horizontalSpace,
                        if (originalPrice != null) ...[
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(
                              originalPrice!,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '$descount%',
                              style: TextStyle(
                                color: descountColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,                            ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 35.h,
                    child: ElevatedButton.icon(
                      onPressed: onButtonPressed ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: buttonTextColor,
                        iconColor: iconColor,
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
              ),
            );
          },
        ),
      ),
    );
  }
}