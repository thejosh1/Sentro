import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class EligibilityTest extends StatefulWidget {
  const EligibilityTest({super.key});

  @override
  State<EligibilityTest> createState() => _EligibilityTestState();
}

class _EligibilityTestState extends State<EligibilityTest> {
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
                Container(
                  width: widthSize(156),
                  height: heightSize(36.67),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(83.34),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        text: 'Loan Calculator',
                        size: 14,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                      ),
                      SizedBox(width: widthSize(5),),
                      SvgPicture.asset(calculator, width: widthSize(24), height: heightSize(24),)
                    ],
                  ),
                )
              ],
            ),

            Spacer(),
            CText(
              text: 'Eligibility Check',
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
            ),
            SizedBox(height: heightSize(2.5)),
            CText(
              text: 'Check if you are eligible to take a loan',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(57.5),),
            Container(
              width: widthSize(203),
              height: heightSize(203),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sNavContainer.withOpacity(0.1),
              ),
              child: Center(
                child: SvgPicture.asset(securityUser, width: widthSize(136), height: heightSize(136),),
              ),
            ),
            SizedBox(height: heightSize(66),),
            ActionButton(
              text: 'Check Eligibility',
              color: Colors.transparent,
              borderColor: sNavContainer,
              textColor: Colors.white,
              callback: (){
                Get.toNamed(Routes.decision);
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}