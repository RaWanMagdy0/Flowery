import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/styles/images/app_images.dart';
import '../../../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';
import '../../../../../../domain/entities/home_layout/profile/user.dart';

class CustomProfilePic extends StatefulWidget {
  final User user;
  const CustomProfilePic({super.key, required this.user});

  @override
  State<CustomProfilePic> createState() => _CustomProfilePicState();
}

class _CustomProfilePicState extends State<CustomProfilePic> {
  late ProfileCubit viewModel;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: BlocProvider(
        create: (context) => viewModel,
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            switch (state) {
              case UploadPhotoLoadingState():
                AppDialogs.showLoading(context: context);

              case UploadPhotoSuccessState():
                Navigator.pop(context);
                AppDialogs.showSuccessDialog(
                  context: context,
                  message: "Photo uploaded successfully",
                );

              case UploadPhotoErrorState():
                Navigator.pop(context);
                AppDialogs.showErrorDialog(
                  context: context,
                  errorMassage: state.errorMessage.toString(),
                );
              default:
            }
          },
          child: Stack(
            children: [
              ClipOval(
                child: _selectedImage != null
                    ? Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 100.w,
                )
                    : Image.network(
                  widget.user.photo ?? AppImages.photo,
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 100.w,
                  errorBuilder: (_, __, ___) => Image.asset(AppImages.photo),
                ),
              ),
              Positioned(
                bottom: 5.h,
                right: 5.w,
                child: _buildCameraButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraButton() {
    return GestureDetector(
      onTap: () => _pickAndUploadImage(),
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
    );
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        final fileExtension = pickedFile.path.split('.').last.toLowerCase();
        if (fileExtension != 'jpg' && fileExtension != 'jpeg' && fileExtension != 'png'
            && fileExtension != 'webp'
        ) {
          AppDialogs.showErrorDialog(
            context: context,
            errorMassage: 'Only JPG, JPEG,webp, and PNG images are allowed.',
          );
          return;
        }
        final compressedImage = await _compressImage(File(pickedFile.path));
        setState(() {
          _selectedImage = compressedImage;
        });
        await viewModel.uploadPhoto(compressedImage);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: e is DioException
              ? e.response?.data['error'] ?? 'Upload failed'
              : 'Image processing failed',
        );
      }
    }
  }

  Future<File> _compressImage(File image) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '${(await getTemporaryDirectory()).path}/compressed_image.jpg',
      quality: 85,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result == null) throw Exception('Image compression failed');
    return File(result.path);
  }
}