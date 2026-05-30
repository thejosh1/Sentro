import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

class Decision extends StatelessWidget {
  const Decision({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(arrowBackWhite, width: widthSize(42), height: heightSize(42)),
                ),
                const Spacer(),
              ],
            ),

            Spacer(),
            SvgPicture.asset(infoCircle, width: widthSize(77), height: heightSize(77),),
            SizedBox(height: heightSize(35)),
            CText(
              text: 'You\'re not eligible for loans, yet.',
              size: 18,
              fontFamily: CFONT.FAMILY,
              height: 20/18,
              fontWeight: CFONT.wMedium,
            ),
            SizedBox(height: heightSize(5)),
            CText(
              text: 'We\'re unable to offer you loans at moment, continue to use Sentro.',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              height: 20/14,
              textAlign: TextAlign.center,
              color: sConfirmTextColor,
            ),
            Spacer(),
            SvgPicture.asset(sentroBusiness, width: widthSize(95.44), height: heightSize(25.21),),
            CText(
              text: 'If your employer uses Sentro Business, you can easily\nrequest for Overdraft.',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              height: 20/14,
              textAlign: TextAlign.center,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(23.79),),
            CText(
              text: 'Try Overdraft',
              size: 15,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
              color: sNavContainer,
            ),
            SizedBox(height: heightSize(71.95),),
          ],
        ),
      ),
    );
  }
}