import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';
import '../../../core/utils/widget/shimmer_loading_widget.dart';
import '../view_model/notifications_states.dart';
import '../view_model/notifications_view_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<NotificationsViewModel>();
    viewModel.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Notifications",
          style: AppFonts.font20BlackWeight500.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<NotificationsViewModel, NotificationsState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => 8.verticalSpace,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ShimmerLoadingWidget(
                    height: 100.h,
                    width: 1.sw,
                  ),
                );
              },
            );
          } else if (state is NotificationsSuccess) {
            final notifications = state.notifications;
            if (notifications.isEmpty) {
              return const Center(child: Text("No saved addresses."));
            }
            return ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.kLightGrey,
                thickness: 1.h,
              ),
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: Text(
                    notification.title ?? '',
                    style: AppFonts.font16BlackWeight500,
                  ),
                  subtitle: Text(
                    notification.body ?? '',
                    style: AppFonts.font13GreyWeight500,
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
