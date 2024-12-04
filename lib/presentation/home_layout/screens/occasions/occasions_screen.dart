import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/custom_item_card.dart';
import '../../../../domain/entities/home_layout/product_details_entity.dart';
import 'view_model/ocusin_cubit.dart';
import 'view_model/ocusin_state.dart';

class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Occasion', style: AppFonts.font20BlackWeight500),
                  5.verticalSpace,
                  Text('Bloom with our exquisite best sellers',
                      style: AppFonts.font13BlackWeight500),
                ],
              ),
            ],
          ),
          backgroundColor: AppColors.kWhite,
          elevation: 0,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<OccasionCubit, OccasionState>(
            buildWhen: (previous, current) {
              return current is OccasionLoadingState ||
                  current is OccasionSuccessState ||
                  current is OccasionErrorState;
            },
            builder: (context, state) {
              if (state is OccasionLoadingState) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.kPink,
                ));
              } else if (state is OccasionErrorState) {
                return Center(child: Text(state.exception.toString()));
              } else if (state is OccasionSuccessState) {
                return SizedBox(
                  height: 20.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.occasions?.length ?? 0,
                    itemBuilder: (context, index) {
                      final occasion = state.occasions![index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                          context
                              .read<OccasionCubit>()
                              .selectCategory(state.occasions![index].id ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            occasion.name.toString(),
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
          32.verticalSpace,
          BlocBuilder<OccasionCubit, OccasionState>(
            buildWhen: (previous, current) {
              return current is GetOccasionPrudactLoadingState ||
                  current is GetOccasionPrudactSuccessState ||
                  current is GetOccasionPrudactErrorState;
            },
            builder: (context, state) {
              if (state is GetOccasionPrudactLoadingState) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.kPink,
                ));
              } else if (state is GetOccasionPrudactErrorState) {
                return Center(child: Text(state.exception.toString()));
              } else if (state is GetOccasionPrudactSuccessState) {
                final List<ProductEntity?>? prudact =
                    context.read<OccasionCubit>().prudact;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: prudact?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17,
                        mainAxisSpacing: 17,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return FlowerCard(
                          title: prudact?[index]?.title,
                          imageUrl: prudact?[index]?.imgCover,
                          price: 'EGP ${prudact?[index]?.priceAfterDiscount}',
                          originalPrice: prudact?[index]?.price.toString(),
                          descount: '${prudact?[index]?.priceAfterDiscount}',
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
                            arguments: prudact?[index]?.id,
                          ),
                          onButtonPressed: () {

                          },
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
