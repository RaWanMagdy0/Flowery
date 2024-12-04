import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery/presentation/home_layout/screens/profile/profile/widget/custom_gender_row.dart';
import 'package:flowery/presentation/home_layout/screens/profile/profile/widget/edit_profile_form.dart';
import 'package:flowery/presentation/home_layout/screens/profile/profile/widget/profile_pic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../../../domain/entities/home_layout/profile/User.dart';
import '../view_model/profile_cubit.dart';

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
