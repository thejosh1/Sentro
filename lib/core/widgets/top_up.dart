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

void showMobileTopupDialog({
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
                  height: heightSize(500),
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
                        CText(text: 'Mobile Top up', size: 18, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM),
                        SizedBox(height: heightSize(13)),
                        CText(text: 'Top up your Airtime and Data', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR),
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
                            // ── Airtime tab ──────────────────────────
                            GestureDetector(
                              onTap: () => setDialogState(() => isDataSelected = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: widthSize(100),
                                height: heightSize(43),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: !isDataSelected ? sActiveColor : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      phone,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                      colorFilter: ColorFilter.mode(
                                        !isDataSelected ? sNavContainer : Colors.white.withOpacity(0.7),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: widthSize(8)),
                                    CText(
                                      text: 'Airtime',
                                      fontFamily: CFONT.REGULAR,
                                      fontWeight: FontWeight.w400,
                                      size: 14,
                                      color: !isDataSelected ? sNavContainer : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ── Data tab ─────────────────────────────
                            GestureDetector(
                              onTap: () => setDialogState(() => isDataSelected = true),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: widthSize(100),
                                height: heightSize(43),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: isDataSelected ? sActiveColor : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      dataTopUp,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                      colorFilter: ColorFilter.mode(
                                        isDataSelected ? sNavContainer : Colors.white.withOpacity(0.7),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: widthSize(5)),
                                    CText(
                                      text: 'Data',
                                      fontWeight: FontWeight.w400,
                                      size: 14,
                                      color: isDataSelected ? sNavContainer : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: heightSize(40)),
                        LabelContainer(isData: isDataSelected),
                        SizedBox(height: heightSize(24)),
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