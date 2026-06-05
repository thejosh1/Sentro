import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/utils/balance_visibility_wrapper.dart';
import 'package:sentro/core/utils/text.dart';

class BalancePill extends StatelessWidget {
  final bool isDark;
  final String? balance;
  final bool showWallet;

  const BalancePill({
    super.key,
    required this.isDark,
    this.balance,
    this.showWallet = true,
  });

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : sActionButton;
    final pillBg = isDark ? sButtonFillDark : const Color(0xFFEEEEEE);
    final pillBorder = isDark ? sDarkBorder : const Color(0xFFDDDDDD);

    // Backward-compatible fallback parsing engine
    String mainBalance = balance ?? '₦50,000';
    String decimalPart = balance != null ? '' : '.00';

    if (balance != null && balance!.contains('.')) {
      final parts = balance!.split('.');
      mainBalance = parts[0];
      decimalPart = '.${parts[1]}';
    }

    return BalanceVisibility(
      builder: (obscured, toggleLocal) {
        return Container(
          height: heightSize(34),
          padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(113.27),
            color: pillBg,
            border: Border.all(color: pillBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Scoped Obx targeting only the wallet icon
              if (showWallet) ...[
                Obx(() {
                  final accent = AccentController.to.accent.value;
                  final useAccent = !_isDefaultAccent(accent);
                  return SvgPicture.asset(
                    wallet,
                    width: widthSize(18),
                    height: heightSize(18),
                    colorFilter: useAccent
                        ? ColorFilter.mode(accent, BlendMode.srcIn)
                        : ColorFilter.mode(
                      isDark ? sNavContainer : sActionButton,
                      BlendMode.srcIn,
                    ),
                  );
                }),
                SizedBox(width: widthSize(4)),
              ],

              // 2. Main Balance Layout Engine
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: obscured
                    ? Text(
                  '••••••',
                  key: const ValueKey('h'),
                  style: TextStyle(
                    fontSize: fontSize(13),
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: textColor,
                    letterSpacing: 2,
                  ),
                )
                    : RichText(
                  key: const ValueKey('s'),
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: mainBalance,
                        style: TextStyle(
                          inherit: false,
                          fontSize: 13,
                          //fontFamily: CFONT.FAMILY,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      if (decimalPart.isNotEmpty)
                        TextSpan(
                          text: decimalPart,
                          style: TextStyle(
                            fontSize: 9,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: textColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: widthSize(4)),

              // 3. Visibility Toggle
              GestureDetector(
                onTap: toggleLocal,
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
        );
      },
    );
  }
}