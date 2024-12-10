import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../generated/l10n.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppImages.emptyCart,
          ),
          16.verticalSpace,
          Text(
            local.yourCartIsEmptyGoBackAndAddSomeItems,
            style: AppFonts.font16PinkWeight400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
