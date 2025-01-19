import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class DeliveryAddressCard extends StatefulWidget {
  final ValueChanged<String?> onChanged;
  final String city;
  final String street;
  String? selectedAddress;
  final String addressId;
  DeliveryAddressCard(
      {required this.city,
      required this.street,
      super.key,
      required this.onChanged,
      required this.addressId,
      required this.selectedAddress,
     });

  @override
  State<DeliveryAddressCard> createState() => _DeliveryAddressCardState();
}

class _DeliveryAddressCardState extends State<DeliveryAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: AppColors.kLighterGrey,
                  )),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                activeColor: Colors.pink,
                                value: widget.addressId,
                                groupValue: widget.selectedAddress,
                                onChanged: (value) {
                                  setState(() {
                                    widget.selectedAddress = value;
                                  });
                                  widget.onChanged(value);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  widget.city,
                                  style: AppFonts.font16BlackWeight500,
                                  overflow: TextOverflow.ellipsis,
                      
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                   widget.street,
                                    style: AppFonts.font13BlackWeight400
                                        .copyWith(color: AppColors.kGray),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageRouteName.addAndEditUserAddress);
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            color: AppColors.kGray,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
