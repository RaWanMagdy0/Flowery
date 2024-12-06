import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/widget/custom_button.dart';

class DeliveryAddress extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  const DeliveryAddress({super.key, required this.onChanged});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          20.verticalSpace,
          Row(
            children: [
              Text(
                "Delivery Address",
                style: AppFonts.font18BlackWeight500,
              ),
            ],
          ),
          10.verticalSpace,
          InkWell(
            onTap: () {
              setState(() {
                selectedAddress = "Home";
              });
              widget.onChanged(selectedAddress);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.kLighterGrey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              activeColor: Colors.pink,
                              value: "Home",
                              groupValue: selectedAddress,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddress = value;
                                });
                                widget.onChanged(value);
                              },
                            ),
                            Text(
                              "Home",
                              style: AppFonts.font16BlackWeight500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "2xvp+xc-sheikh zayed",
                              style: AppFonts.font13BlackWeight400
                                  .copyWith(color: AppColors.kGray),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: AppColors.kGray,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          10.verticalSpace,
          InkWell(
            onTap: () {
              setState(() {
                selectedAddress = "Office";
              });
              widget.onChanged(selectedAddress);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.kLighterGrey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              activeColor: Colors.pink,
                              value: "Office",
                              groupValue: selectedAddress,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddress = value;
                                });
                                widget.onChanged(value);
                              },
                            ),
                            Text(
                              "Office",
                              style: AppFonts.font16BlackWeight500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "2xvp+xc-sheikh zayed",
                              style: AppFonts.font13BlackWeight400
                                  .copyWith(color: AppColors.kGray),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: AppColors.kGray,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          10.verticalSpace,
          CustomButton(
            color: AppColors.kWhite,
            borderColor: AppColors.kLightGrey,
            onPressed: () {
              Navigator.pushNamed(context, PageRouteName.addAndEditUserAddress);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.kPink,
                  size: 25.sp,
                ),
                Text(
                  "Add New",
                  style: AppFonts.font14PinkWeight500,
                )
              ],
            ),
          ),
          15.verticalSpace,
        ],
      ),
    );
  }
}
