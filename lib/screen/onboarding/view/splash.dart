import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/services/storage_service.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      _checkFirstTimeUser();
    });
  }

  void _checkFirstTimeUser() {
    final isFirstTime = StorageService.isFirstTime;

    if (isFirstTime) {
      StorageService.setFirstTime(false);
      Get.offAllNamed(Routes.getStarted);
    } else {
      StorageService.clearToken();
      Get.offAllNamed(Routes.getStarted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SvgPicture.asset(splash),
      ),
    );
  }
}