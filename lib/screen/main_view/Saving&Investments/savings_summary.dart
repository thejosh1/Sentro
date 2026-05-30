import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class SavingsSummary extends StatefulWidget {
  const SavingsSummary({super.key});

  @override
  State<SavingsSummary> createState() => _SavingsSummaryState();
}

class _SavingsSummaryState extends State<SavingsSummary> {
  bool _isRead = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
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
                SizedBox(width: widthSize(113),),
                Column(
                  children: [
                    CText(
                      text: 'Summary',
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      size: 18,
                    ),
                    SizedBox(height: heightSize(7),),
                    CText(
                      text: '10 April, 2026',
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      size: 14,
                    ),
                  ],
                ),
              ],
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
                              text: '10,000',
                              color: isDark?Colors.white:Colors.black,
                              nairaColor: isDark?Colors.white:Colors.black,
                            ),
                            CText(
                              text: 'My New Savings',
                              fontWeight: CFONT.wMedium,
                              fontFamily: CFONT.FAMILY,
                              size: 12,
                            ),
                          ],
                        ),
                        SvgPicture.asset(barChat, width: widthSize(45), height: heightSize(45),),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(18),),
                  Column(
                      children: [
                        _receiptRow(
                          title: 'Product Type',
                          value: 'Flexible Savings',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Goal Name',
                          value: 'My Savings',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Amount',
                          value: 'N22,014',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Interest Rate',
                          value: '10% per annum',
                          isColored: true,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Payout Frequency',
                          value: 'Monthly',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Duration',
                          value: 'No lock-in',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Roll-over',
                          value: 'Yes — auto-reinvest',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: isDark ? sButtonFillDark : sLightBorder),
                        SizedBox(height: heightSize(11)),
                        _receiptRow(
                          title: 'Fund From',
                          value: 'Main Balance',
                          isColored: false,
                        ),
                        SizedBox(height: heightSize(19)),
                        Divider(color: sGrey2),
                        SizedBox(height: heightSize(27.5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Total at Maturity (est)',
                              fontWeight: CFONT.wMedium,
                              fontFamily: CFONT.FAMILY,
                              size: 14,
                            ),
                            CText(
                              text: 'N10,000',
                              fontWeight: CFONT.wBold,
                              fontFamily: CFONT.FAMILY,
                              size: 18,
                              color: sNavContainer,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(27),)
                      ]
                  )
                ],
              ),
            ),
            SizedBox(height: heightSize(12),),
            Container(
              height: heightSize(85),
              padding: EdgeInsets.symmetric(horizontal: widthSize(15),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                border: Border.all(color: sDarkBorder),
                color: sSentroLightGreen.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        text: 'Terms and conditions',
                        size: 14,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                      ),
                      SizedBox(height: heightSize(5),),
                      SizedBox(
                        width: widthSize(263),
                        child: CText(
                          text: 'By confirming, you authorise Sentro to debit your selected funding source. For Fixed Deposits and T-Bills, funds are locked until maturity.',
                          size: 12,
                          fontWeight: CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: widthSize(12),),
                  GestureDetector(
                    onTap: () => setState(() => _isRead = !_isRead),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeInOut,
                      width: widthSize(54),
                      height: heightSize(28),
                      padding: EdgeInsets.symmetric(
                        horizontal: widthSize(4),
                        vertical: heightSize(3),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: _isRead ? sNavContainer : sDarkBorder,
                      ),
                      child: Row(
                        mainAxisAlignment: _isRead
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeInOut,
                            width: widthSize(22),
                            height: heightSize(22),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: heightSize(47),),
            ActionButton(
              text: 'Confirm & Activate',
              color: _isRead==false?sNavContainer:sNavContainer..withOpacity(0.6),
              textColor: sActionButton,
              callback: () {
                _isRead==false?null:Get.back();
              },
            ),
            SizedBox(height: heightSize(10),),
          ],
        ),
      ),
    );
  }

  Widget _receiptRow({
    required String title,
    required String value,
    required bool isColored
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
          color: isColored ? sNavContainer : Theme.of(context).colorScheme.onSurface,
        ),
      ],
    );
  }
}