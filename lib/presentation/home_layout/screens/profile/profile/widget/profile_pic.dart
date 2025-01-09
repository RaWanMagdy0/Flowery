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
  User user;

   CustomProfilePic({super.key,required this.user});

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
                  child: Image.network(
                      fit: BoxFit.cover,
                      widget.user.photo ?? Image.asset(AppImages.photo).toString())),
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
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        if (mounted) {
          AppDialogs.showLoading(context: context);
        }
        File imageFile = File(pickedFile.path);
        final compressedImage = await _processImage(imageFile);
        setState(() {
          photo = compressedImage;
        });
        await viewModel.uploadPhoto(File(compressedImage.path));
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        Navigator.pop(context);
        AppDialogs.showErrorDialog(
          context: context,
          errorMassage: e is DioException
              ? e.response?.data['error'] ?? 'Failed to upload photo'
              : 'Failed to process image',
        );
      }
    }
  }

  Future<File> _processImage(File imageFile) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      '${(await getTemporaryDirectory()).path}/processed_image.jpg',
      quality: 85,
      minWidth: 1024,
      minHeight: 1024,
    );
    if (result == null) throw Exception('Failed to compress image');
    return File(result.path);
  }
}
