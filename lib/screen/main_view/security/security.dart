import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Spacer(),
                CText(
                  text: 'Security',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  height: 20/18,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: heightSize(51),),
            CText(
              text: 'SECURITY & PRIVACY',
              size: 12,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              color: isDark?sGrey1:sGrey2,
            ),
            SizedBox(height: heightSize(16),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25), vertical: heightSize(25)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDark?sDarkFill:sLightFill,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.appLock);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          appLock,
                          width: widthSize(38),
                          height: heightSize(38),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'App Lock',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Use PIN or Biometrics to unlock',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.changePin);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          pinChange,
                          width: widthSize(38),
                          height: heightSize(38),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Change PIN',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Use PIN or Biometrics to unlock',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.changePassword);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          passwordChange,
                          width: widthSize(38),
                          height: heightSize(38),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Change Password',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Reset your account login password',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.linkedDevices);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          linkedDevices,
                          width: widthSize(38),
                          height: heightSize(38),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Linked Devices',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Devices your account has been logged in',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.permissions);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          visibility,
                          width: widthSize(38),
                          height: heightSize(38),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                        SizedBox(width: widthSize(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Privacy & Data Setting',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Authorise permissions',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          arrowForward,
                          width: widthSize(7.57),
                          height: heightSize(13.64),
                          colorFilter: isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
