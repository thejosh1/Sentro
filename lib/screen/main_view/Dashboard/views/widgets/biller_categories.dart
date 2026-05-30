import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/label_container.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/bill_payment.dart';
import 'package:sentro/core/widgets/loan_dialog.dart';
import 'package:sentro/core/widgets/top_up.dart';
import 'package:sentro/screen/main_view/Dashboard/views/home_page.dart';
import 'package:sentro/screen/main_view/controller/main_controller.dart';


import '../../../../../core/router/app_pages.dart';
import 'home_widgets.dart';
final MainController controller = Get.put(MainController());

class BillerCategories extends StatelessWidget {
  const BillerCategories({super.key});


  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final chipBg = isDark ? sContainerColor : sLightFill;

    Get.put(MainController());

    return Padding(
      padding: EdgeInsets.only(bottom: heightSize(8)),
      child: SizedBox(
        height: heightSize(141),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
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
                      color: sLightBlue,
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {
                        showMobileTopupDialog(context: context, isDark: isDark);
                      },
                    ),

                    billerItem(
                      assetName: electricity,
                      title: 'Pay Bills',
                      color: sYello,
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () {
                        showBillPaymentDialog(context: context, isDark: isDark);
                      },
                    ),
                    billerItem(
                      assetName: betting,
                      title: 'Betting',
                      color: sOrange,
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () => Get.toNamed(Routes.betting),
                    ),
                    billerItem(
                      assetName: savings,
                      title: 'Save Money',
                      color: sPearl,
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () => Get.toNamed(Routes.startSaving),
                    ),
                    billerItem(
                      assetName: loansService,
                      title: 'Loans',
                      color: sNavContainer,
                      isDark: isDark,
                      colorScheme: colorScheme,
                      callback: () => showLoanDialog(
                        context: context,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 0,
              right: 0,
              child: Center(
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
                                      context: ctx, controller: controller,
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
                      width: widthSize(112),
                      height: heightSize(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Values().buttonRadius10+2),
                          bottomRight: Radius.circular(Values().buttonRadius10+2),
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
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            size: 12,
                            color: isDark ? Colors.white : colorScheme.primary,
                          ),
                        ],
                      ),
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
  final MainController controller;
  final bool isDark;
  final ColorScheme colorScheme;
  final BuildContext context;

  const _AllServicesSheet({
    required this.isDark,
    required this.colorScheme,
    required this.context,
    required this.controller,
  });

  Color get _panelColor =>
      isDark ? sServicesColor : colorScheme.surface;

  Widget _sectionTitle(String text) {
    return CText(
      text: text,
      size: 14,
      fontWeight: CFONT.wMedium,
      fontFamily: CFONT.FAMILY,
      color: colorScheme.onSurface,
    );
  }

  Widget _row(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children
          .map((child) => SizedBox(
        width: widthSize(68),
        child: child,
      ))
          .toList(),
    );
  }

  Widget _item({
    required String assetName,
    required String title,
    required Function callback,
    bool isNew = false,
    Color? tintColor,
  }) {
    return investmentItem(
      assetName: assetName,
      iconContainerHeight: heightSize(50),
      iconContainerWidth: widthSize(50),
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
        margin: EdgeInsets.symmetric(horizontal: widthSize(5)),
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
                      color: isDark?sContainerColor:sLightFill,
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
                            tintColor: isDark?null:sActionButton,
                            callback: () {
                              showMobileTopupDialog(
                                context: context,
                                isDark: isDark,
                              );
                            },
                          ),
                          _item(
                            assetName: data,
                            title: 'Data',
                            tintColor: isDark?null:sActionButton,
                            callback: () {
                              showMobileTopupDialog(
                                context: context,
                                isDark: isDark,
                                initialDataSelected: true,
                              );
                            },
                          ),
                          _item(
                            assetName: electricity,
                            title: 'Electricity',
                            tintColor: isDark?Colors.white:sActionButton,
                            callback: () {
                              Get.toNamed(Routes.electricity);
                            },
                          ),
                          _item(
                            assetName: gift,
                            title: 'Gift Cards',
                            tintColor: isDark?null:sActionButton,
                            callback: () {},
                          ),
                          _item(
                            assetName: loansService,
                            title: 'Loans',
                            tintColor: isDark?Colors.white:sActionButton,
                            callback: () {
                              showLoanDialog(
                                context: context,
                                isDark: isDark,
                              );
                            },
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
                      color: isDark?sContainerColor:sLightFill,
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
                                tintColor: isDark?null:sActionButton,
                                callback: () {
                                  Get.toNamed(Routes.transfer);
                                },
                              ),
                              _item(
                                assetName: mobileWhite,
                                title: 'Airtime',
                                tintColor: isDark?null:sActionButton,
                                callback: () {
                                  showMobileTopupDialog(
                                    context: context,
                                    isDark: isDark,
                                  );
                                },
                              ),
                              _item(
                                assetName: data,
                                title: 'Data',
                                tintColor: isDark?null:sActionButton,
                                isNew: true,
                                callback: () {
                                  showMobileTopupDialog(
                                    context: context,
                                    isDark: isDark,
                                    initialDataSelected: true,
                                  );
                                },
                              ),
                              _item(
                                assetName: bettingWhite,
                                title: 'Betting',
                                tintColor: isDark?null:sActionButton,
                                callback: () {
                                  Get.toNamed(Routes.betting);
                                },
                              ),
                              _item(
                                assetName: electricity,
                                title: 'Electricity',
                                tintColor: isDark?Colors.white:sActionButton,
                                callback: () {
                                  Get.toNamed(Routes.electricity);
                                },
                              ),
                            ]),

                            SizedBox(height: heightSize(18)),

                            _row([
                              _item(
                                assetName: gift,
                                title: 'Gift Cards',
                                tintColor: isDark?null:sActionButton,
                                callback: () {},
                              ),
                              _item(
                                assetName: cardWhite,
                                title: 'Cards',
                                tintColor: isDark?null:sActionButton,
                                callback: () {},
                              ),
                              _item(
                                assetName: loansService,
                                title: 'Loans',
                                tintColor: isDark?Colors.white:sActionButton,
                                callback: () {
                                  showLoanDialog(
                                    context: context,
                                    isDark: isDark,
                                  );
                                },
                              ),
                              _item(
                                assetName: invest,
                                title: 'Investment',
                                tintColor: isDark?null:sActionButton,
                                callback: () {},
                              ),
                              _item(
                                assetName: qrPayWhite,
                                title: 'QR Pay',
                                tintColor: isDark?null:sActionButton,
                                callback: () {
                                  Get.toNamed(Routes.qrPay);
                                },
                              ),
                            ]),

                            SizedBox(height: heightSize(18)),

                            _row([
                              _item(
                                assetName: savingsWhite,
                                title: 'Savings',
                                tintColor: isDark?null:sActionButton,
                                isNew: true,
                                callback: () {
                                  Get.toNamed(Routes.activeGoals);
                                },
                              ),
                              _item(
                                assetName: bnpl,
                                title: 'BNPL',
                                tintColor: isDark?null:sActionButton,
                                isNew: true,
                                callback: () {},
                              ),
                              _item(
                                assetName: julo,
                                title: 'Julo Energy',
                                tintColor: isDark?null:sActionButton,
                                isNew: true,
                                callback: () {},
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
              top: -23,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: widthSize(112),
                  height: heightSize(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Values().buttonRadius10 + 2),
                      topRight: Radius.circular(Values().buttonRadius10 + 2),
                    ),
                    color: _panelColor,
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
                        size: 12,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                        color:
                        isDark ? Colors.white : colorScheme.primary,
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
                child: SvgPicture.asset(
                  widget.assetName,
                  height: heightSize(55),
                  width: widthSize(55),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    iconTint,
                    BlendMode.srcIn,
                  ),
                ),
              ),

              SizedBox(height: heightSize(5)),

              CText(
                text: widget.title,
                size: 12,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
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

