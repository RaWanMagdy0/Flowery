import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../domain/entities/home_layout/profile/user.dart';
import 'custom_profile_pic.dart';
import 'edit_profile_form.dart';

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
