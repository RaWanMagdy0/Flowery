import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/functions/validators/validators.dart';
import '../../../core/utils/widget/custom_text_form_field.dart';

class ItIsGift extends StatefulWidget {
  const ItIsGift({super.key});

  @override
  State<ItIsGift> createState() => _ItIsGiftState();
}

class _ItIsGiftState extends State<ItIsGift> {
  bool isGiftEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 0.8.w,
                child: Switch(
                  activeTrackColor: AppColors.kPink,
                  value: isGiftEnabled,
                  onChanged: (bool newValue) {
                    setState(() {
                      isGiftEnabled = newValue;
                    });
                  },
                ),
              ),
              Text(
                "It Is a gift",
                style: AppFonts.font18BlackWeight500,
              )
            ],
          ),
          5.verticalSpace,
          if (isGiftEnabled) ...[
            Column(
              children: [
                CustomTextFormField(
                  hintText: 'Enter the name',
                  validator: (value) => Validators.validateNotEmpty(),
                  keyBordType: TextInputType.text,
                  labelText: 'Name',
                ),
                20.verticalSpace,
                CustomTextFormField(
                  hintText: 'Enter the Phone number',
                  validator: (value) => Validators.validatePhoneNumber(value),
                  keyBordType: TextInputType.phone,
                  labelText: 'Phone number',
                ),
              ],
            ),
          ],
          10.verticalSpace,
        ],
      ),
    );
  }
}
