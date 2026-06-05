import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/controllers/visibility_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/balance_visibility_wrapper.dart';
import 'package:sentro/core/utils/text.dart';

class AvailableBalance extends StatefulWidget {
  const AvailableBalance({super.key});

  @override
  State<AvailableBalance> createState() => _AvailableBalanceState();
}

class _AvailableBalanceState extends State<AvailableBalance> {
  bool _obscured = false;

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    final cardBg = isDark ? sContainerColor : sLightFill;
    final historyBg = isDark ? sContainerColor : sLightFill;
    final pillBg = isDark ? sButtonFillDark : colorScheme.primary.withOpacity(
        0.08);

    return Obx(() {
      final accent = AccentController.to.accent.value;
      final useAccent = !_isDefaultAccent(accent);
      return Padding(
        padding: EdgeInsets.only(bottom: heightSize(12)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // ── Card ──────────────────────────────────────────
                Container(
                  width: double.maxFinite,
                  height: heightSize(196),
                  padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(Values().buttonRadius20),
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
                      SizedBox(height: heightSize(10)),

                      // ── Top row ────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CText(
                                text: 'Available Bal',
                                size: 14,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: isDark
                                    ? sContainerTextDark
                                    : colorScheme.onSurface.withOpacity(0.55),
                              ),
                              SizedBox(width: widthSize(5),),
                              GestureDetector(
                                onTap: () => VisibilityController.to.toggle(),
                                child: Obx(() =>
                                    SvgPicture.asset(
                                      VisibilityController.to.isObscured.value
                                          ? visibilityOff
                                          : visIcon,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                    )),
                              ),
                            ],
                          ),
                          // Account pill
                          Container(
                            //width: widthSize(200),
                            height: heightSize(31.97),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(83.34),
                              color: pillBg,
                              border: isDark
                                  ? null
                                  : Border.all(
                                color: colorScheme.primary
                                    .withOpacity(0.18),
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
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(nigeria),
                                ),
                                SizedBox(width: widthSize(3)),
                                SvgPicture.asset(
                                  arrowDown,
                                  width: widthSize(20),
                                  height: heightSize(20),
                                  colorFilter: ColorFilter.mode(
                                    isDark
                                        ? Colors.white
                                        : colorScheme.onSurface,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: widthSize(10)),
                                CText(
                                  text: 'Kuda MFB - 9060007015',
                                  size: 11.67,
                                  fontWeight: CFONT.wRegular,
                                  fontFamily: CFONT.FAMILY,
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

                      SizedBox(height: heightSize(14.78)),

                      // ── Balance + Token row ────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Balance with visibility toggle
                          GestureDetector(
                            onTap: () =>
                                setState(() => _obscured = !_obscured),
                            child: Obx(() {
                              final obscured = VisibilityController.to
                                  .isObscured.value;
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: obscured
                                    ? Text(
                                  '••••••',
                                  key: const ValueKey('hidden'),
                                  style: TextStyle(
                                    fontSize: fontSize(30.11),
                                    fontFamily: CFONT.FAMILY,
                                    fontWeight: CFONT.wBold,
                                    color: isDark
                                        ? Colors.white
                                        : colorScheme.onSurface,
                                    letterSpacing: 4,
                                  ),
                                )
                                    : TextNaira(
                                  key: const ValueKey('shown'),
                                  text: '0.00',
                                  size: 30.11,
                                  nairaColor: isDark
                                      ? sNavContainer
                                      : sActionButton,
                                  fontWeight: CFONT.wBold,
                                  color: isDark
                                      ? Colors.white
                                      : colorScheme.onSurface,
                                ),
                              );
                            }),
                          ),
                          // Token
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    token,
                                    width: widthSize(21),
                                    height: heightSize(21),
                                  ),
                                  SizedBox(width: widthSize(4)),
                                  CText(
                                    text: '0.00',
                                    size: 20,
                                    fontWeight: CFONT.wRegular,
                                    fontFamily: CFONT.FAMILY,
                                    color: isDark
                                        ? Colors.white
                                        : colorScheme.onSurface,
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

                      Spacer(),

                      // ── Transfer | Receive bar ────────────────
                      Container(
                        width: double.maxFinite,
                        height: heightSize(50),
                        padding: EdgeInsets.only(
                          //left:  widthSize(32),
                          //right: widthSize(26.22),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Values().buttonRadius11 + 1,
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.0, 1.0],
                            colors: [sBlue, sNavContainer],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Transfer
                            Expanded(
                              child: _AnimatedTapRow(
                                onTap: () =>
                                    _showTransferDialog(
                                      context,
                                      isDark,
                                      colorScheme,
                                      useAccent,
                                      accent,
                                    ),
                                child: Row(
                                  children: [
                                    SizedBox(width: widthSize(40),),
                                    CText(
                                      text: 'Transfer',
                                      fontWeight: CFONT.wMedium,
                                      fontFamily: CFONT.FAMILY,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: widthSize(2.5)),
                                    SvgPicture.asset(
                                      sendMoney,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            VerticalDivider(
                              width: 34,
                              thickness: 2,
                              color: Colors.white.withOpacity(0.4),
                              indent: 8,
                              endIndent: 8,
                            ),

                            // Receive
                            Expanded(
                              child: _AnimatedTapRow(
                                onTap: () =>
                                    _showReceiveDialog(
                                      context,
                                      isDark,
                                      colorScheme,
                                      useAccent,
                                      accent,
                                    ),
                                child: Row(
                                  children: [
                                    SizedBox(width: widthSize(25.5),),
                                    CText(
                                      text: 'Receive',
                                      fontWeight: CFONT.wMedium,
                                      fontFamily: CFONT.FAMILY,
                                      size: 18,
                                      color: sActionButton,
                                    ),
                                    SizedBox(width: widthSize(2.5)),
                                    SvgPicture.asset(
                                      receiveMoney,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: heightSize(15)),
                    ],
                  ),
                ),
              ],
            ),

            // ── Transaction History chip ─────────────────────────
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Get.toNamed(Routes.transactionHistory),
              child: Container(
                width: widthSize(148),
                height: heightSize(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Values().buttonRadius10 + 2),
                    bottomRight: Radius.circular(Values().buttonRadius10 + 2),
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
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      size: 12,
                      color: isDark ? Colors.white : colorScheme.primary,
                    ),
                    SizedBox(width: widthSize(2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ── Transfer dialog ──────────────────────────────────────────────────────────

  void _showTransferDialog(BuildContext context,
      bool isDark,
      ColorScheme colorScheme, bool useAccent, Color accent) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) =>
          _MoneyDialog(
            isDark: isDark,
            useAccent: useAccent,
            accent: accent,
            colorScheme: colorScheme,
            title: 'Send Money',
            subtitle: 'Choose how you want to send money',
            items: [
              _DialogItemData(
                icon: bank,
                useAccent: useAccent,
                accent: accent,
                title: 'Other Banks',
                subtitle: 'Send money to local and commercial banks',
                onTap: () =>
                    Get.toNamed(
                      Routes.transfer,
                      arguments: {'isSentroTag': false},
                    ),
              ),
              _DialogItemData(
                icon: sentro,
                useAccent: useAccent,
                accent: accent,
                title: 'Sentro User (Sentro Tag)',
                subtitle: 'Send money to users on Sentro, instant and free',
                onTap: () =>
                    Get.toNamed(
                      Routes.transfer,
                      arguments: {'isSentroTag': true},
                    ),
              ),
              _DialogItemData(
                icon: qrPayWhite,
                useAccent: useAccent,
                accent: accent,
                title: 'QR Pay',
                subtitle: 'Send money by scanning QR Code',
                onTap: () => Get.toNamed(Routes.qrPay),
              ),
            ],
          ),
    );
  }

  // ── Receive dialog ───────────────────────────────────────────────────────────

  void _showReceiveDialog(BuildContext context,
      bool isDark,
      ColorScheme colorScheme, bool useAccent, Color accent,) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (ctx) =>
          _MoneyDialog(
            isDark: isDark,
            useAccent: useAccent,
            accent: accent,
            colorScheme: colorScheme,
            title: 'Receive Money',
            subtitle: 'Choose how you want to receive money',
            items: [
              _DialogItemData(
                icon: sentro,
                useAccent: useAccent,
                accent: accent,
                title: 'Request from Sentro User',
                subtitle: 'Send money to users on Sentro, instant and free',
                onTap: () => Get.toNamed(Routes.requestFromSentro),
              ),
              _DialogItemData(
                icon: moneyReceive,
                useAccent: useAccent,
                accent: accent,
                title: 'Account Top-up',
                subtitle: 'Add money from other banks',
                onTap: () {},
              ),
              _DialogItemData(
                icon: qrPayWhite,
                useAccent: useAccent,
                accent: accent,
                title: 'QR Pay',
                subtitle: 'Share QR Code to receive money',
                onTap: () => Get.toNamed(Routes.qrPay),
              ),
              _DialogItemData(
                icon: coin,
                useAccent: useAccent,
                accent: accent,
                title: 'Stable Coins',
                subtitle: 'Receive money through stable coin transfer',
                onTap: () {},
              ),
            ],
            footer: _AccountDetailsCard(isDark: isDark, useAccent: useAccent, accent: accent,),
          ),
    );
  }
}

// ── Reusable money dialog ─────────────────────────────────────────────────────

class _DialogItemData {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool useAccent;
  final Color accent;

  const _DialogItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.accent,
    this.useAccent = false,
  });
}

class _MoneyDialog extends StatefulWidget {
  final bool isDark;
  final ColorScheme colorScheme;
  final String title;
  final String subtitle;
  final List<_DialogItemData> items;
  final Widget? footer;
  final bool useAccent;
  final Color accent;

  const _MoneyDialog({
    required this.isDark,
    required this.colorScheme,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.accent,
    this.useAccent = false,
    this.footer,
  });

  @override
  State<_MoneyDialog> createState() => _MoneyDialogState();
}

class _MoneyDialogState extends State<_MoneyDialog> {
  bool _obscured = false;

  Color get _dialogBg =>
      widget.isDark ? sContainerColor : Colors.white;

  Color get _itemBg =>
      widget.isDark ? sDarkFill : const Color(0xFFF5F5F5);

  Color get _titleColor =>
      widget.isDark ? Colors.white : sActionButton;

  Color get _subtitleColor =>
      widget.isDark ? sAccountColor : sLightModeMutedText;

  Color get _pillBg =>
      widget.isDark ? sButtonFillDark : const Color(0xFFEEEEEE);

  Color get _pillBorder =>
      widget.isDark ? sDarkBorder : const Color(0xFFDDDDDD);

  Color get _closeBg =>
      widget.isDark
          ? Colors.white.withOpacity(0.10)
          : Colors.black.withOpacity(0.06);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _dialogBg,
      insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: MediaQuery
              .of(context)
              .size
              .height * 0.85,
        ),
        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
        decoration: BoxDecoration(
          color: _dialogBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: heightSize(15)),

              // ── Top bar ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Balance pill
                  Container(
                    height: heightSize(31),
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(113.27),
                      color: _pillBg,
                      border: Border.all(color: _pillBorder),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BalanceVisibility(
                          builder: (obscured, toggleLocal) =>
                              Row( // 👈 obscured comes from here
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    wallet,
                                    width: widthSize(18),
                                    height: heightSize(18),
                                    colorFilter: widget.useAccent
                                        ? ColorFilter.mode(
                                        widget.accent, BlendMode.srcIn)
                                        : ColorFilter.mode(
                                      widget.isDark
                                          ? sNavContainer
                                          : sActionButton,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: widthSize(4)),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: obscured // 👈 was _obscured, now uses builder param
                                        ? Text(
                                      '••••••',
                                      key: const ValueKey('h'),
                                      style: TextStyle(
                                        fontSize: fontSize(13),
                                        fontFamily: CFONT.FAMILY,
                                        fontWeight: CFONT.wRegular,
                                        color: _titleColor,
                                        letterSpacing: 2,
                                      ),
                                    )
                                        : RichText(
                                      key: const ValueKey('s'),
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '₦50,000',
                                            style: TextStyle(
                                              inherit: false,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: _titleColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '.00',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontFamily: CFONT.FAMILY,
                                              fontWeight: CFONT.wRegular,
                                              color: _titleColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: widthSize(4)),
                                  GestureDetector(
                                    onTap: toggleLocal,
                                    // 👈 was setState(() => _obscured = !_obscured)
                                    child: SvgPicture.asset(
                                      obscured ? visibilityOff : hide,
                                      // 👈 was _obscured
                                      width: widthSize(18),
                                      height: heightSize(18),
                                      colorFilter: ColorFilter.mode(
                                        widget.isDark ? Colors.white54 : Colors
                                            .black45,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Close button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: widthSize(33),
                      height: heightSize(33),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _closeBg,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          cancelWhite,
                          width: widthSize(14),
                          height: heightSize(14),
                          colorFilter: ColorFilter.mode(
                            widget.isDark ? Colors.white : Colors.black87,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: heightSize(21)),

              CText(
                text: widget.title,
                size: 18,
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                color: _titleColor,
                height: 20 / 18,
              ),
              SizedBox(height: heightSize(2.5)),
              CText(
                text: widget.subtitle,
                size: 14,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: _subtitleColor,
                height: 20 / 14,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: heightSize(20)),

              // ── Items ────────────────────────────────────────
              ...widget.items.map((item) =>
                  Padding(
                    padding: EdgeInsets.only(bottom: heightSize(10)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        item.onTap();
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: heightSize(70),
                        padding: EdgeInsets.symmetric(
                          horizontal: widthSize(12),
                          vertical: heightSize(12),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _itemBg,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              item.icon,
                              width: widthSize(46),
                              height: heightSize(46),
                              colorFilter: widget.useAccent?ColorFilter.mode(widget.accent, BlendMode.srcIn): ColorFilter.mode(
                                sNavContainer,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: widthSize(10)),
                            // ← Expanded fixes the overflow
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  CText(
                                    text: item.title,
                                    fontWeight: CFONT.wMedium,
                                    fontFamily: CFONT.FAMILY,
                                    size: 14,
                                    color: _titleColor,
                                  ),
                                  CText(
                                    text: item.subtitle,
                                    fontWeight: CFONT.wRegular,
                                    fontFamily: CFONT.FAMILY,
                                    size: 12,
                                    color: _subtitleColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),

              // ── Optional footer (account details etc.) ───────
              if (widget.footer != null) ...[
                widget.footer!,
                SizedBox(height: heightSize(16)),
              ] else
                SizedBox(height: heightSize(6)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Account details card (receive dialog footer) ──────────────────────────────

class _AccountDetailsCard extends StatelessWidget {
  final bool isDark;
  final bool useAccent;
  final Color accent;

  const _AccountDetailsCard({required this.isDark, this.useAccent = false,  required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          text: 'Account Details',
          size: 14,
          fontWeight: CFONT.wMedium,
          fontFamily: CFONT.FAMILY,
          color: isDark ? Colors.white : sActionButton,
        ),
        SizedBox(height: heightSize(2)),
        CText(
          text: 'Receive money from all local banks',
          size: 12,
          fontWeight: CFONT.wRegular,
          fontFamily: CFONT.FAMILY,
          color: isDark ? sConfirmTextColor : sLightModeMutedText,
          height: 20 / 12,
        ),
        SizedBox(height: heightSize(10)),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: widthSize(16),
            vertical: heightSize(16),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDark ? sDarkFill : const Color(0xFFF5F5F5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: '0100100100',
                      size: 14,
                      fontWeight: CFONT.wMedium,
                      fontFamily: CFONT.FAMILY,
                      color: isDark ? Colors.white : sActionButton,
                      height: 16.67 / 14,
                    ),
                    CText(
                      text: 'RICHMOND UCHE — Bowman MFB',
                      size: 12,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      color: isDark ? sAccountColor : sLightModeMutedText,
                      height: 16.67 / 12,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _iconBtn(copy, isDark, useAccent, accent),
                  SizedBox(width: widthSize(10)),
                  _iconBtn(share, isDark, useAccent, accent),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconBtn(String asset, bool isDark, bool useAccent, Color accent) {
    return Center(
      child: SvgPicture.asset(
        asset,
        width: widthSize(30),
        height: heightSize(30),
        colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):ColorFilter.mode(sNavContainer, BlendMode.srcIn),
      ),
    );
  }
}

// ── Animated tap row ──────────────────────────────────────────────────────────

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