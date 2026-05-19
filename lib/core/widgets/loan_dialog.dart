// lib/core/utils/dialogs/mobile_topup_dialog.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/label_container.dart';
import 'package:sentro/core/utils/text.dart';

import '../router/app_pages.dart';

void showLoanDialog({
  required BuildContext context,
  required bool isDark,
  bool initialDataSelected = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (context) {
      bool isDataSelected = initialDataSelected;

      return StatefulBuilder(
        builder: (context, setDialogState) {
          return Stack(
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
                            Container(
                              width: widthSize(156.8),
                              height: heightSize(31),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(113.27),
                                color: sButtonFillDark,
                                border: Border.all(color: sDarkBorder),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(wallet, width: widthSize(24), height: heightSize(24)),
                                  SizedBox(width: widthSize(3.4)),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '₦50,000',
                                          style: TextStyle(
                                            fontSize: 15.86,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: CFONT.REGULAR,
                                            height: 22.65 / 15.86,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '.00',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: CFONT.REGULAR,
                                            height: 22.65 / 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(visibilityOff, width: widthSize(24), height: heightSize(24)),
                                ],
                              ),
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
                        CText(text: 'Loans', size: 18, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM),
                        SizedBox(height: heightSize(13)),
                        CText(text: 'Take loans for your day to day', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR),
                        SizedBox(height: heightSize(20)),
                        SizedBox(height: heightSize(40)),
                        _dialogItem(
                          icon: takeLoan,
                          title: 'Take Loans',
                          subtitle: 'Send money to local and commercial banks',
                          onTap: () => Get.toNamed(Routes.takeLoan),
                        ),
                        SizedBox(height: heightSize(10)),
                        _dialogItem(
                          icon: payLoan,
                          title: 'Repay Loans',
                          subtitle: 'Send money to users on Sentro, instant and free',
                          onTap: () => Get.toNamed(Routes.activeLoans),
                        ),
                        SizedBox(height: heightSize(10)),
                        _dialogItem(
                          icon: calculator,
                          title: 'Loan Calculator',
                          subtitle: 'Send money by scanning QR Code',
                          onTap: () => Get.toNamed(Routes.loanCalculator),
                        ),
                        SizedBox(height: heightSize(34)),
                        CText(
                          text: 'Active Loans',
                          size: 14,
                          fontFamily: CFONT.MEDIUM,
                          fontWeight: FontWeight.w500,
                        ),
                        CText(
                          text: 'See how much loan you owe',
                          size: 12,
                          fontFamily: CFONT.REGULAR,
                          fontWeight: FontWeight.w400,
                          color: sConfirmTextColor,
                        ),
                        SizedBox(height: heightSize(10)),
                        _AnimatedLoanCard(
                          progress: 550000 / 750000, // 73% paid
                          loanAmount: 'Loans - N750,000',
                          remainingText: 'N550,000 to complete loan liquidation',
                        ),
                        SizedBox(height: heightSize(10)),
                        _AnimatedLoanCard(
                          progress: 200000 / 500000, // 40% paid
                          loanAmount: 'Loans - N500,000',
                          remainingText: 'N300,000 to complete loan liquidation',
                        ),
                        SizedBox(height: heightSize(27)),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      height: heightSize(70),
      padding: EdgeInsets.symmetric(horizontal: widthSize(12), vertical: heightSize(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: sDarkFill,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: widthSize(46),
            height: heightSize(46),
            colorFilter: ColorFilter.mode(sNavContainer, BlendMode.srcIn),
          ),
          SizedBox(width: widthSize(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CText(text: title, fontFamily: CFONT.MEDIUM, fontWeight: FontWeight.w500, size: 14),
              CText(text: subtitle, fontWeight: FontWeight.w400, size: 12, fontFamily: CFONT.REGULAR, color: const Color(0xFF979797)),
            ],
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

  const _AnimatedLoanCard({
    required this.progress,
    required this.loanAmount,
    required this.remainingText,
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
        color: sNavContainer,
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
                fontWeight: FontWeight.w500,
                fontFamily: CFONT.MEDIUM,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(height: heightSize(4)),
          CText(
            text: widget.remainingText,
            size: 12,
            fontFamily: CFONT.REGULAR,
            fontWeight: FontWeight.w400,
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