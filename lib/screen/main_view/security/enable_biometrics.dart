import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class EnableBiometrics extends StatelessWidget {
  const EnableBiometrics({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: heightSize(60),),
          Center(
              child: SvgPicture.asset(isDark?logo:logo2x, width: widthSize(170.66), height: heightSize(40),)),
          SizedBox(height: heightSize(40),),
          CText(
            text: 'Enable Biometric login',
            fontWeight: CFONT.wBold,
            fontFamily: CFONT.FAMILY,
            size: 22,
          ),
          SizedBox(height: heightSize(5),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(49)),
            child: CText(
              text: 'Authorise transactions with ease using your Face ID or Fingerprint',
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: sGrey2,
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          SvgPicture.asset(fingerScan2,
            width: widthSize(112.5),
            height: heightSize(134),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.mainView);
              },
              child: Container(
                width: double.maxFinite,
                height: heightSize(55),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: sActionButton,
                ),
                child: Center(
                  child: CText(
                    text: 'Enable Biometrics',
                    size: 16,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wMedium,
                    color: sNavContainer,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: heightSize(44),),
          InkWell(
            onTap: () {

            },
            child: CText(
              text: 'Not Now',
              size: 18,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              color: sGrey2,
            ),
          ),
          SizedBox(height: heightSize(44),),
        ],
      ),
    );
  }
}
