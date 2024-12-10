import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_list_tile.dart';
import '../../../../../../core/utils/widget/custom_switch_tile.dart';
import '../../../../../../generated/l10n.dart';
import '../../../cart/view_model/cart_view_model.dart';
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
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
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
      body: context.read<CartViewModel>().isUserLoggedIn
          ? BlocListener<ProfileCubit, ProfileState>(
              bloc: viewModel,
              listener: (context, state) {
                if (state is EditProfileSuccessState) {
                  viewModel.getLoggedUserInfo();
                }
                if (state is LogoutSuccessState) {
                  Navigator.pushReplacementNamed(
                      context, PageRouteName.homeLayout);
                }
                if (state is LogoutErrorState) {
                  AppDialogs.showErrorDialog(
                      context: context,
                      errorMassage: state.message ?? "An Error Occurred");
                }
              },
              child: BlocBuilder<ProfileCubit, ProfileState>(
                bloc: viewModel,
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
                    bool isUserProfile;
                    if (state.user?.photo ==
                        "https://flower.elevateegy.com/uploads/default-profile.png") {
                      isUserProfile = false;
                    } else {
                      isUserProfile = true;
                    }
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: ClipOval(
                                child: isUserProfile
                                    ? Image.network(
                                        state.user?.photo ?? "",
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: AppColors.kLighterGrey,
                                        child: Icon(
                                          Icons.person,
                                          size: 90.sp,
                                          color: AppColors.kGray,
                                        ),
                                      ),
                              ),
                            ),

                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.user?.firstName ?? '',
                                  style: AppFonts.font18BlackWeight500,
                                ),
                                5.horizontalSpace,
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRouteName.editProfile);
                                  },
                                  child: Image.asset(AppImages.editIcon),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              state.user?.email ?? "",
                              style: AppFonts.font18BlackWeight500,
                            ),
                            const SizedBox(height: 32),

                            // Custom List Tiles
                            CustomListTile(
                              leadingIcon: Icons.list_alt,
                              title: local.myOrder,
                              trailingIcon: Icons.arrow_forward_ios,
                              onTap: () {},
                            ),
                            CustomListTile(
                              leadingIcon: Icons.location_pin,
                              title: local.savedAddress,
                              trailingIcon: Icons.arrow_forward_ios,
                              onTap: () {},
                            ),

                            // Options List
                            SizedBox(height: 14.h),
                            Divider(thickness: 1.w),

                            // Notification Tile
                            SwitchTile(
                              value: isNotificationEnabled,
                              onChanged: (bool newValue) {
                                setState(() {
                                  isNotificationEnabled = newValue;
                                });
                              },
                            ),
                            SizedBox(height: 14.h),
                            Divider(thickness: 1.w),
                            CustomListTile(
                              leadingIcon: Icons.translate,
                              title: local.language,
                              subtitle: local.english,
                              subtitleStyle:
                                  const TextStyle(color: Colors.pink),
                              onTap: () {},
                            ),
                            CustomListTile(
                              title: local.aboutAs,
                              trailingIcon: Icons.arrow_forward_ios,
                              onTap: () {},
                            ),
                            CustomListTile(
                              title: local.termsAndConditions,
                              trailingIcon: Icons.arrow_forward_ios,
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            const Divider(thickness: 1),

                            CustomListTile(
                              leadingIcon: Icons.logout,
                              title: local.logOut,
                              trailingIcon: Icons.logout,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.kWhite,
                                      content: Container(
                                        width: 260.w,
                                        height: 155.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 15.h),
                                            Text(
                                              local.logOut,
                                              style: AppFonts
                                                  .font18BlackWeight500
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              local.logoutConfirmationTitle,
                                              style: AppFonts
                                                  .font16BlackWeight500
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            SizedBox(height: 24.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize:
                                                        Size(105.w, 40.h),
                                                    backgroundColor:
                                                        AppColors.kWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.r),
                                                      side: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.w),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    local.cancelText,
                                                    style: AppFonts
                                                        .font14GreyWeight400,
                                                  ),
                                                ),
                                                SizedBox(width: 15.w),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    minimumSize:
                                                        Size(105.w, 40.h),
                                                    backgroundColor:
                                                        AppColors.kPink,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.r),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.w),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                    viewModel.logout();
                                                  },
                                                  child: Text(
                                                    local.logOut,
                                                    style: AppFonts
                                                        .font15WhiteWeight500
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                            const Text(
                              'v 6.3.0 - (446)',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
            )
          : _buildLoggedInWidget(),
    );
  }

  Widget _buildLoggedInWidget() {
    final local = S.of(context);
    return SizedBox(
      width: 1.sw,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              local.pleaseLoginToSeeProfileDetails,
              style: AppFonts.font16PinkWeight400,
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRouteName.logIn);
              },
              text: local.loginTitle,
            ),
          ],
        ),
      ),
    );
  }
}
