import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../domain/entities/home_layout/profile/user.dart';
import '../view_model/profile_cubit.dart';
import 'custom_gender_row.dart';
import 'edit_profile_form.dart';
import 'profile_pic.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    super.key,
    required this.user,
    required this.gender,
    required this.onGenderChanged,
  });
  final User user;
  final String? gender;
  final ValueChanged<String> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomProfilePic(user: user),
          20.verticalSpace,
          EditProfileForm(
            user: user,
            gender: gender,
            onGenderChanged: onGenderChanged,
          ),
        ],
      ),
    );
  }
}
