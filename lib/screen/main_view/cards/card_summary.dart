import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class CardSummary extends StatefulWidget {
  const CardSummary({super.key});

  @override
  State<CardSummary> createState() => _CardSummaryState();
}

class _CardSummaryState extends State<CardSummary> {
  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  bool _isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Padding(
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
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent ? ColorFilter.mode(
                          accent, BlendMode.srcIn) : null,
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
                  color: isDark ? sContainerColor : Colors.black.withOpacity(
                      0.2),
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
                        color: isDark ? sDarkBorder : sLightBorder,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextNaira(
                                text: '2,000',
                                color: isDark ? Colors.white : Colors.black,
                                nairaColor: isDark ? Colors.white : Colors
                                    .black,
                              ),
                              CText(
                                text: 'Card creation fees',
                                fontWeight: CFONT.wMedium,
                                fontFamily: CFONT.FAMILY,
                                size: 12,
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            wallet,
                            width: widthSize(45),
                            height: heightSize(45),
                            colorFilter: useAccent?ColorFilter.mode(
                              accent, BlendMode.srcIn,
                            ):isDark?ColorFilter.mode(
                              sNavContainer, BlendMode.srcIn,
                            ):ColorFilter.mode(
                              sActionButton, BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(18),),
                    Column(
                      children: [
                        _receiptRow(
                          title: 'Virtual Card',
                          value: '₦2,000.00',
                          isDark: isDark,
                        ),
                        SizedBox(height: heightSize(18.5)),
                        Divider(color: sButtonFillDark),
                        SizedBox(height: heightSize(18.5)),
                        _receiptRow(
                          title: 'VAT',
                          value: '₦50.00',
                          isDark: isDark,
                        ),
                        SizedBox(height: heightSize(18.5)),
                        Divider(color: sButtonFillDark),
                        SizedBox(height: heightSize(18.5)),
                        _receiptRow(
                          title: 'Fund From',
                          value: 'Main Balance',
                          isDark: isDark,
                        ),
                        SizedBox(height: heightSize(18.5)),
                        Divider(color: sButtonFillDark),
                        SizedBox(height: heightSize(18.5)),
                        _receiptRow(
                          title: 'Total at Maturity (est)',
                          value: 'N2,050',
                          isDark: isDark,
                          useAccent: true,
                          accent: accent
                        ),

                        SizedBox(height: heightSize(31),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: heightSize(20),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: widthSize(15), vertical: heightSize(13)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.17),
                  border: Border.all(color: sSentroLightGreen),
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
                          text: 'Accept and Continue ',
                          size: 14,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wMedium,
                        ),
                        SizedBox(height: heightSize(5),),
                        SizedBox(
                          width: widthSize(263),
                          child: CText(
                            text: 'By confirming, you authorise Sentro to debit your selected funding source. to create your account',
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
              Spacer(),
              ActionButton(
                text: 'Create Card',
                color: useAccent?accent:sNavContainer,
                textColor: sActionButton,
                callback: () {
                  Get.toNamed(
                    Routes.confirmTransaction,
                    arguments: {'isCardCreation': true},
                  );
                },
              ),
              SizedBox(height: heightSize(30),),
            ],
          ),
        );
      }),
    );
  }

  Widget _receiptRow({
    required String title,
    required String value,
    required bool isDark,
    bool useAccent = false,
    Color? accent,

  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          text: title,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 14,
          color: isDark ? sConfirmTextColor : sGrey2,
        ),
        CText(
          text: value,
          fontWeight: CFONT.wMedium,
          size: 16,
          fontFamily: CFONT.FAMILY,
          color: useAccent?accent:null,
        ),
      ],
    );
  }
}
