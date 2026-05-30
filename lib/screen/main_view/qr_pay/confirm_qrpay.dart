import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class ConfirmQrpay extends StatefulWidget {
  const ConfirmQrpay({super.key});

  @override
  State<ConfirmQrpay> createState() => _ConfirmQrpayState();
}

class _ConfirmQrpayState extends State<ConfirmQrpay> {

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
                    arrowBackWhite,
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
            SizedBox(height: heightSize(23),),
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
                      left: widthSize(19.5),
                      top: heightSize(20),
                      right: widthSize(18),
                      bottom: heightSize(20),
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
                              color: sNavContainer.withOpacity(0.2)
                          ),
                          child: SvgPicture.asset(
                            logo1x,
                            width: widthSize(26.08),
                            height: heightSize(25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(18),),
                  Column(
                    children: [
                      _receiptRow(
                        title: 'Receiver',
                        value: 'Richmond Uche',
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: isDark ? sButtonFillDark : sLightBorder),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Receiver Bank',
                        value: 'Sentro',
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: isDark ? sButtonFillDark : sLightBorder),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Account',
                        value: '9060007015',
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: isDark ? sButtonFillDark : sLightBorder),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Narration',
                        value: 'Sent from Sentro',
                      ),
                      SizedBox(height: heightSize(20)),
                      Divider(color: isDark ? sButtonFillDark : sLightBorder),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Fee (VAT & Stamp Duty)',
                        value: 'N15.45',
                      ),
                      SizedBox(height: heightSize(19),)
                    ],
                  )
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
            SizedBox(height: heightSize(50),),
          ],
        ),
      ),
    );
  }

  Widget _receiptRow({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          text: title,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 14,
          color: sConfirmTextColor,
        ),
        CText(
          text: value,
          fontWeight: CFONT.wMedium,
          size: 16,
          fontFamily: CFONT.FAMILY,
        ),
      ],
    );
  }
}