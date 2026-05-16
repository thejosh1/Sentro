import 'dart:developer';

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

    // ── Derived colors ──────────────────────────────────────────
    //
    // cardBg      — the balance card surface
    // pillBg      — the "Kuda MFB" account selector pill
    // actionBg    — the Transfer / Receive button bar
    // historyBg   — the Transaction History chip below
    //
    // Dark keeps the existing custom colours; Light uses AppTheme tokens.

    final cardBg = isDark ? sContainerColor : colorScheme.surface;

    // Light: very faint primary tint so the pill reads on the card
    final pillBg = isDark
        ? sButtonFillDark
        : colorScheme.primary.withOpacity(0.08);

    // Light: solid primary (dark forest green) — strong CTA feel
    final actionBg = isDark ? sButtonFillDark : colorScheme.primary;

    // Transfer / Receive text + icon colour
    final actionFg = isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    final historyBg = isDark ? sContainerColor : colorScheme.surface;

    return Padding(
      padding: EdgeInsets.only(bottom: heightSize(36.5)),
      child: Stack(
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
                            SvgPicture.asset(
                              token,
                              width: widthSize(21),
                              height: heightSize(21),
                            ),
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
                      Row(
                        children: [
                          CText(
                            text: 'Transfer',
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                            size: 18,
                            color: actionFg,
                          ),
                          SizedBox(width: widthSize(2.5)),
                          SvgPicture.asset(
                            sendMoney,
                            width: widthSize(24),
                            height: heightSize(24),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: 34,
                        thickness: 2,
                        color: isDark
                            ? sGrey
                            : colorScheme.onPrimary.withOpacity(0.35),
                        indent: 8,
                        endIndent: 8,
                      ),
                      Row(
                        children: [
                          CText(
                            text: 'Receive',
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                            size: 18,
                            color: actionFg,
                          ),
                          SizedBox(width: widthSize(2.5)),
                          SvgPicture.asset(
                            receiveMoney,
                            width: widthSize(24),
                            height: heightSize(24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Transaction History chip — now INSIDE Stack bounds ───
          Positioned(
            bottom: heightSize(-12), // visually same spot, within Stack bounds
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.transactionHistory),
              child: Container(
                width: widthSize(145),
                height: heightSize(29),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Values().buttonRadius10),
                    bottomRight: Radius.circular(Values().buttonRadius10),
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
                    SvgPicture.asset(arrowDownCircle),
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
            ),
          ),
        ],
      ),
    );
  }
}