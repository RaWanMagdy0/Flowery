import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/di/di.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';
import 'package:image/image.dart' as img;

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
    _loadInitialPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => viewModel,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UploadPhotoLoadingState) {
            AppDialogs.showLoading(context: context);
          } else if (state is UploadPhotoSuccessState) {
            Navigator.pop(context);
            AppDialogs.showSuccessDialog(
              context: context,
              message: state.message ?? 'Photo uploaded successfully',
            );
              viewModel.getLoggedUserInfo();
          } else if (state is UploadPhotoErrorState) {
            Navigator.pop(context);
            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: state.errorMessage.toString(),
            );
          }
        },
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(
            children: [
              ClipOval(
                child: photo != null
                    ? Image.file(
                  photo!,
                  fit: BoxFit.cover,
                  height: 90.h,
                  width: 90.w,
                )
                    : (viewModel.photo != null
                    ? Image.network(
                  viewModel.photo!,
                  fit: BoxFit.cover,
                  height: 90.h,
                  width: 90.w,
                )
                    : Image.asset(AppImages.photo, fit: BoxFit.cover)),
              ),
              Positioned(
                bottom: 10.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: () {
                    uploadPhoto(ImageSource.gallery);
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
  Future<void> _loadInitialPhoto() async {
    final currentPhotoUrl = viewModel.photo;
    if (currentPhotoUrl != null) {
      setState(() {
        photo = File(currentPhotoUrl);
      });
    }
  }

  Future<void> uploadPhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final originalPhoto = File(pickedFile.path);
      try {
        final resizedPhoto = await _resizeImage(originalPhoto);
        setState(() {
          photo = resizedPhoto;
        });
        viewModel.uploadPhoto(resizedPhoto);
      } catch (e) {
        debugPrint('Error uploading photo: $e');
        AppDialogs.showErrorDialog(context: context, errorMassage: 'Error processing image');
      }
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<File> _resizeImage(File imageFile) async {
    final jpgImage = img.decodeImage(imageFile.readAsBytesSync());
    if (jpgImage == null) throw Exception('Failed to decode image');

    final resizedImage = img.copyResize(jpgImage, width: 800);
    final tempDir = await getTemporaryDirectory();
    final resizedPath = '${tempDir.path}/resized_profile_pic.png';
    final resizedFile = File(resizedPath)..writeAsBytesSync(img.encodePng(resizedImage));

    return resizedFile;
  }
}