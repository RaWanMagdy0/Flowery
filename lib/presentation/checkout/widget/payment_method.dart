import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class PaymentMethod extends StatefulWidget {
  final ValueChanged<String?> onChanged;

  const PaymentMethod({super.key,required this.onChanged});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String? selectedPayment;

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
                "Payment Method ",
                style: AppFonts.font18BlackWeight500,
              ),
            ],
          ),
          10.verticalSpace,
          InkWell(
            onTap: (){
              setState(() {
                selectedPayment = "Cash on Delivery";
              });
              widget.onChanged(selectedPayment);
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
                    Text(
                      "Cash on Delivery",
                      style: AppFonts.font16BlackWeight500,
                    ),
                    Radio<String>(
                      activeColor: Colors.pink,
                      value: "Cash on Delivery",
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                        widget.onChanged(value);
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
          10.verticalSpace,
          InkWell(
            onTap: (){
              setState(() {
                selectedPayment =  "Credit Card";
              });
              widget.onChanged(selectedPayment);
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
                    Text(
                      "Credit Card",
                      style: AppFonts.font16BlackWeight500,
                    ),
                    Radio<String>(
                      activeColor: Colors.pink,
                      value: "Credit Card",
                      groupValue: selectedPayment,
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                        widget.onChanged(value);
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
          15.verticalSpace,

        ],
      ),
    );
  }
}
