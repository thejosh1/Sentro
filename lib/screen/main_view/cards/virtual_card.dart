import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

import 'cards_page.dart';

class VirtualCard extends StatefulWidget {
  const VirtualCard({super.key});

  @override
  State<VirtualCard> createState() => _VirtualCardState();
}

class _VirtualCardState extends State<VirtualCard> {
  late final Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    // Safely retrieve arguments passed as a Map
    data = Get.arguments as Map<String, dynamic>;
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  CardNetwork get network => data['network'] as CardNetwork;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
          child: Column(
            children: [
              SizedBox(height: heightSize(64)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent ? ColorFilter.mode(
                          accent, BlendMode.srcIn) : null,
                    ),
                  ),
                  SizedBox(width: widthSize(104)),
                  CText(
                    text: 'Virtual Card',
                    size: 18,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                  ),
                ],
              ),
              SizedBox(height: heightSize(15)),
              SvgPicture.asset(
                // Dynamically switches between your visa and verve SVG paths
                network == CardNetwork.visa ? visa : visa,
                width: widthSize(92.78),
                height: heightSize(50.61),
                colorFilter: isDark
                    ? null
                    : const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: heightSize(15.39)),
              Image.asset(
                data['image'],
                height: widthSize(464),
                width: heightSize(278),
                fit: BoxFit.contain,
              ),
              SizedBox(height: heightSize(29)),
              CText(
                text: 'Built with control, security. For your convenience',
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                size: 24,
                height: 1.5,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: heightSize(15)),
              CText(
                text: 'Make payments using Sentro virtual card for every global online transactions.',
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                size: 14,
                textAlign: TextAlign.center,
                color: sConfirmTextColor,
              ),
              SizedBox(height: heightSize(65)),
              ActionButton(
                color: accent,
                borderColor: accent,
                text: "Create Virtual Card",
                textColor: sActionButton,
                callback: () {
                  FocusScope.of(context).unfocus();
                  Get.toNamed(Routes.cardSummary);
                },
                load: false,
              )
            ],
          ),
        );
      }),
    );
  }
}