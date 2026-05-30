import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64),),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                SizedBox(width: widthSize(101),),
                CText(
                  text: 'Confirmation',
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                  size: 18,
                ),
              ],
            ),
            SizedBox(height: heightSize(7),),
            Center(
              child: CText(
                text: '10 April, 2026',
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                size: 14,
              ),
            ),
            SizedBox(height: heightSize(17),),
            Container(
              padding: EdgeInsets.only(
                left: widthSize(20),
                top: heightSize(22),
                right: widthSize(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: sContainerColor,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: widthSize(24.9),
                      top: heightSize(21),
                      right: widthSize(18),
                      bottom: heightSize(19),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: sDarkBorder
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextNaira(
                              text: '500,000',
                              color: isDark?Colors.white:Colors.black,
                              nairaColor: isDark?Colors.white:Colors.black,
                            ),
                            CText(
                              text: '+ N15.45 VAT & Stamp Duty',
                              fontWeight: CFONT.wMedium,
                              fontFamily: CFONT.FAMILY,
                              size: 12,
                            ),
                          ],
                        ),
                        Container(
                          width: widthSize(45),
                          height: heightSize(45),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(mtn),
                                fit: BoxFit.cover,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text: 'Receiver',
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        size: 14,
                        color: sConfirmTextColor,
                      ),
                      CText(
                        text: '09060007015',
                        fontWeight: CFONT.wMedium,
                        size: 16,
                        fontFamily: CFONT.FAMILY,
                      )
                    ],
                  ),
                  SizedBox(height: heightSize(17),),
                  Divider(color: isDark ? sButtonFillDark : sLightBorder,),
                  SizedBox(height: heightSize(17),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CText(
                        text: 'Provider',
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        size: 14,
                        color: sConfirmTextColor,
                      ),
                      CText(
                        text: 'MTN',
                        fontWeight: CFONT.wMedium,
                        size: 16,
                        fontFamily: CFONT.FAMILY,
                      )
                    ],
                  ),
                  SizedBox(height: heightSize(29.5),),
                ],
              ),
            ),
            Spacer(),
            ActionButton(
              text: 'Continue',
              color: sNavContainer,
              textColor: sActionButton,
              callback: () {
                Get.toNamed(Routes.confirmTransaction);
              },
            ),
            SizedBox(height: heightSize(10),),
          ],
        ),
      ),
    );
  }
}