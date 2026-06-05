import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}


class _VerificationState extends State<Verification> {
  bool _fromCardCreation = false;
  bool _fromPayAccountCreation = false;
  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  void initState() {
    super.initState();
    // Intercepts context routing arguments dynamically
    final args = Get.arguments as Map<String, dynamic>?;
    _fromCardCreation = args?['fromCardCreation'] == true;
    _fromPayAccountCreation = args?['fromPayAccountCreation'] == true;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark ? arrowBackWhite : arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                SizedBox(width: widthSize(105),),
                CText(
                  text: 'Verification',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  height: 20 / 18,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: heightSize(51),),
            CText(
              text: 'ACCOUNT VERIFICATION',
              size: 12,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              color: isDark ? sGrey1 : sGrey2,
            ),
            SizedBox(height: heightSize(16),),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: widthSize(25), vertical: heightSize(25)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark ? sDarkFill : sLightFill,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.appLock);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          bvn, width: widthSize(38), height: heightSize(38),),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'BVN',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67 / 14,
                            ),
                            CText(
                              text: 'Bank Verification Number',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67 / 12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(tickLight, width: widthSize(24),
                          height: heightSize(24),),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.changePin);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          nin, width: widthSize(38), height: heightSize(38),),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'NIN',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67 / 14,
                            ),
                            CText(
                              text: 'National Identification Number',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67 / 12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(tickLight, width: widthSize(24),
                          height: heightSize(24),),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.changePassword);
                      Get.toNamed(
                        Routes.upgradeAccount,
                        arguments: 2,
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(address, width: widthSize(38),
                          height: heightSize(38),),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Address Verification',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67 / 14,
                            ),
                            SizedBox(
                              width: widthSize(230),
                              child: CText(
                                text: 'Verify home address as a proof of residency',
                                size: 12,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: sAccountColor,
                                height: 16.67 / 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: ColorFilter.mode(
                              sVerifyArrow, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.linkedDevices);
                      Get.toNamed(
                        Routes.upgradeAccount,
                        arguments: 3,
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          kin, width: widthSize(38), height: heightSize(38),),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Next of Kin',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67 / 14,
                            ),
                            CText(
                              text: 'Provide next of kin to your account',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67 / 12,
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/upgradeAccount',
                              arguments: 3,
                            );
                          },
                          child: SvgPicture.asset(
                            arrowForward,
                            width: widthSize(7.57),
                            height: heightSize(13.64),
                            colorFilter: ColorFilter.mode(
                                sVerifyArrow, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(47),),
                  Obx(() {
                    final accent = AccentController.to.accent.value;
                    final useAccent = !_isDefaultAccent(accent);
                    return ActionButton(
                      text: 'Complete Verification',
                      textColor: sActionButton,
                      color: useAccent?accent:isDark?sNavContainer:sActionButton,
                      callback: () {
                        if (_fromCardCreation) {
                          Get.toNamed(Routes.cardSummary);
                        } else if (_fromPayAccountCreation) {
                          Get.toNamed(Routes.createPayAccount, arguments: {'fromPayAccountCreation': true});
                        } else {
                          Get.back();
                        }
                      },
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
