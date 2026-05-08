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
    return Scaffold(
      backgroundColor: sNavContainer,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(logo, width: widthSize(199.53), height: heightSize(48),),
          Spacer(),
          Center(
            child: Container(
              width: widthSize(93),
              height: heightSize(93),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Values().buttonRadius20),
                color: sTextGreen.withOpacity(0.2),
              ),
              child: Center(
                child: SvgPicture.asset(check),
              ),
            ),
          ),
          SizedBox(height: heightSize(23.53),),
          CText(
            text: 'Welcome John!',
            size: 28,
            fontWeight: FontWeight.w400,
            fontFamily: 'Perfectly Vintages',
            color: Colors.black,
          ),
          SizedBox(height: heightSize(15),),
          CText(
            text: 'Nice to see you again Lorem ipsum dolor sit amet\nconsectetur. Dolor cursus duis pulvinar arcu sit in\negestas massa.',
            fontFamily: CFONT.REGULAR,
            size: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: widthSize(25),
            right: widthSize(25),
            bottom: heightSize(47)),
        child: ActionButton(
          text: "Continue",
          callback: () {
            Get.toNamed(Routes.mainView);
          },
          load: false,
        ),
      ),
    );
  }
}
