import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class ConfirmTransfer extends StatefulWidget {
  const ConfirmTransfer({super.key});

  @override
  State<ConfirmTransfer> createState() => _ConfirmTransferState();
}

class _ConfirmTransferState extends State<ConfirmTransfer> {
  bool _isAnonymous = false;

  late final bool isSentroTag;
  late final bool isRequest;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments ?? {};
    isSentroTag = args['isSentroTag'] ?? false;
    isRequest = args['isRequest'] ?? false;
  }

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
                color: isDark?sContainerColor:Colors.black.withOpacity(0.2),
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
                        color: isDark?sDarkBorder:sLightBorder,
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
                              image: AssetImage(
                                isSentroTag
                                    ? sentroTag
                                    : unionBank,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(18),),
                  Column(
                    children: isSentroTag
                        ? [
                      _receiptRow(
                        title: isRequest ? 'Request from' : 'Send to',
                        value: 'Richmond Uche - @richmond',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: sButtonFillDark),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Payment Method',
                        value: 'Sentro',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: sButtonFillDark),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Fee',
                        value: 'NG 0.00',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(19),)
                    ]
                        : [
                      _receiptRow(
                        title: 'Receiver',
                        value: 'Richmond Uche',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color:sButtonFillDark),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Receiver Bank',
                        value: 'Opay',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: sButtonFillDark),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Account',
                        value: '9060007015',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: sButtonFillDark),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Narration',
                        value: 'Sent from Sentro',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(18.5)),
                      Divider(color: isDark ? sButtonFillDark : sLightBorder),
                      SizedBox(height: heightSize(18.5)),
                      _receiptRow(
                        title: 'Fee (VAT & Stamp Duty)',
                        value: 'N15.45',
                        isDark: isDark,
                      ),
                      SizedBox(height: heightSize(31),)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: heightSize(20),),
            Center(
              child: Container(
                width: widthSize(139.76),
                height: heightSize(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(110.65),
                  color: isDark?sTierColor:sLightFill,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      tickSquare,
                      width: widthSize(21.26),
                      height: heightSize(21.26),
                    ),
                    SizedBox(width: widthSize(3.32),),
                    CText(
                      text: 'Save Beneficiary',
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: heightSize(20),),
            Container(
              height: heightSize(85),
              padding: EdgeInsets.symmetric(horizontal: widthSize(15),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                border: Border.all(color: sDarkBorder),
                color: Colors.white.withOpacity(0.05),
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
                        text: 'Send Anonymously ',
                        size: 14,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                      ),
                      SizedBox(height: heightSize(5),),
                      SizedBox(
                        width: widthSize(263),
                        child: CText(
                          text: 'Send money to this person without knowing who sent the money',
                          size: 12,
                          height: heightSize(1.5),
                          fontWeight: CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: widthSize(12),),
                  GestureDetector(
                    onTap: () => setState(() => _isAnonymous = !_isAnonymous),
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
                        color: _isAnonymous ? sNavContainer : sDarkBorder,
                      ),
                      child: Row(
                        mainAxisAlignment: _isAnonymous
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
            SizedBox(height: heightSize(isSentroTag?200:74),),
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

  Widget _receiptRow({
    required String title,
    required String value,
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          text: title,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 14,
          color: isDark?sConfirmTextColor:sGrey2,
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