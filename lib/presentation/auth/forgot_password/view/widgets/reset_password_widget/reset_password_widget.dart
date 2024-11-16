import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(
        child: Text(
          AppStrings.resetPasswordScreenTitle,
          style: AppFonts.font18BlackWeight500,
        ),
      ),
    ]));
  }
}
