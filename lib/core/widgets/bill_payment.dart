// Drop-in replacement for the showDialog call — extract into a function:
// void showBillPaymentDialog({required BuildContext context, required bool isDark})

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';

void showBillPaymentDialog({
  required BuildContext context,
  required bool isDark,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (context) => _BillPaymentDialog(isDark: isDark),
  );
}

// ── Stateful dialog widget — avoids state reset bug of StatefulBuilder ─────────

class _BillPaymentDialog extends StatefulWidget {
  final bool isDark;
  const _BillPaymentDialog({required this.isDark});

  @override
  State<_BillPaymentDialog> createState() => _BillPaymentDialogState();
}

class _BillPaymentDialogState extends State<_BillPaymentDialog> {

  // ── Derived colors ──────────────────────────────────────────────────────────

  Color get _dialogBg => widget.isDark
      ? sContainerColor
      : Colors.white;

  Color get _itemBg => widget.isDark
      ? sDarkFill
      : const Color(0xFFF7F7F7);

  Color get _subtitleColor => widget.isDark
      ? sAccountColor
      : sLightModeMutedText;

  Color get _bodyText => widget.isDark
      ? Colors.white
      : sActionButton;

  Color get _mutedText => widget.isDark
      ? sConfirmTextColor
      : sLightModeMutedText;



  Color get _closeBg => widget.isDark
      ? Colors.white.withOpacity(0.10)
      : Colors.black.withOpacity(0.06);

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: _dialogBg,
      insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
        decoration: BoxDecoration(
          color: _dialogBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightSize(15)),

              // ── Top bar ─────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BalancePill(isDark: isDark),
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

              SizedBox(height: heightSize(20)),

              // ── Title ───────────────────────────────────────
              Center(
                child: CText(
                  text: 'Bill Payment',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  color: _bodyText,
                  height: 20 / 18,
                ),
              ),
              SizedBox(height: heightSize(4)),
              Center(
                child: CText(
                  text: 'Pay for all types of utility bills easy and quick',
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: _mutedText,
                  textAlign: TextAlign.center,
                  height: 20 / 14,
                ),
              ),

              SizedBox(height: heightSize(24)),

              // ── Bill items ──────────────────────────────────
              ..._items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: heightSize(10)),
                child: _BillItem(
                  icon: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                  bg: _itemBg,
                  titleColor: _bodyText,
                  subtitleColor: _subtitleColor,
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed(item.route);
                  },
                ),
              )),

              SizedBox(height: heightSize(16)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bill item data ─────────────────────────────────────────────────────────────

class _ItemData {
  final String icon;
  final String title;
  final String subtitle;
  final String route;
  const _ItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}

final _items = [
  _ItemData(
    icon: electricity,
    title: 'Electricity',
    subtitle: 'Keep your lights on, buy light token',
    route: Routes.electricity,
  ),
  _ItemData(
    icon: betting,
    title: 'Betting',
    subtitle: 'Bet your best, fund your betting wallet',
    route: Routes.betting,
  ),
  _ItemData(
    icon: devices,
    title: 'Cable TV',
    subtitle: 'Subscribe for DSTV, GOTV, Startimes etc.',
    route: Routes.cableTV,
  ),
  _ItemData(
    icon: teacher,
    title: 'Academics',
    subtitle: 'Pay for JAMB, WAEC, NECO and more',
    route: Routes.academics,
  ),
  _ItemData(
    icon: trash,
    title: 'Waste Management',
    subtitle: 'Pay for your waste to the right management',
    route: Routes.wastemanagent,
  ),
  _ItemData(
    icon: globalSearch,
    title: 'Internet Provider',
    subtitle: 'Pay for your preferred internet service provider',
    route: Routes.internetService,
  ),
];

// ── Bill item widget ───────────────────────────────────────────────────────────

class _BillItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final Color bg;
  final Color titleColor;
  final Color subtitleColor;
  final VoidCallback onTap;

  const _BillItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.bg,
    required this.titleColor,
    required this.subtitleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: heightSize(70),
        padding: EdgeInsets.symmetric(
          horizontal: widthSize(12),
          vertical: heightSize(12),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bg,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: widthSize(46),
              height: heightSize(46),
              colorFilter: const ColorFilter.mode(
                sNavContainer,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: widthSize(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    text: title,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wMedium,
                    size: 14,
                    color: titleColor,
                  ),
                  SizedBox(height: heightSize(2)),
                  CText(
                    text: subtitle,
                    size: 12,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: subtitleColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}