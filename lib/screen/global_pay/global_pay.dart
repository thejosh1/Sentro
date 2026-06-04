import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class GlobalPay extends StatefulWidget {
  const GlobalPay({super.key});

  @override
  State<GlobalPay> createState() => _GlobalPayState();
}

bool _isDefaultAccent(Color c) {
  final defaultAccent = AccentController.options.first;
  return c.value == defaultAccent.value;
}

class _GlobalPayState extends State<GlobalPay> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: widthSize(20),),
          child: Column(
            children: [
              SizedBox(height: heightSize(64),),
              Row(
                children: [
                  SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                    colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                  ),
                  SizedBox(width: widthSize(89),),
                  SvgPicture.asset(logoGlobalPay, width: widthSize(127.11), height: heightSize(37.98),),
                ],
              ),
              SizedBox(height: heightSize(83.18),),
              Image.asset(
                globe,
                width: widthSize(375.05),
                height: heightSize(360),
              ),
              SizedBox(height: heightSize(61.5),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize(22)),
                child: Column(
                  children: [
                    CText(
                      text: 'Built with control, security. For your convenience',
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      size: 24,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: heightSize(15),),
                    CText(
                      text: 'Make payments using Sentro virtual card for every global online transactions.',
                      size: 14,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(height: heightSize(57.5),),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.verification);
                },
                child: SvgPicture.asset(
                  arrowLeft,
                  width: widthSize(70),
                  height: heightSize(70),
                  colorFilter: useAccent
                      ? ColorFilter.mode(accent, BlendMode.srcIn)
                      : null,
                ),
              ),
              SizedBox(height: heightSize(106.5),),
            ],
          ),
        );
      }),
    );
  }
}
