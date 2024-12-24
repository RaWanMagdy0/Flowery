import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../generated/l10n.dart';

class CartLoginWidget extends StatelessWidget {
  const CartLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return SizedBox(
      width: 1.sw,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset(
            //   AppImages.loginCart,
            // ),
            // 16.verticalSpace,
            Text(
              local.pleaseLoginToSeeCartItems,
              style: AppFonts.font16PinkWeight400,
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRouteName.logIn);
              },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
