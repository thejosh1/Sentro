import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/theme_controller.dart';
import 'package:sentro/core/utils/text.dart';

class AppearanceToggle extends StatelessWidget {
  const AppearanceToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ThemeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<ThemeController>(
      builder: (_) {
        final isDark = ctrl.isDarkMode;

        return Column(
          children: [
            Center(
              child: CText(
                text: 'Appearance',
                size: 12,
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                color: sGrey1,
              ),
            ),
            SizedBox(height: heightSize(7)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(12),
                vertical: heightSize(12),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark?sDarkFill:sLightFill,
              ),
              child: Row(
                children: [
                  // ── Light ────────────────────────────────────
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ctrl.setTheme(ThemeMode.light),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        height: heightSize(40),
                        decoration: BoxDecoration(
                          color: !isDark
                              ? sActionButton
                              : Colors.white.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              light,
                              width: widthSize(20),
                              height: heightSize(20),
                            ),
                            SizedBox(width: widthSize(8)),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 180),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: !isDark
                                    ? CFONT.wMedium
                                    : CFONT.wRegular,
                                color: Colors.white,
                              ),
                              child: const Text('Light'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Dark ─────────────────────────────────────
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ctrl.setTheme(ThemeMode.dark),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        height: heightSize(40),
                        decoration: BoxDecoration(
                          color: isDark
                              ? sActionButton
                              : sDescriptionColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              dark,
                              width: widthSize(20),
                              height: heightSize(20),
                            ),
                            SizedBox(width: widthSize(8)),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 180),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: CFONT.FAMILY,
                                fontWeight:
                                isDark ? CFONT.wMedium : CFONT.wRegular,
                                color: Colors.white,
                              ),
                              child: const Text('Dark'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}