import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../domain/entities/home_layout/profile/User.dart';
import '../view_model/profile_cubit.dart';
import 'edit_profile_form.dart';
import 'profile_pic.dart';

class EditProfileWidget extends StatefulWidget {
  EditProfileWidget({super.key, required this.user});

  User user;

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late ProfileCubit viewModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomProfilePic(),
          20.verticalSpace,
          EditProfileForm(user: widget.user),
        ],
      ),
    );
  }
}
