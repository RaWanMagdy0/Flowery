import 'package:flutter/material.dart';

import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/const/app_string.dart';

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
