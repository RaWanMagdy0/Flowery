import 'package:flutter/material.dart';

import '../../../../../../core/styles/fonts/app_fonts.dart';

class CartPriceInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const CartPriceInfoWidget({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ?? AppFonts.font18BlackWeight500,
        ),
        Text(
          'EGP $value',
          style: valueStyle ?? AppFonts.font18BlackWeight500,
        ),
      ],
    );
  }
}
