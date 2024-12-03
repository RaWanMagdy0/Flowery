import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/local/secure_storage.dart';
import '../core/local/token_manger.dart';
import '../core/routes/page_route_name.dart';
import '../core/styles/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToInitialRoute();
      }
    });
  }

  _navigateToInitialRoute() async {
    String initialRoute = PageRouteName.logIn;

    final remeberMe =
        await SecureStorageFactory.readData(key: 'rememberMe') ?? 'false';

    log(remeberMe, name: 'SplashScreen rememberMe');

    if (remeberMe == 'true') {
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
        child: Center(
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
