import 'package:flowery/core/styles/fonts/app_fonts.dart';
import 'package:flowery/core/utils/widget/custom_list_tile.dart';
import 'package:flowery/core/utils/widget/custom_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/styles/images/app_images.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';

class ProfileMainScreen extends StatefulWidget {
  static const String routeName = 'Profile Main Screen';

  const ProfileMainScreen({super.key});

  @override
  State<ProfileMainScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileMainScreen> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    var viewModel = getIt.get<ProfileCubit>();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Image.asset(
          AppImages.logoWithTitle,
          height: 35.h,
          width: 95.w,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: viewModel..getLoggedUserInfo(),
        builder: (context, state) {
          if (state is GetLoggedUserInfoLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.pinkLoadingAnimation),
            );
          } else if (state is GetLoggedUserInfoErrorState) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          } else if (state is GetLoggedUserInfoSuccessState) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.network(
                        state.user?.photo ?? '',
                        width: 90.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.user?.firstName ?? '',
                      style: AppFonts.font18BlackWeight500,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      state.user?.email ?? '',
                      style: AppFonts.font18BlackWeight500,
                    ),
                    const SizedBox(height: 32),

                    // Custom List Tiles
                    CustomListTile(
                      leadingIcon: Icons.list_alt,
                      title: 'My orders',
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),
                    CustomListTile(
                      leadingIcon: Icons.location_pin,
                      title: 'Saved address',
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),

                    // Options List
                    const SizedBox(height: 16),
                    const Divider(thickness: 1),

                    // Notification Tile
                    SwitchTile(
                      value: isNotificationEnabled,
                      onChanged: (bool newValue) {
                        setState(() {
                          isNotificationEnabled = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1),

                    CustomListTile(
                      leadingIcon: Icons.translate,
                      title: 'Language',
                      subtitle: 'English',
                      subtitleStyle: const TextStyle(color: Colors.pink),
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: 'About us',
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),
                    CustomListTile(
                      title: 'Terms & conditions',
                      trailingIcon: Icons.arrow_forward_ios,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 1),

                    CustomListTile(
                      leadingIcon: Icons.logout,
                      title: 'Logout',
                      trailingIcon: Icons.logout,
                      onTap: () {},
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'v 6.3.0 - (446)',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return Container(); // Fallback for other states
        },
      ),
    );
  }
}
