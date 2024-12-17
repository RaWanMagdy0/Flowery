import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../domain/entities/order/create_order/order_response_entity.dart';
import '../../../generated/l10n.dart';
import '../view_model/order_cubit.dart';
import '../view_model/order_state.dart';
import '../widget/order_history_list.dart';

class GetOrdersHistory extends StatefulWidget {
  const GetOrdersHistory({super.key});

  @override
  State<GetOrdersHistory> createState() => _GetOrdersHistoryState();
}

class _GetOrdersHistoryState extends State<GetOrdersHistory> {
  late OrderCubit viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<OrderCubit>();
    viewModel.getOrdersHistory();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(local.myOrders, style: AppFonts.font20BlackWeight500),
          leading: Icon(Icons.arrow_back_ios_rounded),
          bottom: TabBar(
            unselectedLabelStyle: AppFonts.font16LightGreyWeight400,
            labelStyle: AppFonts.font16PinkWeight400,
            dividerColor: AppColors.kLighterGrey,
            indicatorWeight: 4.w,
            dividerHeight: 4.h,
            indicatorColor: AppColors.kPink,
            tabs: [
              Tab(child: Text(local.active)),
              Tab(child: Text(local.completed)),
            ],
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return Center(
                  child: CircularProgressIndicator(color: AppColors.kPink));
            } else if (state is GetOrdersErrorState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: state.errorMessage.toString(),
                );
              });
            } else if (state is GetOrdersSuccessState) {
              OrderEntity? order = state.orders;
              List<OrderItemEntity> activeOrders = [];
              List<OrderItemEntity> completedOrders = [];

              if (order != null) {
                activeOrders = order.orderItems
                        ?.where((item) =>
                            !(order.isPaid ?? false) ||
                            !(order.isDelivered ?? false))
                        .toList() ??
                    [];
                completedOrders = order.orderItems
                        ?.where((item) =>
                            (order.isPaid ?? false) &&
                            (order.isDelivered ?? false))
                        .toList() ??
                    [];
              }
              return TabBarView(
                children: [
                  OrderHistoryList(
                    orderItems: activeOrders,
                    order: order,
                  ),
                  completedOrders.isEmpty
                      ? Center(child: Text(local.noCompletedOrdersAvailable))
                      : OrderHistoryList(
                          order: order,
                          orderItems: completedOrders,
                        ),
                ],
              );
            }
            return Center(child: Text(local.noOrdersAvailable));
          },
        ),
      ),
    );
  }
}
