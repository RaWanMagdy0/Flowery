import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_item_card.dart';
import '../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../generated/l10n.dart';
import '../view_model/search_cubit.dart';
import '../view_model/search_state.dart';

class SearchScreen extends StatefulWidget {
  final String initialQuery;

  const SearchScreen({
    super.key,
    required this.initialQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    // Perform initial search with the query from previous screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialQuery.isNotEmpty) {
        context.read<SearchCubit>().searchProducts(widget.initialQuery);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: local.searchArabic,
            hintStyle: TextStyle(color: AppColors.kGray),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<SearchCubit>().clearSearch();
              },
            ),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              context.read<SearchCubit>().searchProducts(value);
            }
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchInitial() => Center(
              child: Text(local.searchForProducts),
            ),
            SearchLoading() => GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => ShimmerLoadingWidget(
                width: 150.w,
                height: 200.h,
              ),
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
                    local.noProductsFound,
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
                  originalPrice: product.price?.toString(),
                  backgroundColor: Colors.white,
                  buttonColor: AppColors.kPink,
                  buttonTextColor: Colors.white,
                  descount: '${state.products[index].priceAfterDiscount}',
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
      ),
    );
  }
}