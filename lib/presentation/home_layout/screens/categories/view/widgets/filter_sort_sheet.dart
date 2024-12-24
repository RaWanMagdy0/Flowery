// filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/categories_view_model.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

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
          Text(
            'Sort By',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildSortOption(
            context,
            'Price: Low to High',
            'priceAfterDiscount',
          ),
          _buildSortOption(
            context,
            'Quantity: Low to High',
            'quantity',
          ),
          _buildSortOption(
            context,
            'Quantity: High to Low',
            '-quantity',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSortOption(
      BuildContext context,
      String title,
      String sortType,
      ) {
    return InkWell(
      onTap: () {
        // Get the CategoriesViewModel from the parent context
        final viewModel = context.read<CategoriesViewModel>();
        viewModel.sortProducts(sortType);
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}