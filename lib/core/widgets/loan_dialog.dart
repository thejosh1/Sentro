// lib/core/utils/dialogs/mobile_topup_dialog.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/utils/balance_visibility_wrapper.dart';
import 'package:sentro/core/utils/label_container.dart';
import 'package:sentro/core/utils/text.dart';

import '../router/app_pages.dart';

void showLoanDialog({
  required BuildContext context,
  required bool isDark,
  bool initialDataSelected = false,
}) {
  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      bool _obscured = false;
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Stack(
              children: [
                // ── Blur + dark tint ──────────────────────────────
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
                Dialog(
                  backgroundColor: isDark
                      ? sContainerColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                  child: Container(
                    height: heightSize(634),
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                    decoration: BoxDecoration(
                      color: isDark
                          ? sContainerColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: heightSize(15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _BalancePill(
                                isDark: isDark,
                                useAccent: useAccent,
                                accent: accent,
                                obscured: _obscured,
                                onToggle: () => setDialogState(() => _obscured = !_obscured),
                                pillBg: isDark ? sButtonFillDark : const Color(0xFFEEEEEE),
                                pillBorder: isDark ? sDarkBorder : const Color(0xFFDDDDDD),
                                textColor: isDark ? Colors.white : sActionButton,
                              ),
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  width: widthSize(33.33),
                                  height: heightSize(33.33),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                  child: Center(child: SvgPicture.asset(cancelWhite)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: heightSize(13)),
                          CText(text: 'Loans', size: 18, fontWeight: CFONT.wBold, fontFamily: CFONT.FAMILY),
                          SizedBox(height: heightSize(13)),
                          CText(text: 'Take loans for your day to day', size: 14, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY),
                          SizedBox(height: heightSize(20)),
                          SizedBox(height: heightSize(40)),
                          _dialogItem(
                            useAccent: useAccent,
                            accent: accent,
                            isDark: isDark,
                            icon: takeLoan,
                            title: 'Take Loans',
                            subtitle: 'Send money to local and commercial banks',
                            onTap: () => Get.toNamed(Routes.takeLoan),
                          ),
                          SizedBox(height: heightSize(10)),
                          _dialogItem(
                            useAccent: useAccent,
                            accent: accent,
                            isDark: isDark,
                            icon: payLoan,
                            title: 'Repay Loans',
                            subtitle: 'Send money to users on Sentro, instant and free',
                            onTap: () => Get.toNamed(Routes.activeLoans),
                          ),
                          SizedBox(height: heightSize(10)),
                          _dialogItem(
                            isDark: isDark,
                            icon: calculator,
                            useAccent: useAccent,
                            accent: accent,
                            title: 'Loan Calculator',
                            subtitle: 'Send money by scanning QR Code',
                            onTap: () => Get.toNamed(Routes.loanCalculator),
                          ),
                          SizedBox(height: heightSize(14)),
                          CText(
                            text: 'Active Loans',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                          CText(
                            text: 'See how much loan you owe',
                            size: 12,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sConfirmTextColor,
                          ),
                          SizedBox(height: heightSize(10)),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.activeLoans);
                            },
                            child: _AnimatedLoanCard(
                              useAccent: useAccent,
                              accent: accent,
                              key: const ValueKey('loan_750'),
                              progress: 550000 / 750000, // 73% paid
                              loanAmount: 'Loans - N750,000',
                              remainingText: 'N550,000 to complete loan liquidation',
                            ),
                          ),
                          SizedBox(height: heightSize(10)),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.activeLoans);
                            },
                            child: _AnimatedLoanCard(
                              useAccent: useAccent,
                              accent: accent,
                              key: const ValueKey('loan_500'),
                              progress: 200000 / 500000, // 40% paid
                              loanAmount: 'Loans - N500,000',
                              remainingText: 'N300,000 to complete loan liquidation',
                            ),
                          ),
                          SizedBox(height: heightSize(27)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _dialogItem({
  required String icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  required bool isDark,
  bool useAccent = false,
  required Color accent,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      height: heightSize(70),
      padding: EdgeInsets.symmetric(horizontal: widthSize(12), vertical: heightSize(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark?sDarkFill:sLightFill,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: widthSize(46),
            height: heightSize(46),
            colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):ColorFilter.mode(sNavContainer, BlendMode.srcIn),
          ),
          SizedBox(width: widthSize(10)),
          Expanded(                               // ← add this
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(text: title, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 14),
                CText(
                  text: subtitle,
                  fontWeight: CFONT.wRegular,
                  size: 12,
                  fontFamily: CFONT.FAMILY,
                  color: const Color(0xFF979797),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _AnimatedLoanCard extends StatefulWidget {
  final double progress; // 0.0 - 1.0
  final String loanAmount;
  final String remainingText;
  final bool useAccent;
  final Color accent;

  const _AnimatedLoanCard({
    super.key,
    required this.progress,
    required this.loanAmount,
    required this.remainingText,
    this.useAccent = false,
    required this.accent,
  });

  @override
  State<_AnimatedLoanCard> createState() => _AnimatedLoanCardState();
}

class _AnimatedLoanCardState extends State<_AnimatedLoanCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize(73),
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: widthSize(8.13),
        top: heightSize(6.56),
        right: widthSize(16),
        bottom: heightSize(8),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.useAccent?widget.accent:sNavContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                loan2,
                width: widthSize(24),
                height: heightSize(24),
                colorFilter: const ColorFilter.mode(sActionButton, BlendMode.srcIn),
              ),
              SizedBox(width: widthSize(2.69)),
              CText(
                text: widget.loanAmount,
                size: 12,
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: heightSize(4)),
          CText(
            text: widget.remainingText,
            size: 12,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wRegular,
            color: Colors.black,
          ),
          SizedBox(height: heightSize(5)),
          AnimatedBuilder(
            animation: _anim,
            builder: (context, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _anim.value,
                  minHeight: heightSize(6.08),
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(sActionButton),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BalancePill extends StatelessWidget {
  final bool isDark;
  final bool obscured;
  final Color pillBg;
  final Color pillBorder;
  final Color textColor;
  final VoidCallback onToggle;
  final bool useAccent;
  final Color accent;

  const _BalancePill({
    required this.isDark,
    required this.obscured,
    required this.pillBg,
    required this.pillBorder,
    required this.textColor,
    required this.onToggle,
    this.useAccent = false,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize(31),
      padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(113.27),
        color: pillBg,
        border: Border.all(color: pillBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BalanceVisibility(
            builder: (obscured, toggleLocal) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  wallet,
                  width:  widthSize(18),
                  height: heightSize(18),
                  colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):ColorFilter.mode(
                    isDark ? sNavContainer : sActionButton,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: widthSize(4)),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: obscured
                      ? Text(
                    '••••••',
                    key: const ValueKey('hidden'),
                    style: TextStyle(
                      fontSize: fontSize(13),
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                      color: textColor,
                      letterSpacing: 2,
                    ),
                  )
                      : RichText(
                    key: const ValueKey('shown'),
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '₦50,000',
                          style: TextStyle(
                            inherit: false, // break font inheritance → ₦ renders
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: '.00',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widthSize(4)),
                GestureDetector(
                  onTap: onToggle,
                  child: SvgPicture.asset(
                    obscured ? visibilityOff : hide,
                    width: widthSize(18),
                    height: heightSize(18),
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white54 : Colors.black45,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}