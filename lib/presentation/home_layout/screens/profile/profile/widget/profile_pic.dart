import 'dart:io';

import 'package:flowery/core/di/di.dart';
import 'package:flowery/core/styles/images/app_images.dart';
import 'package:flowery/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:flowery/presentation/home_layout/screens/profile/profile/view_model/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/styles/colors/app_colors.dart';
import '../view_model/profile_cubit.dart';

class CustomProfilePic extends StatefulWidget {
  const CustomProfilePic({super.key});

  @override
  State<CustomProfilePic> createState() => _CustomProfilePicState();
}

class _CustomProfilePicState extends State<CustomProfilePic> {
  File? photo;
  final ImagePicker _picker = ImagePicker();
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = getIt.get<ProfileCubit>();
    return BlocProvider<ProfileCubit>(
      create: (context) => viewModel,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          switch (state) {
            case UploadPhotoLoadingState():
              AppDialogs.showLoading(context: context);
              break;
            case UploadPhotoSuccessState():
              AppDialogs.showSuccessDialog(
                  context: context, message: state.message.toString());
              setState(() {
                viewModel.getLoggedUserInfo();
              });
            case UploadPhotoErrorState():
              AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: state.errorMessage.toString());
              break;
            default:
          }
        },
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              ClipOval(
                  child: Image.asset(
                AppImages.photo,
                fit: BoxFit.cover,
              )),
              Positioned(
                bottom: 10.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                    _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColors.kBabyPink,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 15.sp,
                      color: AppColors.kGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        photo = File(pickedFile.path);
        viewModel.uploadPhoto(photo!);
      });
    }
  }
}
