import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery/core/styles/colors/app_colors.dart';
import 'package:flowery/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../core/local/secure_storage.dart';
import '../core/local/token_manger.dart';
import '../core/routes/page_route_name.dart';
import '../core/styles/fonts/app_fonts.dart';
import '../core/styles/images/app_images.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isNoInternet = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkInternetAndNavigate();
      }
    });
  }

  Future<void> _checkInternetAndNavigate() async {
    final hasInternet = await _checkInternetConnection();

    if (!hasInternet) {
      setState(() {
        _isNoInternet = true;
      });
      return;
    }
    _navigateToInitialRoute();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      }
      final lookup = await InternetAddress.lookup('example.com');
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> _navigateToInitialRoute() async {
    String initialRoute = PageRouteName.logIn;

    final rememberMe =
        await SecureStorageFactory.readData(key: 'rememberMe') ?? 'false';

    log(rememberMe, name: 'SplashScreen rememberMe');

    if (rememberMe == 'true') {
      initialRoute = PageRouteName.homeLayout;
    } else {
      TokenManager.deleteToken();
      initialRoute = PageRouteName.logIn;
    }

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(
        initialRoute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isNoInternet
            ? _buildNoInternetWidget()
            : Center(
                child: Lottie.asset(
                  controller: _controller,
                  AppImages.floweryAnimation,
                  fit: BoxFit.cover,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 120.sp, color: AppColors.kPink),
          20.verticalSpace,
          Text(
            'No internet connection',
            style: TextStyle(fontSize: 25.sp, color: AppColors.kPink),
          ),
          const SizedBox(height: 16),
          CustomButton(
            width: 10.w,
            backgroundColor: AppColors.kPink,
            text: 'Try again',
            textStyle: AppFonts.font16WhiteWeight500,
            onPressed: () async {
              setState(() {
                _isNoInternet = false;
              });
              _checkInternetAndNavigate();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
