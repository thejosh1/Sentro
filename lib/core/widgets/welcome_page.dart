import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth  = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: sNavContainer, // light green from design
      body: Stack(
        children: [
          // ── Background web pattern ────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.52, // covers top ~half
            child: SvgPicture.asset(
              unionLarge,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.35),
                BlendMode.srcIn,
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: heightSize(20)),

                // ── Logo ─────────────────────────────────────
                Center(
                  child: SvgPicture.asset(
                    logoLight,
                    width: widthSize(200),
                    height: heightSize(48),
                  ),
                ),

                const Spacer(),

                // ── Check icon ────────────────────────────────
                Container(
                  width: widthSize(93),
                  height: heightSize(93),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Values().buttonRadius20),
                    color: sTextGreen.withOpacity(0.2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      check,
                      width: widthSize(40),
                      height: heightSize(40),
                      colorFilter: ColorFilter.mode(
                        sTextGreen,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightSize(24)),

                // ── Welcome title ─────────────────────────────
                CText(
                  text: 'Welcome, John!',
                  size: 28,
                  fontWeight: CFONT.wBold,
                  fontFamily: CFONT.SEMIBOLD,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: heightSize(15)),

                // ── Subtitle ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthSize(30)),
                  child: CText(
                    text:
                    'Nice to see you again Lorem ipsum dolor sit amet '
                        'consectetur. Dolor cursus duis pulvinar arcu sit in '
                        'egestas massa.',
                    fontFamily: CFONT.FAMILY,
                    size: 16,
                    fontWeight: CFONT.wRegular,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(),

                // ── Continue button ───────────────────────────
                Padding(
                  padding: EdgeInsets.only(
                    left: widthSize(25),
                    right: widthSize(25),
                    bottom: heightSize(47),
                  ),
                  child: ActionButton(
                    text: 'Continue',
                    textColor: sNavContainer,
                    callback: () => Get.toNamed(Routes.enableBiometrics),
                    load: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}