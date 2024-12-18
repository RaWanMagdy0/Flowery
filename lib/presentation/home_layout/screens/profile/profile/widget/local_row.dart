import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../core/utils/functions/providers/local_provider.dart';

class LocalizationRow extends StatelessWidget {
  const LocalizationRow({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocalProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            provider.changeLanguage(provider.locale == "en" ? "ar" : "en");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(

                       height: 25.h,width: 25.w,
                        child: Image.asset(
                          AppImages.languageIcon,
                        )

                    ),
                    10.horizontalSpace,
                    Text(
                      provider.locale == "en" ? "English" : "العربيه",
                      style: AppFonts.font16BlackWeight400,
                    ),
                  ],
                ),
                Text(
                  provider.locale == "en" ? "Arabic" : "English",
                  style: AppFonts.font16PinkWeight400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
