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
        7.horizontalSpace,
      ],
    );
  }
}
