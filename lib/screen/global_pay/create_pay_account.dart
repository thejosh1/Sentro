import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class CreatePayAccount extends StatefulWidget {
  const CreatePayAccount({super.key});

  @override
  State<CreatePayAccount> createState() => _CreatePayAccountState();
}

class _CreatePayAccountState extends State<CreatePayAccount> {
  // Tracks the currently selected currency code
  String _selectedCurrency = 'USD';

  // Currency options matching your UI layout specification
  final List<Map<String, String>> _currencies = [
    {
      'code': 'USD',
      'name': 'United States Dollar',
      'flag': america,
    },
    {
      'code': 'GBP',
      'name': 'Great British Pounds',
      'flag': britain,
    },
    {
      'code': 'Euro',
      'name': 'European Union Currency',
      'flag': euro,
    },
    {
      'code': 'GH₵',
      'name': 'Ghanian Cedes',
      'flag': ghana,
    },
    {
      'code': 'Rwanda',
      'name': 'United States Dollar', // Kept identical to layout mockup
      'flag': rwanda,
    },
  ];

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  void _onContinue() {
    if (_selectedCurrency.isNotEmpty) {
      // Navigates to the summary page and passes the selected code as an argument
      Get.toNamed(Routes.accountSummary, arguments: _selectedCurrency);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);

          // UI Primary Accents based on your screenshot's lime-green palette
          final primaryLime = const Color(0xFF9BED6E);
          final activeButtonColor = useAccent ? accent : primaryLime;
          final activeTextColor = useAccent ? Colors.white.withOpacity(0.4) : const Color(0xFF0D1E04);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: widthSize(24)),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: heightSize(20)),

                      // ── Header Row ─────────────────────────────────────────
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: widthSize(42),
                              height: heightSize(42),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.05),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  arrowBackWhite,
                                  width: widthSize(20),
                                  height: heightSize(20),
                                  colorFilter: ColorFilter.mode(
                                    isDark ? Colors.white : Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CText(
                            text: 'Create Account',
                            size: 18,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                          const Spacer(),
                          SizedBox(width: widthSize(42)), // Visual balancing offset
                        ],
                      ),

                      SizedBox(height: heightSize(27)),

                      // ── Instruction Subtitles ──────────────────────────────
                      CText(
                        text: 'Choose the right account type for you need.',
                        size: 16,
                        fontWeight: CFONT.wRegular,
                        color: isDark?sGrey1:sGrey2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: heightSize(4)),
                      CText(
                        text: 'Create, Send and Receive FX',
                        size: 16,
                        fontWeight: CFONT.wMedium,
                        fontFamily: CFONT.FAMILY,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: heightSize(28)),

                      // ── Currency Selection Main Wrapper ────────────────────
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: widthSize(20), vertical: heightSize(19)),
                        decoration: BoxDecoration(
                          color: isDark ? sContainerColor : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _currencies.length,
                          separatorBuilder: (_, __) => SizedBox(height: heightSize(12)),
                          itemBuilder: (context, index) {
                            final currency = _currencies[index];
                            final isSelected = _selectedCurrency == currency['code'];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCurrency = currency['code']!;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                  widthSize(19),
                                  heightSize(20),
                                  widthSize(17),
                                  heightSize(19),
                                ),
                                decoration: BoxDecoration(
                                  color: isDark ? sDarkBorder : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    // Circular Flag Representation
                                    Image.asset(
                                      currency['flag']!,
                                      width: widthSize(41),
                                      height: heightSize(41),
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: widthSize(10)),

                                    // Currency Labels
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            text: currency['code']!,
                                            size: 16,
                                            fontWeight: CFONT.wRegular,
                                            //fontFamily: CFONT.FAMILY,
                                          ),
                                          SizedBox(height: heightSize(2)),
                                          CText(
                                            text: currency['name']!,
                                            size: 12,
                                            fontWeight: CFONT.wRegular,
                                            color: isDark?sGrey1:sGrey2,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Dynamic Checkbox Indicator
                                    Container(
                                      width: widthSize(28),
                                      height: heightSize(28),
                                      decoration: BoxDecoration(
                                        color: isSelected ? activeButtonColor : (isDark ? sGrey1.withOpacity(0.4) : sGrey2.withOpacity(0.4)),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: isSelected
                                          ? Icon(
                                        Icons.check,
                                        color: activeTextColor,
                                        size: widthSize(16),
                                      )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: heightSize(24)),
                    ],
                  ),
                ),
              ),

              // ── Action Footer Button ───────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(24),
                  vertical: heightSize(16),
                ),
                child: ActionButton(
                  text: 'Continue',
                  color: activeButtonColor,
                  borderColor: activeButtonColor,
                  textColor: activeTextColor,
                  disabledColor: activeButtonColor.withOpacity(0.4),
                  disabledBorderColor: activeButtonColor.withOpacity(0.4),
                  disabledTextColor: activeTextColor.withOpacity(0.4),
                  callback: _onContinue,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}