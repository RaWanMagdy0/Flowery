import 'package:flowery/presentation/home_layout/screens/categories/view/widgets/filter_sort_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routes/page_route_name.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/widget/custom_item_card.dart';
import '../../../widgets/search_bar_widget.dart';
import '../view_model/categories_state.dart';
import '../view_model/categories_view_model.dart';
import 'widgets/custom_search_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          title: SearchBarWidget(
            maxHeight: 100.h,
          ),
          actions: [
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
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext bottomSheetContext) {
                      // Pass the parent context's provider to the bottom sheet
                      return BlocProvider.value(
                        value: context.read<CategoriesViewModel>(),
                        child: FilterBottomSheet(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
          forceMaterialTransparency: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CategoriesViewModel, CategoriesState>(
            buildWhen: (previous, current) {
              return current is CategoriesLoadingState ||
                  current is CategoriesSuccessState ||
                  current is CategoriesErrorState;
            },
            builder: (context, state) {
              if (state is CategoriesLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPink,
                  ),
                );
              } else if (state is CategoriesErrorState) {
                return Center(child: Text(state.exception.toString()));
              } else if (state is CategoriesSuccessState) {
                return SizedBox(
                  height: 25.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories?.length ?? 0,
                    itemBuilder: (context, index) {
                      final category = state.categories![index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                          context
                              .read<CategoriesViewModel>()
                              .selectCategory(state.categories![index].id ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            category.name.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectedCategoryIndex == index
                                  ? AppColors.kPink
                                  : AppColors.kGray,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          20.verticalSpace,
          BlocBuilder<CategoriesViewModel, CategoriesState>(
            buildWhen: (previous, current) {
              return current is GetCategoriesProductLoadingState ||
                  current is GetCategoriesProductSuccessState ||
                  current is GetCategoriesProductErrorState ||
                  current is ProductSortLoadingState ||
                  current is ProductSortSuccessState ||
                  current is ProductSortErrorState;
            },
            builder: (context, state) {
              if (state is GetCategoriesProductLoadingState ||
                  state is ProductSortLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPink,
                  ),
                );
              } else if (state is GetCategoriesProductErrorState ||
                  state is ProductSortErrorState) {
                final error = state is GetCategoriesProductErrorState
                    ? state.exception
                    : (state as ProductSortErrorState).exception;
                return Center(child: Text(error.toString()));
              } else if (state is GetCategoriesProductSuccessState ||
                  state is ProductSortSuccessState) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: state.product?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17,
                        mainAxisSpacing: 17,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.product?[index];
                        return FlowerCard(
                          title: product?.title,
                          imageUrl: product?.imgCover,
                          price: 'EGP ${product?.priceAfterDiscount}',
                          originalPrice: product?.price.toString(),
                          descount: '${product?.priceAfterDiscount}',
                          descountColor: Colors.green,
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
                            arguments: product?.id,
                          ),
                          onButtonPressed: () {},
                        );
                      },
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}