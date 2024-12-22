// lib/presentation/search/view/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_item_card.dart';
import '../../../generated/l10n.dart';
import '../view_model/search_cubit.dart';
import '../view_model/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchCubit>().searchProducts(query);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          automaticallyImplyLeading: true,
          title: Container(
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.kLightGrey),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: TextStyle(fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: local.searchHint,
                hintStyle: TextStyle(color: AppColors.kGray, fontSize: 14.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: AppColors.kGray),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchCubit>().clearSearch();
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.search, color: AppColors.kPink),
                      onPressed: _performSearch,
                    ),
                  ],
                ),
              ),
              onSubmitted: (_) => _performSearch(),
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchInitial() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64.sp, color: AppColors.kLightGrey),
                  16.verticalSpace,
                  Text(
                    local.startSearching,
                    style: TextStyle(
                      color: AppColors.kGray,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
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
                    local.searchError,
                    style: TextStyle(
                      color: AppColors.kError,
                      fontSize: 16.sp,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColors.kGray,
                      fontSize: 14.sp,
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
                  originalPrice: product.price.toString(),
                  descountColor: Colors.green,
                  backgroundColor: Colors.white,
                  buttonColor: AppColors.kPink,
                  buttonTextColor: Colors.white,
                  descount: '10',
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