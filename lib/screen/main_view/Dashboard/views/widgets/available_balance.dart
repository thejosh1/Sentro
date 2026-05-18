import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final cardBg = isDark ? sContainerColor : colorScheme.surface;
    final pillBg = isDark ? sButtonFillDark : colorScheme.primary.withOpacity(0.08);
    final actionBg = isDark ? sButtonFillDark : colorScheme.primary;
    final actionFg = isDark ? colorScheme.onSurface : colorScheme.onPrimary;
    final historyBg = isDark ? sContainerColor : colorScheme.surface;

    return Padding(
      padding: EdgeInsets.only(bottom: heightSize(12)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // ── Card ──────────────────────────────────────────────
              Container(
                width: double.maxFinite,
                height: heightSize(196),
                padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius20),
                  color: cardBg,
                  boxShadow: isDark
                      ? null
                      : [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: heightSize(13)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          text: 'Available Balance',
                          size: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: CFONT.REGULAR,
                          color: isDark
                              ? sContainerTextDark
                              : colorScheme.onSurface.withOpacity(0.55),
                        ),
                        Container(
                          height: heightSize(31.97),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(83.34),
                            color: pillBg,
                            border: isDark
                                ? null
                                : Border.all(
                              color: colorScheme.primary.withOpacity(0.18),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: widthSize(10)),
                              Container(
                                width: widthSize(14.67),
                                height: heightSize(14.67),
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: SvgPicture.asset(nigeria),
                              ),
                              SizedBox(width: widthSize(3)),
                              SvgPicture.asset(
                                arrowDown,
                                width: widthSize(20),
                                height: heightSize(20),
                                colorFilter: ColorFilter.mode(
                                  isDark ? Colors.white : colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: widthSize(10)),
                              CText(
                                text: 'Kuda MFB - 9060007015',
                                size: 11.67,
                                fontFamily: CFONT.REGULAR,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? Colors.white
                                    : colorScheme.onSurface.withOpacity(0.75),
                              ),
                              SizedBox(width: widthSize(17.83)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize(22.32)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextNaira(
                          text: '0.00',
                          size: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : colorScheme.onSurface,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(token, width: widthSize(21), height: heightSize(21)),
                                SizedBox(width: widthSize(4)),
                                CText(
                                  text: '0.00',
                                  fontWeight: FontWeight.w400,
                                  size: 20,
                                  fontFamily: CFONT.REGULAR,
                                  color: isDark ? Colors.white : colorScheme.onSurface,
                                ),
                              ],
                            ),
                            CText(
                              text: 'Sentro Token',
                              size: 10,
                              fontStyle: FontStyle.italic,
                              color: isDark
                                  ? Colors.white54
                                  : colorScheme.onSurface.withOpacity(0.45),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize(21)),

                    // ── Transfer | Receive bar ────────────────────────
                    Container(
                      width: double.maxFinite,
                      height: heightSize(50),
                      padding: EdgeInsets.only(
                        left: widthSize(32),
                        right: widthSize(26.22),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Values().buttonRadius11 + 1),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.0, 1.0],
                          colors: [sBlue, sNavContainer],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ── Transfer ──────────────────────────────
                          _AnimatedTapRow(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.45),
                                builder: (context) {
                                  return Stack(
                                    children: [
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
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? sContainerColor
                                                : Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: heightSize(15)),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    _walletPill(),
                                                    _closeButton(),
                                                  ],
                                                ),
                                                SizedBox(height: heightSize(21)),
                                                CText(text: 'Send Money', size: 18, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM, height: 20 / 18),
                                                SizedBox(height: heightSize(2.5)),
                                                CText(text: 'Choose how you want to send money', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR, height: 20 / 14, color: sConfirmTextColor),
                                                SizedBox(height: heightSize(27.5)),
                                                _dialogItem(
                                                  icon: bank,
                                                  title: 'Other Banks',
                                                  subtitle: 'Send money to local and commercial banks',
                                                  onTap: () => Get.toNamed(
                                                    Routes.transfer,
                                                    arguments: {
                                                      'isSentroTag': false,
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: heightSize(10)),
                                                _dialogItem(
                                                  icon: sentro,
                                                  title: 'Sentro User (Sentro Tag)',
                                                  subtitle: 'Send money to users on Sentro, instant and free',
                                                  onTap: () => Get.toNamed(
                                                    Routes.transfer,
                                                    arguments: {
                                                      'isSentroTag': true,
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: heightSize(10)),
                                                _dialogItem(icon: qrPayWhite, title: 'QR Pay', subtitle: 'Send money by scanning QR Code', onTap: () => Get.toNamed(Routes.cableTV)),
                                                SizedBox(height: heightSize(15)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                CText(text: 'Transfer', fontFamily: CFONT.MEDIUM, fontWeight: FontWeight.w500, size: 18, color: actionFg),
                                SizedBox(width: widthSize(2.5)),
                                SvgPicture.asset(sendMoney, width: widthSize(24), height: heightSize(24)),
                              ],
                            ),
                          ),

                          VerticalDivider(
                            width: 34,
                            thickness: 2,
                            color: isDark ? sGrey : colorScheme.onPrimary.withOpacity(0.35),
                            indent: 8,
                            endIndent: 8,
                          ),

                          // ── Receive ───────────────────────────────
                          _AnimatedTapRow(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.45),
                                builder: (context) {
                                  return Stack(
                                    children: [
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
                                        width: double.maxFinite,
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height * 0.75,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                                        decoration: BoxDecoration(
                                          color: isDark ? sContainerColor : Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: heightSize(15)),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    _walletPill(),
                                                    _closeButton(),
                                                  ],
                                                ),
                                                SizedBox(height: heightSize(21)),
                                                CText(text: 'Receive Money', size: 18, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM, height: 20 / 18),
                                                SizedBox(height: heightSize(2.5)),
                                                CText(text: 'Choose how you want to receive money', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR, height: 20 / 14, color: sConfirmTextColor),
                                                SizedBox(height: heightSize(27.5)),
                                                _dialogItem(icon: sentro, title: 'Request from Sentro User', subtitle: 'Send money to users on Sentro, instant and free', onTap: () => Get.toNamed(Routes.requestFromSentro)),
                                                SizedBox(height: heightSize(10)),
                                                _dialogItem(icon: moneyReceive, title: 'Account Top-up', subtitle: 'Add money from other banks', onTap: () => Get.toNamed(Routes.betting)),
                                                SizedBox(height: heightSize(10)),
                                                _dialogItem(icon: qrPayWhite, title: 'QR Pay', subtitle: 'Share QR Code to receive money', onTap: () => Get.toNamed(Routes.cableTV)),
                                                SizedBox(height: heightSize(10)),
                                                _dialogItem(icon: coin, title: 'Stable Coins', subtitle: 'Receive money through stable coin transfer', onTap: () => Get.toNamed(Routes.cableTV)),
                                                SizedBox(height: heightSize(16)),
                                                CText(text: 'Account Details', size: 14, fontFamily: CFONT.MEDIUM, fontWeight: FontWeight.w500),
                                                CText(text: 'Receive money from all local banks', size: 12, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, height: 20/12, color: sConfirmTextColor,),
                                                SizedBox(height: heightSize(10),),
                                                Container(
                                                  width: double.maxFinite,
                                                  height: heightSize(95),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: sDarkFill,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CText(text: '0100100100', size: 14, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM, height: 16.67/14,),
                                                          CText(text: 'RICHMOND UCHE - Bowman MFB', size: 12, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR, height: 16.67/12, color: sAccountColor,)
                                                        ],
                                                      ),
                                                      SizedBox(width: widthSize(48),),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: widthSize(30),
                                                            height: heightSize(30),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: sNavContainer.withOpacity(0.1),
                                                            ),
                                                            child: Center(child: Image.asset(copy, width: widthSize(21.52), height: heightSize(21.52),)),
                                                          ),
                                                          SizedBox(width: widthSize(10),),
                                                          Container(
                                                            width: widthSize(30),
                                                            height: heightSize(30),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              color: sNavContainer.withOpacity(0.1),
                                                            ),
                                                            child: Center(child: Image.asset(share, width: widthSize(18), height: heightSize(18),)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: heightSize(21),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                CText(text: 'Receive', fontFamily: CFONT.MEDIUM, fontWeight: FontWeight.w500, size: 18, color: actionFg),
                                SizedBox(width: widthSize(2.5)),
                                SvgPicture.asset(receiveMoney, width: widthSize(24), height: heightSize(24)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ── Transaction History chip ───────────────────────────
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Get.toNamed(Routes.transactionHistory),
            child: Container(
              width: widthSize(145),
              height: heightSize(29),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Values().buttonRadius10+2),
                  bottomRight: Radius.circular(Values().buttonRadius10+2),
                ),
                color: historyBg,
                boxShadow: isDark
                    ? null
                    : [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    arrowDownCircle,
                    width: widthSize(19.5),
                    height: heightSize(19.5),
                  ),
                  SizedBox(width: widthSize(8)),
                  CText(
                    text: 'Transaction History',
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                    size: 12,
                    color: isDark ? Colors.white : colorScheme.primary,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // ── Shared dialog helpers ──────────────────────────────────────────────

  Widget _walletPill() {
    return Container(
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
                  style: TextStyle(fontSize: 15.86, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR, height: 22.65 / 15.86),
                ),
                TextSpan(
                  text: '.00',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR, height: 22.65 / 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
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
}

// ── Animated tap row ───────────────────────────────────────────────────────

class _AnimatedTapRow extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _AnimatedTapRow({required this.onTap, required this.child});

  @override
  State<_AnimatedTapRow> createState() => _AnimatedTapRowState();
}

class _AnimatedTapRowState extends State<_AnimatedTapRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.88 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _pressed ? 0.6 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: widget.child,
        ),
      ),
    );
  }
}