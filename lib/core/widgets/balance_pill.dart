import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/balance_visibility_wrapper.dart';
import 'package:sentro/core/utils/text.dart';

class BalancePill extends StatelessWidget {
  final bool isDark;
  const BalancePill({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final textColor  = isDark ? Colors.white : sActionButton;
    final pillBg     = isDark ? sButtonFillDark : const Color(0xFFEEEEEE);
    final pillBorder = isDark ? sDarkBorder : const Color(0xFFDDDDDD);

    return BalanceVisibility(
      builder: (obscured, toggleLocal) => Container(
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
            SvgPicture.asset(wallet, width: widthSize(18), height: heightSize(18),
              colorFilter: ColorFilter.mode(
                isDark ? sNavContainer : sActionButton, BlendMode.srcIn,
              ),
            ),
            SizedBox(width: widthSize(4)),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: obscured
                  ? Text('••••••', key: const ValueKey('h'),
                  style: TextStyle(fontSize: fontSize(13), fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular, color: textColor, letterSpacing: 2))
                  : RichText(key: const ValueKey('s'),
                  text: TextSpan(children: [
                    TextSpan(text: '₦50,000',
                        style: TextStyle(inherit: false, fontSize: 13,
                            fontWeight: FontWeight.w400, color: textColor)),
                    TextSpan(text: '.00',
                        style: TextStyle(fontSize: 9, fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular, color: textColor)),
                  ])),
            ),
            SizedBox(width: widthSize(4)),
            GestureDetector(
              onTap: toggleLocal,   // 👈 local only
              child: SvgPicture.asset(
                obscured ? visibilityOff : hide,
                width: widthSize(18), height: heightSize(18),
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white54 : Colors.black45, BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}