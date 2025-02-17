import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flowery/domain/entities/pending_orders/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../view_model/map_states.dart';
import '../view_model/map_view_model.dart';
import '../wedgit/map_wiget_track.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderDetailsCubit, PendingOrderState>(
        builder: (BuildContext context,  state) {
          if (state is OrderStateLoading) {
            return Center(
                child: CircularProgressIndicator(color: AppColors.kPink));
          }
          else if (state is PendingGetOrdersErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.errorMessage.toString(),
              );
            });
            return SizedBox.shrink();
          }
          else if(state is PendingGetOrdersSuccessState){
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MapWidgetTrack(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated arrival",
                        style: AppFonts.font14GreyWeight500,
                      ),
                      5.verticalSpace,
                      Text(
                        "03 Sep 2024, 11:00 AM",
                        style: AppFonts.font16BlackWeight500,
                      ),
                    ],
                  ),
                ),
                5.verticalSpace,
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: ClipOval(
                              child: Image.asset(
                                AppImages.flowerImage,
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mohamed"),
                              5.verticalSpace,
                              Text("Is your delivery hero for today")
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: AppColors.kPink,
                              ),
                              25.horizontalSpace,
                              Icon(
                                Icons.message,
                                color: AppColors.kPink,
                              ),
                            ],
                          )
                        ],
                      ),
                      20.verticalSpace,
                      CustomButton(
                        text: "Order Details",
                        onPressed: () {},
                        color: AppColors.kPink,
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return Center(child: Text("noOrdersAvailable"));

        },
      ),
    );
  }
}
