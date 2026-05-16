import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/label_container.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/home_page.dart';

class BillerCategories extends StatelessWidget {
  const BillerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final chipBg = isDark ? sContainerColor : colorScheme.surface;

    return Padding(
      padding: EdgeInsets.only(bottom: heightSize(8)),
      child: SizedBox(
        height: heightSize(111 + 30), // card + chip space
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Main card
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: heightSize(111),
                padding: EdgeInsets.symmetric(horizontal: widthSize(12)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius20),
                  color: chipBg,
                  boxShadow: isDark
                      ? null
                      : [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    billerItem(
                      assetName: mobile,
                      title: 'Top Up',
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {},
                      color: sLightBlue,
                    ),
                    billerItem(
                      assetName: electricity,
                      title: 'Pay Bills',
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {},
                      color: sPurple,
                    ),
                    billerItem(
                      assetName: betting,
                      title: 'Betting',
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {},
                      color: sOrange,
                    ),
                    billerItem(
                      assetName: savings,
                      title: 'Save Money',
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {},
                      color: sPearl,
                    ),
                    billerItem(
                      assetName: loansService,
                      title: 'Loans',
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {},
                      color: sNavContainer,
                    ),
                  ],
                ),
              ),
            ),

            // All Services chip
            Positioned(
              bottom: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Values().buttonRadius10),
                    bottomRight: Radius.circular(Values().buttonRadius10),
                  ),
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'All Services',
                      barrierColor: Colors.transparent,   // ← we handle the overlay ourselves
                      transitionDuration: const Duration(milliseconds: 350),
                      pageBuilder: (ctx, anim1, anim2) {
                        return Stack(
                          children: [
                            // ── Blur + dark overlay (tappable to dismiss) ──────────
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: GestureDetector(
                                onTap: () => Navigator.pop(ctx),
                                child: Container(
                                  color: Colors.black.withOpacity(isDark ? 0.45 : 0.3),
                                ),
                              ),
                            ),

                            // ── Sheet slides up from bottom ─────────────────────────
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: anim1,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                                child: SafeArea(
                                  top: false,
                                  child: _AllServicesSheet(
                                    isDark: isDark,
                                    colorScheme: colorScheme,
                                    context: ctx,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: widthSize(145),
                    height: heightSize(29),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Values().buttonRadius10),
                        bottomRight: Radius.circular(Values().buttonRadius10),
                      ),
                      color: chipBg,
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
                        Container(
                          width: widthSize(20),
                          height: heightSize(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: sLightBlue.withOpacity(0.1),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              more,
                              width: widthSize(10),
                              height: heightSize(8.13),
                            ),
                          ),
                        ),
                        SizedBox(width: widthSize(10)),
                        CText(
                          text: 'All Services',
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
            ),
          ],
        ),
      ),
    );
  }
}

// ── MODAL SHEET ───────────────────────────────────────────────

class _AllServicesSheet extends StatelessWidget {
  final bool isDark;
  final ColorScheme colorScheme;
  final BuildContext context;

  const _AllServicesSheet({
    required this.isDark,
    required this.colorScheme,
    required this.context,
  });

  Color get _panelColor =>
      isDark ? sServicesColor : colorScheme.surface;

  Widget _sectionTitle(String text) {
    return CText(
      text: text,
      size: 14,
      fontWeight: FontWeight.w500,
      fontFamily: CFONT.MEDIUM,
      color: colorScheme.onSurface,
    );
  }

  Widget _row(List<Widget> children) {
    final itemWidth = (MediaQuery.of(context).size.width - widthSize(26 + 36)) / 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // ← always starts from left
      children: children.map((child) => SizedBox(
        width: itemWidth,
        child: child,
      )).toList(),
    );
  }

  Widget _item({
    required String assetName,
    required String title,
    required Function callback,
    bool isNew = false,
    Color? tintColor,
    double? iconHeight = 37.68,
    double? iconWidth = 37.68,
  }) {
    return investmentItem(
      assetName: assetName,
      iconContainerHeight: heightSize(52.33),
      iconContainerWidth: widthSize(52.33),
      iconHeight: iconHeight,
      iconWidth: iconWidth,
      title: title,
      isDark: isDark,
      colorScheme: colorScheme,
      callback: () => callback(),
      isNew: isNew,
      tintColor: tintColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: _panelColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Values().buttonRadius20),
            topRight: Radius.circular(Values().buttonRadius20),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: heightSize(13),
                left: widthSize(13),
                right: widthSize(13),
                bottom: heightSize(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(18),
                      vertical: heightSize(12.36),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: sContainerColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Recently Used'),
                        SizedBox(height: heightSize(14)),

                        _row([
                          _item(
                            assetName: mobileWhite,
                            title: 'Airtime',
                            tintColor: Colors.white,
                            iconHeight: heightSize(22.92),
                            iconWidth: widthSize(22.92),
                            callback: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,

                                barrierColor: Colors.black.withOpacity(0.45),
                                builder: (context) {
                                  bool isDataSelected = false;

                                  return StatefulBuilder(
                                    builder: (context, setDialogState) {
                                      return Dialog(
                                        backgroundColor: isDark
                                            ? sContainerColor
                                            : Theme.of(context).scaffoldBackgroundColor,
                                        insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                                        child: Container(
                                          height: heightSize(499),
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? sContainerColor
                                                : Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: heightSize(15),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: widthSize(156.8),
                                                    height: heightSize(31),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(113.27),
                                                        color: sButtonFillDark,
                                                        border: Border.all(color: sDarkBorder)
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          wallet,
                                                          width: widthSize(24),
                                                          height: heightSize(24),
                                                        ),
                                                        SizedBox(width: widthSize(3.4),),
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
                                                        SvgPicture.asset(
                                                          visibilityOff,
                                                          width: widthSize(24),
                                                          height: heightSize(24),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: widthSize(33.33),
                                                    height: heightSize(33.33),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white.withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(cancelWhite),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: heightSize(13)),
                                              CText(
                                                text: 'Mobile Top up',
                                                size: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: CFONT.MEDIUM,
                                              ),
                                              SizedBox(height: heightSize(13)),
                                              CText(
                                                text: 'Top up your Airtime and Data',
                                                size: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: CFONT.REGULAR,
                                              ),
                                              SizedBox(height: heightSize(20)),
                                              Container(
                                                width: widthSize(214),
                                                height: heightSize(55),
                                                padding: EdgeInsets.symmetric(horizontal: widthSize(6)),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  color: sDescriptionColor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // Airtime
                                                    GestureDetector(
                                                      onTap: () {
                                                        setDialogState(() {
                                                          isDataSelected = false;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 250),
                                                        width: widthSize(100),
                                                        height: heightSize(43),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(40),
                                                          color: !isDataSelected
                                                              ? sActiveColor
                                                              : Colors.transparent,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              mobileWhite,
                                                              width: widthSize(16),
                                                              height: heightSize(20),
                                                              colorFilter: !isDataSelected
                                                                  ? null
                                                                  : ColorFilter.mode(
                                                                Colors.white.withOpacity(0.7),
                                                                BlendMode.srcIn,
                                                              ),
                                                            ),
                                                            SizedBox(width: widthSize(8)),
                                                            CText(
                                                              text: 'Airtime',
                                                              fontFamily: CFONT.REGULAR,
                                                              fontWeight: FontWeight.w400,
                                                              size: 14,
                                                              color: !isDataSelected
                                                                  ? sNavContainer
                                                                  : Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Data
                                                    GestureDetector(
                                                      onTap: () {
                                                        setDialogState(() { // ← use setDialogState, not setState
                                                          isDataSelected = true;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 250),
                                                        width: widthSize(100),
                                                        height: heightSize(43),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(40),
                                                          color: isDataSelected
                                                              ? sActiveColor
                                                              : Colors.transparent,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              data,
                                                              width: widthSize(24),
                                                              height: heightSize(24),
                                                              colorFilter: ColorFilter.mode(
                                                                isDataSelected
                                                                    ? sNavContainer
                                                                    : Colors.white.withOpacity(0.7),
                                                                BlendMode.srcIn,
                                                              ),
                                                            ),
                                                            SizedBox(width: widthSize(5)),
                                                            CText(
                                                              text: 'Data',
                                                              fontWeight: FontWeight.w400,
                                                              size: 14,
                                                              color: isDataSelected
                                                                  ? sNavContainer
                                                                  : Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: heightSize(40)),
                                              LabelContainer(isData: isDataSelected,),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          ),
                          _item(
                            assetName: data,
                            title: 'Data',
                            tintColor: Colors.white,
                            iconHeight: heightSize(23.46),
                            iconWidth: widthSize(30),
                            callback: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,

                                barrierColor: Colors.black.withOpacity(0.45),
                                builder: (context) {
                                  bool isDataSelected = true;

                                  return StatefulBuilder(
                                    builder: (context, setDialogState) {
                                      return Dialog(
                                        backgroundColor: isDark
                                            ? sContainerColor
                                            : Theme.of(context).scaffoldBackgroundColor,
                                        insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                                        child: Container(
                                          height: heightSize(499),
                                          width: double.maxFinite,
                                          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? sContainerColor
                                                : Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: heightSize(15),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: widthSize(156.8),
                                                    height: heightSize(31),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(113.27),
                                                        color: sButtonFillDark,
                                                        border: Border.all(color: sDarkBorder)
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          wallet,
                                                          width: widthSize(24),
                                                          height: heightSize(24),
                                                        ),
                                                        SizedBox(width: widthSize(3.4),),
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
                                                        SvgPicture.asset(
                                                          visibilityOff,
                                                          width: widthSize(24),
                                                          height: heightSize(24),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: widthSize(33.33),
                                                    height: heightSize(33.33),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white.withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(cancelWhite),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: heightSize(13)),
                                              CText(
                                                text: 'Mobile Top up',
                                                size: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: CFONT.MEDIUM,
                                              ),
                                              SizedBox(height: heightSize(13)),
                                              CText(
                                                text: 'Top up your Airtime and Data',
                                                size: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: CFONT.REGULAR,
                                              ),
                                              SizedBox(height: heightSize(20)),
                                              Container(
                                                width: widthSize(214),
                                                height: heightSize(55),
                                                padding: EdgeInsets.symmetric(horizontal: widthSize(6)),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  color: sDescriptionColor,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // Airtime
                                                    GestureDetector(
                                                      onTap: () {
                                                        setDialogState(() {
                                                          isDataSelected = false;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 250),
                                                        width: widthSize(100),
                                                        height: heightSize(43),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(40),
                                                          color: !isDataSelected
                                                              ? sActiveColor
                                                              : Colors.transparent,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              mobileWhite,
                                                              width: widthSize(16),
                                                              height: heightSize(20),
                                                              colorFilter: !isDataSelected
                                                                  ? null
                                                                  : ColorFilter.mode(
                                                                Colors.white.withOpacity(0.7),
                                                                BlendMode.srcIn,
                                                              ),
                                                            ),
                                                            SizedBox(width: widthSize(8)),
                                                            CText(
                                                              text: 'Airtime',
                                                              fontFamily: CFONT.REGULAR,
                                                              fontWeight: FontWeight.w400,
                                                              size: 14,
                                                              color: !isDataSelected
                                                                  ? sNavContainer
                                                                  : Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Data
                                                    GestureDetector(
                                                      onTap: () {
                                                        setDialogState(() { // ← use setDialogState, not setState
                                                          isDataSelected = true;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 250),
                                                        width: widthSize(100),
                                                        height: heightSize(43),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(40),
                                                          color: isDataSelected
                                                              ? sActiveColor
                                                              : Colors.transparent,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              data,
                                                              width: widthSize(24),
                                                              height: heightSize(24),
                                                              colorFilter: ColorFilter.mode(
                                                                isDataSelected
                                                                    ? sNavContainer
                                                                    : Colors.white.withOpacity(0.7),
                                                                BlendMode.srcIn,
                                                              ),
                                                            ),
                                                            SizedBox(width: widthSize(5)),
                                                            CText(
                                                              text: 'Data',
                                                              fontWeight: FontWeight.w400,
                                                              size: 14,
                                                              color: isDataSelected
                                                                  ? sNavContainer
                                                                  : Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: heightSize(40)),
                                              LabelContainer(isData: isDataSelected,),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          ),
                          _item(
                            assetName: electricity,
                            title: 'Electricity',
                            tintColor: Colors.white,
                            callback: () {},
                            iconHeight: heightSize(34.38),
                            iconWidth: widthSize(34.38),
                          ),
                          _item(
                            assetName: gift,
                            title: 'Gift Cards',
                            tintColor: Colors.white,
                            callback: () {},
                            iconHeight: heightSize(30),
                            iconWidth: widthSize(21.32),
                          ),
                          _item(
                            assetName: loansService,
                            title: 'Loans',
                            tintColor: Colors.white,
                            callback: () {},
                            iconHeight: heightSize(34),
                            iconWidth: widthSize(34),
                          ),
                        ]),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(10)),

                  Container(
                    padding: EdgeInsets.only(
                      left: widthSize(18),
                      right: widthSize(18),
                      bottom: heightSize(48.07),
                      top: heightSize(10),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: sContainerColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('All Services'),
                        SizedBox(height: heightSize(14)),

                        Column(
                          children: [
                            _row([
                              _item(
                                assetName: transfer,
                                title: 'Transfer',
                                tintColor: Colors.white,
                                iconHeight: heightSize(36),
                                iconWidth: widthSize(36),
                                callback: () {},
                              ),
                              _item(
                                assetName: mobileWhite,
                                title: 'Airtime',
                                tintColor: Colors.white,
                                iconHeight: heightSize(22.92),
                                iconWidth: widthSize(22.92),
                                callback: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,

                                      barrierColor: Colors.black.withOpacity(0.45),
                                      builder: (context) {
                                        bool isDataSelected = false;

                                        return StatefulBuilder(
                                          builder: (context, setDialogState) {
                                            return Dialog(
                                              backgroundColor: isDark
                                                  ? sContainerColor
                                                  : Theme.of(context).scaffoldBackgroundColor,
                                              insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                                              child: Container(
                                                height: heightSize(499),
                                                width: double.maxFinite,
                                                padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? sContainerColor
                                                      : Theme.of(context).scaffoldBackgroundColor,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: heightSize(15),),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: widthSize(156.8),
                                                          height: heightSize(31),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(113.27),
                                                              color: sButtonFillDark,
                                                              border: Border.all(color: sDarkBorder)
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                wallet,
                                                                width: widthSize(24),
                                                                height: heightSize(24),
                                                              ),
                                                              SizedBox(width: widthSize(3.4),),
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
                                                              SvgPicture.asset(
                                                                visibilityOff,
                                                                width: widthSize(24),
                                                                height: heightSize(24),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: widthSize(33.33),
                                                          height: heightSize(33.33),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.white.withOpacity(0.1),
                                                          ),
                                                          child: Center(
                                                            child: SvgPicture.asset(cancelWhite),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: heightSize(13)),
                                                    CText(
                                                      text: 'Mobile Top up',
                                                      size: 18,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: CFONT.MEDIUM,
                                                    ),
                                                    SizedBox(height: heightSize(13)),
                                                    CText(
                                                      text: 'Top up your Airtime and Data',
                                                      size: 14,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: CFONT.REGULAR,
                                                    ),
                                                    SizedBox(height: heightSize(20)),
                                                    Container(
                                                      width: widthSize(214),
                                                      height: heightSize(55),
                                                      padding: EdgeInsets.symmetric(horizontal: widthSize(6)),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(40),
                                                        color: sDescriptionColor,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // Airtime
                                                          GestureDetector(
                                                            onTap: () {
                                                              setDialogState(() {
                                                                isDataSelected = false;
                                                              });
                                                            },
                                                            child: AnimatedContainer(
                                                              duration: const Duration(milliseconds: 250),
                                                              width: widthSize(100),
                                                              height: heightSize(43),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(40),
                                                                color: !isDataSelected
                                                                    ? sActiveColor
                                                                    : Colors.transparent,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    mobileWhite,
                                                                    width: widthSize(16),
                                                                    height: heightSize(20),
                                                                    colorFilter: !isDataSelected
                                                                        ? null
                                                                        : ColorFilter.mode(
                                                                      Colors.white.withOpacity(0.7),
                                                                      BlendMode.srcIn,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: widthSize(8)),
                                                                  CText(
                                                                    text: 'Airtime',
                                                                    fontFamily: CFONT.REGULAR,
                                                                    fontWeight: FontWeight.w400,
                                                                    size: 14,
                                                                    color: !isDataSelected
                                                                        ? sNavContainer
                                                                        : Colors.white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          // Data
                                                          GestureDetector(
                                                            onTap: () {
                                                              setDialogState(() { // ← use setDialogState, not setState
                                                                isDataSelected = true;
                                                              });
                                                            },
                                                            child: AnimatedContainer(
                                                              duration: const Duration(milliseconds: 250),
                                                              width: widthSize(100),
                                                              height: heightSize(43),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(40),
                                                                color: isDataSelected
                                                                    ? sActiveColor
                                                                    : Colors.transparent,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    data,
                                                                    width: widthSize(24),
                                                                    height: heightSize(24),
                                                                    colorFilter: ColorFilter.mode(
                                                                      isDataSelected
                                                                          ? sNavContainer
                                                                          : Colors.white.withOpacity(0.7),
                                                                      BlendMode.srcIn,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: widthSize(5)),
                                                                  CText(
                                                                    text: 'Data',
                                                                    fontWeight: FontWeight.w400,
                                                                    size: 14,
                                                                    color: isDataSelected
                                                                        ? sNavContainer
                                                                        : Colors.white,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: heightSize(40)),
                                                    LabelContainer(isData: isDataSelected,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                              ),
                              _item(
                                assetName: data,
                                title: 'Data',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(23.46),
                                iconWidth: widthSize(30),
                                isNew: true,
                              ),
                              _item(
                                assetName: betting,
                                title: 'Betting',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(36),
                                iconWidth: widthSize(36),
                              ),
                              _item(
                                assetName: electricity,
                                title: 'Electricity',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(34.38),
                                iconWidth: widthSize(34.38),
                              ),
                            ]),

                            SizedBox(height: heightSize(18)),

                            _row([
                              _item(
                                assetName: gift,
                                title: 'Gift Cards',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(30),
                                iconWidth: widthSize(21.32),
                              ),
                              _item(
                                assetName: card,
                                title: 'Cards',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(36),
                                iconWidth: widthSize(36),
                              ),
                              _item(
                                assetName: loansService,
                                title: 'Loans',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(34),
                                iconWidth: widthSize(34),
                              ),
                              _item(
                                assetName: invest,
                                title: 'Investment',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(20.7),
                                iconWidth: widthSize(17.61),
                              ),
                              _item(
                                assetName: qrPay,
                                title: 'QR Pay',
                                tintColor: Colors.white,
                                callback: () {},
                                iconHeight: heightSize(36),
                                iconWidth: widthSize(36),
                              ),
                            ]),

                            SizedBox(height: heightSize(18)),

                            _row([
                              _item(
                                assetName: savings,
                                title: 'Savings',
                                tintColor: Colors.white,
                                callback: () {},
                                isNew: true,
                                iconHeight: heightSize(34),
                                iconWidth: widthSize(34),
                              ),
                              _item(
                                assetName: gift,
                                title: 'BNPL',
                                tintColor: Colors.white,
                                callback: () {},
                                isNew: true,
                                iconHeight: heightSize(34),
                                iconWidth: widthSize(34),
                              ),
                              _item(
                                assetName: julo,
                                title: 'Julo Energy',
                                callback: () {},
                                iconWidth: widthSize(37.761),
                                iconHeight: heightSize(20),
                                isNew: true,
                              ),
                            ]),

                            SizedBox(height: heightSize(24)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(19)),
                ],
              ),
            ),

            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: widthSize(112),
                  height: heightSize(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Values().buttonRadius10),
                      bottomRight: Radius.circular(Values().buttonRadius10),
                    ),
                    color: _panelColor,
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
                      Container(
                        width: widthSize(20),
                        height: heightSize(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: sLightBlue.withOpacity(0.1),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            more,
                            width: widthSize(10),
                            height: heightSize(8.13),
                          ),
                        ),
                      ),
                      SizedBox(width: widthSize(8)),
                      CText(
                        text: 'All Services',
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
      ),
    );
  }

}

// ── BILLER ITEM ───────────────────────────────────────────────

Widget billerItem({
  required String assetName,
  required String title,
  required bool isDark,
  required ColorScheme colorScheme,
  required VoidCallback callback,
  required Color color,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    isDark: isDark,
    colorScheme: colorScheme,
    onTap: callback,
    color: color,
  );
}

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final bool isDark;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final Color color;

  const _AnimatedCategoryItem({
    required this.assetName,
    required this.title,
    required this.isDark,
    required this.colorScheme,
    required this.onTap,
    required this.color,
  });

  @override
  State<_AnimatedCategoryItem> createState() =>
      _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState
    extends State<_AnimatedCategoryItem> {
  bool _pressed = false;

  void _onTapDown(_) =>
      setState(() => _pressed = true);

  void _onTapUp(_) =>
      setState(() => _pressed = false);

  void _onTapCancel() =>
      setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final iconBg =
    widget.color.withOpacity(0.10);

    final iconTint = widget.color;

    return AnimatedScale(
      scale: _pressed ? 0.92 : 1.0,
      duration:
      const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        duration:
        const Duration(milliseconds: 120),
        opacity: _pressed ? 0.7 : 1.0,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _pressed ? 0.9 : 1.0,
                duration: const Duration(
                  milliseconds: 120,
                ),
                child: Container(
                  height: heightSize(49.45),
                  width: widthSize(49.45),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius:
                    BorderRadius.circular(
                      Values().buttonRadius10,
                    ),
                  ),
                  child: SvgPicture.asset(
                    widget.assetName,
                    height: heightSize(36),
                    width: widthSize(36),
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      iconTint,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              SizedBox(height: heightSize(5)),

              CText(
                text: widget.title,
                size: 12,
                fontWeight: FontWeight.w400,
                fontFamily: CFONT.REGULAR,
                height: 1.67,
                color:
                widget.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

