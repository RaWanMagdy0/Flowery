import 'package:flowery/presentation/home_layout/screens/categories/view/widgets/custom_search_bar.dart';
import 'package:flowery/presentation/home_layout/screens/categories/view_model/categories_state.dart';
import 'package:flowery/presentation/home_layout/screens/categories/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routes/page_route_name.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/widget/custom_item_card.dart';

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
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            16.verticalSpace,
            CustomSearchBar(),
            SizedBox(height: 16.h),
            BlocBuilder<CategoriesViewModel, CategoriesState>(
              bloc: context.read<CategoriesViewModel>(),
              buildWhen: (previous, current) {
                return current is CategoriesLoadingState ||
                    current is CategoriesSuccessState ||
                    current is CategoriesErrorState;
              },
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoriesErrorState) {
                  return Center(child: Text(state.exception.toString()));
                } else if (state is CategoriesSuccessState) {
                  return SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories?.length ?? 0,
                      itemBuilder: (context, index) {
                        final categories = state.categories![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                              context
                                  .read<CategoriesViewModel>()
                                  .selectCategory(
                                      state.categories![index].id ?? '');
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                categories.name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedCategoryIndex == index
                                      ? AppColors.kPink
                                      : AppColors.kGray,
                                ),
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
            32.verticalSpace,
            BlocBuilder<CategoriesViewModel, CategoriesState>(
              buildWhen: (previous, current) {
                return current is GetCategoriesProductLoadingState ||
                    current is GetCategoriesProductSuccessState ||
                    current is GetCategoriesProductErrorState;
              },
              builder: (context, state) {
                if (state is GetCategoriesProductLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetCategoriesProductErrorState) {
                  return Center(child: Text(state.exception.toString()));
                } else if (state is GetCategoriesProductSuccessState) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        itemCount: state.product?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 17,
                          mainAxisSpacing: 17,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return FlowerCard(
                            title: state.product?[index]?.title,
                            imageUrl: state.product?[index]?.imgCover,
                            price:
                                'EGP ${state.product?[index]?.priceAfterDiscount}',
                            originalPrice:
                                state.product?[index]?.price.toString(),
                            descount:
                                '${state.product?[index]?.priceAfterDiscount}',
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
                              arguments: state.product?[index]?.id,
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
      ),
    );
  }
}