import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navega_app/core/routes/app_routes.dart';
import 'package:navega_app/core/constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Get.offNamed(Routes.login);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: ClipRect(
          child: Transform.scale(
            scale: 1.05,
            child: Image.asset(
              AppImage.splash,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}