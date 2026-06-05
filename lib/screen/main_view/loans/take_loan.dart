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

class TakeLoan extends StatefulWidget {
  const TakeLoan({super.key});

  @override
  State<TakeLoan> createState() => _TakeLoanState();
}

class _TakeLoanState extends State<TakeLoan> {
  TextEditingController amountController = TextEditingController();
  bool _isRead = false;

  bool _isDurationOpen = false;
  String _selectedDuration = '6 Months';

  final List<String> _durations = [
    '1 Month',
    '3 Months',
    '6 Months',
    '12 Months',
    '18 Months',
    '24 Months',
  ];

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          return Column(
            children: [
              SizedBox(height: heightSize(64)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      arrowBackWhite, width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: heightSize(19)),
              CText(
                text: 'Take Loan',
                size: 18,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
              ),
              SizedBox(height: heightSize(15)),
              CText(
                text: 'Loan Eligibility',
                size: 16,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                height: 20 / 14,
                color: sGrey1,
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text: 'N10,000,000',
                size: 24,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                color: useAccent?accent:isDark?sNavContainer:sActionButton,
              ),
              SizedBox(height: heightSize(26)),
              AppTextField(
                title: CText(
                  text: 'Loan Amount (N)',
                  size: 16,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
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
              SizedBox(height: 12.5,),
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
                  _SelectorBox(
                    isDark: true,
                    isOpen: _isDurationOpen,
                    label: _selectedDuration,
                    isEmpty: false,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      setState(() => _isDurationOpen = true);
                      await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (_) =>
                            _BottomSheet(
                              isDark: true,
                              title: 'Loan Duration',
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: _durations.map((d) {
                                  final isSelected = d == _selectedDuration;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() => _selectedDuration = d);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.only(
                                          bottom: heightSize(10)),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: widthSize(16),
                                        vertical: heightSize(14),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: isSelected
                                            ? sNavContainer.withOpacity(0.10)
                                            : sDarkFill,
                                        border: Border.all(
                                          color: isSelected
                                              ? sNavContainer.withOpacity(0.4)
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          CText(
                                            text: d,
                                            size: 14,
                                            fontFamily: CFONT.FAMILY,
                                            fontWeight: isSelected ? CFONT
                                                .wMedium : CFONT.wRegular,
                                            color: isSelected
                                                ? sNavContainer
                                                : Colors.white,
                                          ),
                                          if (isSelected)
                                            SvgPicture.asset(
                                              tickLight,
                                              width: widthSize(18),
                                              height: heightSize(18),
                                              colorFilter: const ColorFilter
                                                  .mode(
                                                sNavContainer, BlendMode.srcIn,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                      );
                      setState(() => _isDurationOpen = false);
                    },
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
                          color: useAccent?accent:isDark?sNavContainer:sActionButton,
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
                              text: 'First Repayment Amount',
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
                        SizedBox(height: heightSize(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: 'First Repayment Date',
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: sGrey1,
                            ),
                            CText(
                              text: '30 July, 2026',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(6),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightSize(12.5),),
              Container(
                // height: heightSize(81),
                padding: EdgeInsets.symmetric(horizontal: widthSize(15), vertical: heightSize(13)),
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
                          text: 'Auto Repayment',
                          size: 14,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wMedium,
                        ),
                        SizedBox(height: heightSize(5),),
                        SizedBox(
                          width: widthSize(263),
                          child: CText(
                            text: 'Repay loans automatically from main balance on the loan\'s due date.',
                            size: 12,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            height: heightSize(1.5),
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
              SizedBox(height: heightSize(44.5),),
              ActionButton(
                text: 'Take Loan',
                color: useAccent?accent:sActionButton,
                textColor: Colors.white,
                callback: () {
                  Get.toNamed(Routes.loanSummary);
                },
              ),
              SizedBox(height: heightSize(30),),
            ],
          );
        }),
      ),
    );
  }
}

class _SelectorBox extends StatelessWidget {
  final bool isDark;
  final bool isOpen;
  final String label;
  final bool isEmpty;
  final VoidCallback? onTap;

  const _SelectorBox({
    required this.isDark,
    required this.isOpen,
    required this.label,
    required this.isEmpty,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widthSize(15),
          vertical: heightSize(18),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Values().buttonRadius10),
          color: isDark ? sDarkFill : Colors.transparent,
          border: Border.all(
            color: isOpen ? sNavContainer : sDarkBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CText(
                text: label,
                size: 14,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: isEmpty || disabled
                    ? Colors.white38
                    : Colors.white,
              ),
            ),
            AnimatedRotation(
              turns: isOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 250),
              child: SvgPicture.asset(
                arrowDown,
                width: widthSize(20),
                height: heightSize(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final bool isDark;
  final String title;
  final Widget child;

  const _BottomSheet({
    required this.isDark,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(
        widthSize(20),
        heightSize(16),
        widthSize(20),
        heightSize(32),
      ),
      decoration: BoxDecoration(
        color: isDark ? sModalColor : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: widthSize(44),
              height: heightSize(4),
              margin: EdgeInsets.only(bottom: heightSize(16)),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Center(
            child: CText(
              text: title,
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
              color: Colors.white,
            ),
          ),
          SizedBox(height: heightSize(20)),
          child,
        ],
      ),
    );
  }
}