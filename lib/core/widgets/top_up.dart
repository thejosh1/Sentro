// lib/core/widgets/top_up.dart

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

void showMobileTopupDialog({
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
      bool isDataSelected = initialDataSelected;
      bool isBalanceObscured = false;
      final accent = AccentController.to.accent.value;
      final useAccent = !_isDefaultAccent(accent);

      return StatefulBuilder(
        builder: (context, setDialogState) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Stack(
              children: [
                // ── Blur + dark tint ──────────────────────────
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),

                Dialog(
                  backgroundColor: isDark
                      ? sContainerColor
                      : Theme.of(context).colorScheme.surface,
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: widthSize(20),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GestureDetector(
                    // prevent taps inside from closing
                    onTap: () {},
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: widthSize(15),
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? sContainerColor
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: heightSize(15)),

                            // ── Top bar ──────────────────────
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                // Balance pill
                                // Balance pill
                                Container(
                                  height: heightSize(31),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widthSize(10),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(113.27),
                                    color: isDark ? sButtonFillDark : Colors.grey.shade100,
                                    border: Border.all(
                                      color: isDark ? sDarkBorder : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: BalanceVisibility(
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
                                          child: obscured                      // 👈 builder param
                                              ? Text(
                                            '••••••',
                                            key: const ValueKey('hidden'),
                                            style: TextStyle(
                                              fontSize: fontSize(13),
                                              fontFamily: CFONT.FAMILY,
                                              fontWeight: CFONT.wRegular,
                                              color: isDark ? Colors.white : Colors.black,
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
                                                    fontSize: 13,
                                                    fontWeight: CFONT.wRegular,
                                                    fontFamily: null,
                                                    color: isDark ? Colors.white : Colors.black,
                                                    height: 22.65 / 15.86,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '.00',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight: CFONT.wRegular,
                                                    fontFamily: CFONT.FAMILY,
                                                    color: isDark ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: widthSize(4)),
                                        GestureDetector(
                                          onTap: toggleLocal,                  // 👈 local temporary toggle
                                          child: SvgPicture.asset(
                                            obscured ? visibilityOff : hide,   // 👈 builder param
                                            width:  widthSize(18),
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
                                ),

                                // Close button
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    width: widthSize(33),
                                    height: heightSize(33),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? Colors.white.withOpacity(0.1)
                                          : Colors.black.withOpacity(0.06),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        cancelWhite,
                                        width: widthSize(14),
                                        height: heightSize(14),
                                        colorFilter: ColorFilter.mode(
                                          isDark
                                              ? Colors.white
                                              : Colors.black87,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: heightSize(13)),

                            CText(
                              text: 'Mobile Top up',
                              size: 18,
                              fontWeight: CFONT.wMedium,
                              fontFamily: CFONT.FAMILY,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            SizedBox(height: heightSize(4)),
                            CText(
                              text: 'Top up your Airtime and Data',
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: isDark
                                  ? Colors.white54
                                  : Colors.black54,
                            ),

                            SizedBox(height: heightSize(20)),

                            // ── Airtime / Data tab ────────────
                            Container(
                              width: widthSize(214),
                              height: heightSize(55),
                              padding: EdgeInsets.symmetric(
                                horizontal: widthSize(6),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: isDark
                                    ? sDescriptionColor
                                    : Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setDialogState(
                                              () => isDataSelected = false),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        height: heightSize(43),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          color: !isDataSelected
                                              ? sActiveColor
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              phone,
                                              width: widthSize(18),
                                              height: heightSize(18),
                                              colorFilter: ColorFilter.mode(
                                                !isDataSelected
                                                    ? useAccent?accent:sNavContainer
                                                    : (isDark
                                                    ? Colors.white70
                                                    : Colors.black54),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: widthSize(6)),
                                            CText(
                                              text: 'Airtime',
                                              fontFamily: CFONT.FAMILY,
                                              fontWeight: CFONT.wRegular,
                                              size: 14,
                                              color: !isDataSelected
                                                  ? useAccent?accent:sNavContainer
                                                  : (isDark
                                                  ? Colors.white
                                                  : Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setDialogState(
                                              () => isDataSelected = true),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        height: heightSize(43),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          color: isDataSelected
                                              ? sActiveColor
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              dataTopUp,
                                              width: widthSize(18),
                                              height: heightSize(18),
                                              colorFilter: ColorFilter.mode(
                                                isDataSelected
                                                    ? useAccent?accent:sNavContainer
                                                    : (isDark
                                                    ? Colors.white70
                                                    : Colors.black54),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: widthSize(6)),
                                            CText(
                                              text: 'Data',
                                              fontWeight: CFONT.wRegular,
                                              fontFamily: CFONT.FAMILY,
                                              size: 14,
                                              color: isDataSelected
                                                  ? useAccent?accent:sNavContainer
                                                  : (isDark
                                                  ? Colors.white
                                                  : Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: heightSize(24)),

                            LabelContainer(isData: isDataSelected),

                            SizedBox(height: heightSize(20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}