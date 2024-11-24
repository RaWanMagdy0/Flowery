import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/const/app_string.dart';
import 'package:flowery/core/utils/widget/custom_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'view_model/ocusin_cubit.dart';
import 'view_model/ocusin_state.dart';

class OccasionScreen extends StatefulWidget {
  @override
  _OccasionScreenState createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: AppColors.kBlack),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppStrings.occasionAppBar,
          style: AppFonts.font16BlackWeight500,
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.occasionTitle,
              style: AppFonts.font16BlackWeight500,
            ),
          ),
          BlocBuilder<OccasionCubit, OccasionState>(
            builder: (context, state) {
              if (state is OccasionLoadingState) {
                return Center(child: CircularProgressIndicator());
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
                              .selectCategory(state.occasions![index]);
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
            builder: (context, state) {
              if (state is GetOccasionPrudactLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetOccasionPrudactErrorState) {
                return Center(child: Text(state.exception.toString()));
              } else if (state is GetOccasionPrudactSuccessState) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: state.prudact.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 17,
                        mainAxisSpacing: 17,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return FlowerCard(
                          title: state.prudact[index]!.title,
                          imageUrl: state.prudact[index]!.imageUrl,
                          price: state.prudact[index]!.price.toString(),
                          discount: state.prudact[index]!.priceAfterDiscount
                              .toString(),
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



//  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 17,
//                           mainAxisSpacing: 17,
//                           childAspectRatio: 0.7,
//                         ),




// class OccasionScreen extends StatefulWidget {
//   @override
//   _OccasionScreenState createState() => _OccasionScreenState();
// }

// class _OccasionScreenState extends State<OccasionScreen> {
//   late final OccasionCubit occasionCubit;
//   int selectedCategoryIndex = 0;
//   final List<String> categories = [
//     'Wedding',
//     'Graduation',
//     'Birthday',
//     'Katb Ketab'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     occasionCubit = context.read<OccasionCubit>();
//     occasionCubit.loadFlowers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           OccasionCubit(context.read<OccasionsUseCase>()).loadFlowers(),
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_outlined, color: AppColors.kBlack),
//             onPressed: () { 
//               Navigator.of(context).pop();
//             },
//           ),
//           title: Text(
//             AppStrings.occasionAppBar,
//             style: AppFonts.font20BlackWeight500,
//           ),
//           centerTitle: false,
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 AppStrings.occasionTitle,
//                 style: AppFonts.font16BlackWeight500,
//               ),
//             ),
//             // Categories
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(categories.length, (index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedCategoryIndex = index;
//                       });
//                       occasionCubit.selectCategory(index);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         categories[index],
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: selectedCategoryIndex == index
//                               ? AppColors.kPink
//                               : AppColors.kGray,
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             SizedBox(height: 32.h),
//             // Product Grid
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: BlocBuilder<OccasionCubit, OccasionState>(
//                   builder: (context, state) {
//                     if (state is OccasionLoadingState) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is OccasionErrorState) {
//                       return Center(child: Text(state.exception.toString()));
//                     } else if (state is OccasionSuccessState) {
//                       return GridView.builder(
//                         itemCount: state.occasions?.length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 17,
//                           mainAxisSpacing: 17,
//                           childAspectRatio: 0.7,
//                         ),
//                         itemBuilder: (context, index) {
//                           final occasion = state.occasions![index];
//                           return FlowerCard(
//                             title: occasion.name,
//                             price: 'N/A',
//                             imageUrl: occasion.image,
//                           );
//                         },
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
