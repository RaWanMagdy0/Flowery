import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/routes/page_route_name.dart';
import '../core/styles/colors/app_colors.dart';
import '../core/styles/images/app_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  _navigateAfterDelay() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, PageRouteName.forgetPassword);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: AppColors.kWhite,
        child: Lottie.asset(
            AppImages.splash,
            fit: BoxFit.fill,
            animate: true,
            alignment: Alignment.center
        ),
      ),
    );
  }
}
