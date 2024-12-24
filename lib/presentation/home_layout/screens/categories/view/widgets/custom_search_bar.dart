import 'package:flowery/presentation/home_layout/screens/categories/view/widgets/filter_sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../widgets/search_bar_widget.dart';
import '../../view_model/categories_view_model.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            maxHeight: 100.h,
          ),
        ),
        8.horizontalSpace,
        Container(
          width: 50.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.kLightGrey,
              width: 1.r,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.sort,
              color: AppColors.kLightGrey,
              size: 25,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => FilterSortSheet(
                  currentSort: null,
                  onSortSelected: (sortOption) {
                    context.read<CategoriesViewModel>().sortProducts(sortOption.name);
                  },
                ),
              );
            },
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
