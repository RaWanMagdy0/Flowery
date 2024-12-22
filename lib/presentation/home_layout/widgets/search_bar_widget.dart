import 'package:flowery/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../search/view/product_search_delegate.dart';
import '../../search/view_model/search_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  final double? maxHeight;

  const SearchBarWidget({super.key, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Flexible(
      child: GestureDetector(
        onTap: () {
          showSearch(
            context: context,
            delegate: ProductSearchDelegate(
              searchCubit: context.read<SearchCubit>(),
            ),
          );
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? 36.h,
            maxWidth: 300.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kLightGrey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 6.h,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColors.kGray,
                size: 20.sp,
              ),
              8.horizontalSpace,
              Text(
                local.searchHint,
                style: AppFonts.font14LightGreyWeight500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
