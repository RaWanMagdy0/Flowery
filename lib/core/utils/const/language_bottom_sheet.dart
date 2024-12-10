import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart';
import '../../styles/colors/app_colors.dart';
import '../functions/providers/local_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocalProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage("en");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).english),
                if (provider.locale == "en")
                  Icon(
                    Icons.check,
                    color: AppColors.kPink,
                    size: 30,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Arabic language selection
          InkWell(
            onTap: () {
              provider.changeLanguage("ar");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    S.of(context).arabic,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.kPink
                        ),
                  ),
                ),
                if (provider.locale == "ar")
                  Icon(
                    Icons.check,
                    color: AppColors.kPink,
                    size: 30,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
