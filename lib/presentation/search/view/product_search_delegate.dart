import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_item_card.dart';
import '../../../generated/l10n.dart';
import '../view_model/search_cubit.dart';
import '../view_model/search_state.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final SearchCubit searchCubit;

  ProductSearchDelegate({required this.searchCubit});

  @override
  String get searchFieldLabel => S.current.searchHint;

  @override
  TextStyle get searchFieldStyle => TextStyle(
    color: AppColors.kBlack,
    fontSize: 16.sp,
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear, color: AppColors.kPink),
          onPressed: () {
            query = '';
            searchCubit.clearSearch();
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: AppColors.kPink),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isNotEmpty) {
      searchCubit.searchProducts(query);
    }

    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        return switch (state) {
          SearchInitial() => const SizedBox(),
          SearchLoading() => Center(
            child: CircularProgressIndicator(color: AppColors.kPink),
          ),
          SearchError(message: final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                    size: 64.sp,
                    color: AppColors.kError),
                16.verticalSpace,
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.kGray,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SearchSuccess(products: final products) => products.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off,
                    size: 64.sp,
                    color: AppColors.kLightGrey),
                16.verticalSpace,
                Text(
                  S.of(context).noProductsFound,
                  style: TextStyle(
                    color: AppColors.kGray,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          )
              : GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return FlowerCard(
                title: product.title,
                imageUrl: product.imgCover,
                price: 'EGP ${product.priceAfterDiscount}',
                backgroundColor: Colors.white,
                buttonColor: AppColors.kPink,
                buttonTextColor: Colors.white,
                width: 150.w,
                height: 200.h,
                titleSize: 12.sp,
                priceSize: 15.sp,
                onTap: () => Navigator.pushNamed(
                  context,
                  PageRouteName.productDetails,
                  arguments: product.id,
                ),
                onButtonPressed: () {},
              );
            },
          ),
        };
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColors.kGray,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}