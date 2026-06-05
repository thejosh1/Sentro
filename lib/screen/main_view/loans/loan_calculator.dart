import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  State<LoanCalculator> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  TextEditingController amountController = TextEditingController();
  bool _isSheetOpen = false;
  String _selectedDuration = '6 Month';

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  final List<String> _durationOptions = [
    '1 Month',
    '3 Month',
    '6 Month',
    '12 Month',
  ];

  void _showDurationBottomSheet({
    required BuildContext context,
    required bool isDark,
    required bool useAccent,
    required Color accent,
  }) {
    setState(() => _isSheetOpen = true);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: widthSize(25),
          vertical: heightSize(20),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: isDark ? sDarkBorder : const Color(0xFFDDDDDD)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Indicator Handle
            Container(
              width: widthSize(40),
              height: heightSize(5),
              decoration: BoxDecoration(
                color: sGrey2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: heightSize(24)),
            CText(
              text: 'Select Loan Duration',
              size: 18,
              fontWeight: CFONT.wBold,
              fontFamily: CFONT.FAMILY,
            ),
            SizedBox(height: heightSize(20)),

            // Generate list items dynamically
            Column(
              children: _durationOptions.map((duration) {
                final isSelected = _selectedDuration == duration;
                final activeColor = useAccent ? accent : sNavContainer;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedDuration = duration);
                    Get.back();
                  },
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: heightSize(12)),
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(16),
                      vertical: heightSize(16),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? activeColor.withOpacity(0.1) : sDarkFill,
                      borderRadius: BorderRadius.circular(Values().buttonRadius10),
                      border: Border.all(
                        color: isSelected ? activeColor : sDarkBorder,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          text: duration,
                          size: 14,
                          fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle_rounded,
                            color: activeColor,
                            size: widthSize(20),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: heightSize(15)),
          ],
        ),
      ),
      isScrollControlled: true,
    ).then((_) {
      // Clean up arrow rotation animation state on closure
      setState(() => _isSheetOpen = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
          child: Column(
            children: [
              SizedBox(height: heightSize(64)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      arrowBackWhite, width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                    ),
                  ),
                ],
              ),
              CText(
                text: 'Loan Calculator',
                size: 19.85,
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
              ),
              SizedBox(height: heightSize(2.76)),
              CText(
                text: '20% Interest Rate',
                size: 18,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: useAccent?accent:sNavContainer,
              ),
              SizedBox(height: heightSize(47.78)),
              AppTextField(
                title: CText(
                  text: 'Loan Amount (N)',
                  size: 16,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                ),
                showNairaPrefix: true,
                hasBottomMargin: false,
                height: heightSize(55),
                hint: '0.00',
                controller: amountController,
                inputType: const TextInputType.numberWithOptions(decimal: true),
                // Allowed decimals & commas smoothly
                inputFormatters: [NairaInputFormatter()],
                error: '',
                validFunction: (_) => null,
              ),
              SizedBox(height: heightSize(12.5),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: 'Duration',
                    size: 16,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                  ),
                  SizedBox(height: heightSize(5),),
                  GestureDetector(
                    onTap: () => _showDurationBottomSheet(
                      context: context,
                      isDark: isDark,
                      useAccent: useAccent,
                      accent: accent,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: widthSize(15),
                        top: heightSize(20.5),
                        right: widthSize(19),
                        bottom: heightSize(20.5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Values().buttonRadius10),
                        color: sDarkFill,
                        border: Border.all(color: sDarkBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.3),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: CText(
                              // FIX: Passing a ValueKey makes AnimatedSwitcher update text dynamically
                              key: ValueKey<String>(_selectedDuration),
                              text: _selectedDuration,
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                            ),
                          ),
                          AnimatedRotation(
                            // FIX: Alternates turns between 0 and 0.5 (flipped) based on sheet state
                            turns: _isSheetOpen ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: SvgPicture.asset(
                              arrowDown,
                              width: widthSize(20),
                              height: heightSize(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightSize(12.5),),
              Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(15),
                      vertical: heightSize(18),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.17),
                      color: sDarkFill,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Card Title ─────────────────────────────
                        CText(
                          text: 'Interest Preview',
                          size: 16,
                          fontWeight: CFONT.wMedium,
                          fontFamily: CFONT.FAMILY,
                          color: useAccent?accent:sNavContainer,
                        ),
                        SizedBox(height: heightSize(15),),
                        // ── Items ──────────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Loan Amount',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: 'N0.00',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10),),
                        Divider(color: sDarkBorder,),
                        SizedBox(height: heightSize(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Loan Rate',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: '20%',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10),),
                        Divider(color: sDarkBorder,),
                        SizedBox(height: heightSize(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Monthly',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: '1.7%',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10),),
                        Divider(color: sDarkBorder,),
                        SizedBox(height: heightSize(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Total Interest (1 year)',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: 'N10',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              color: useAccent?accent:sNavContainer,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10),),
                        Divider(color: sDarkBorder,),
                        SizedBox(height: heightSize(17),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'Total Payback',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: 'N0.00',
                              size: 16,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wBold,
                              color: useAccent?accent:sNavContainer,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(6),),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(8)),
                  CText(
                    text: 'This is just an interest calculator, fines for late payment is not included. Late payment penalty is 1% of total loan collected',
                    size: 14,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: sGrey2,
                  ),
                ],
              ),
              SizedBox(height: heightSize(20),),
              ActionButton(
                text: 'Take Loan',
                color: Colors.transparent,
                borderColor: sGrey2,
                textColor: Colors.white,
                callback: () {
                  Get.toNamed(Routes.eligibilityTest);
                },
              ),
              SizedBox(height: heightSize(12.5),),
            ],
          ),
        );
      }),
    );
  }
}