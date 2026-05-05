import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: sBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: heightSize(68),),
          SvgPicture.asset(
            logo,
            width: widthSize(204.79),
            height: heightSize(48),
          ),
          Spacer(),
          SvgPicture.asset(
            logo1x,
            width: widthSize(297.28),
            height: heightSize(285),
          ),
          SizedBox(height: heightSize(89.75),),
          Center(
            child: CText(
              text: 'Banking but 5% better',
              fontWeight: FontWeight.w400,
              size: 37.2,
              letterSpacing: 0.48,
              fontFamily: 'Perfectly Vintages',
            ),
          ),
          SizedBox(height: heightSize(8),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: CText(
              text: 'Semper vel id ut quisque sit. Sapien ut amet non in varius. Odio libero nulla lorem ornare nibh nulla interdum arcu.',
              size: 18.03, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: heightSize(68.25),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: Row(
              children: [
                // Left — Login
                Expanded(
                  child: SizedBox(
                    height: heightSize(60),
                    width: widthSize(185),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.white.withOpacity(0.10)
                            : Colors.black.withOpacity(0.08),
                        foregroundColor: isDark
                            ? Colors.white
                            : sGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: CFONT.SEMIBOLD,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(width: 12),
            
                // Right — Register
                Expanded(
                  child: SizedBox(
                    height: heightSize(60),
                    width: widthSize(185),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.createAccount);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sLemon,
                        foregroundColor: sDeepGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontFamily: CFONT.SEMIBOLD,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: heightSize(35),),
        ],
      ),
    );
  }
}
