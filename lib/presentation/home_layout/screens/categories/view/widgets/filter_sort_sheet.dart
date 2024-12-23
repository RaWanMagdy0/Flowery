import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../generated/l10n.dart';

enum SortOption {
  priceAscending,
  priceDescending,
  dateAscending,
  dateDescending,
  discountAmount
}

class FilterSortSheet extends StatelessWidget {
  final Function(SortOption) onSortSelected;
  final SortOption? currentSort;
  const FilterSortSheet({
    Key? key,
    required this.onSortSelected,
    this.currentSort,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort By',
                style: AppFonts.font18BlackWeight500,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Divider(),
          _buildSortOption(
            context: context,
            title: 'Lowest Price',
            option: SortOption.priceAscending,
          ),
          _buildSortOption(
            context: context,
            title: 'Highest Price',
            option: SortOption.priceDescending,
          ),
          _buildSortOption(
            context: context,
            title: 'New',
            option: SortOption.dateAscending,
          ),
          _buildSortOption(
            context: context,
            title: 'Old',
            option: SortOption.dateDescending,
          ),
          _buildSortOption(
            context: context,
            title: 'Discount',
            option: SortOption.discountAmount,
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required String title,
    required SortOption option,
  }) {
    return InkWell(
      onTap: () {
        onSortSelected(option);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppFonts.font16BlackWeight400,
            ),
            if (currentSort == option)
              Icon(
                Icons.check,
                color: AppColors.kPink,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
