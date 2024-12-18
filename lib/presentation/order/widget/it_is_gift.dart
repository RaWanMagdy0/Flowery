import 'package:flowery/core/utils/const/checkout_page_string.dart';
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
                CheckoutStrings.itIsaGift,
                style: AppFonts.font18BlackWeight500,
              )
            ],
          ),
          5.verticalSpace,
          if (isGiftEnabled) ...[
            Column(
              children: [
                CustomTextFormField(
                  hintText: CheckoutStrings.enterTheName,
                  validator: (value) => Validators.validateNotEmpty(),
                  keyBordType: TextInputType.text,
                  labelText: CheckoutStrings.name,
                ),
                20.verticalSpace,
                CustomTextFormField(
                  hintText: CheckoutStrings.enterThePhoneNumber,
                  validator: (value) => Validators.validatePhoneNumber(value),
                  keyBordType: TextInputType.phone,
                  labelText: CheckoutStrings.phoneNumber,
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
