import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../../view_model/categories_view_model.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ProductFilterOption selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = context.read<CategoriesViewModel>().productFilterOption ??
        ProductFilterOption.priceLowToHigh;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bottom sheet indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          Text(
            'Sort by',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.kPink),
          ),
          SizedBox(height: 20),
          // Radio options
          _buildRadioOption(
            'Price: Low to High',
            ProductFilterOption.priceLowToHigh,
          ),
          _buildRadioOption(
            'Quantity: Low to High',
            ProductFilterOption.quantityLowToHigh,
          ),
          _buildRadioOption(
            'Quantity: High to Low',
            ProductFilterOption.quantityHighToLow,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<CategoriesViewModel>().sortProducts(selectedSort);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_list,
                    color: AppColors.kWhite,
                    size: 25.sp,
                  ),
                  5.horizontalSpace,
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, ProductFilterOption value) {
    return InkWell(
      onTap: () {
        setState(() {
          context.read<CategoriesViewModel>().productFilterOption = value;
          selectedSort = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Radio<ProductFilterOption>(
              value: value,
              groupValue: selectedSort,
              onChanged: (newValue) {
                setState(() {
                  context.read<CategoriesViewModel>().productFilterOption =
                      newValue;
                  selectedSort = newValue!;
                });
              },
              activeColor: AppColors.kPink,
            ),
          ],
        ),
      ),
    );
  }
}
