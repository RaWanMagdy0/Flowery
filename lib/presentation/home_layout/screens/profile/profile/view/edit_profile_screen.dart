import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';
import '../widget/edit_profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'ProfileScreen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit viewModel;
  String? gender;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("Edit Profile"),
        leading: const Icon(Icons.arrow_back_ios),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
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
            gender = state.user?.gender;
            return EditProfileWidget(
              user: state.user!,
            );
          } else if (state is EditProfileLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.pinkLoadingAnimation),
            );
          } else if (state is EditProfileErrorState) {
            return Center(
              child: Text(state.errorMessage ??
                  'An error occurred while updating the profile'),
            );
          } else if (state is EditProfileSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showSuccessDialog(
                  context: context,
                  message: "Profile updated successfully",
                  whenAnimationFinished: () {
                    Navigator.pop(context);
                  });
            });
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
