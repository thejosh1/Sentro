import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _isEmail = false;
  bool _isSms = false;
  bool _isPush = false;
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
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                SizedBox(width: widthSize(105),),
                CText(
                  text: 'Notification',
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
              text: 'TRANSACTION NOTIFICATIONS',
              size: 12,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              color: sGrey1,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthSize(252),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Email Notification',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Receive transaction notification via email.',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: isDark?sAccountColor:sGrey2,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isEmail = !_isEmail),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeInOut,
                          width: widthSize(54),
                          height: heightSize(28),
                          padding: EdgeInsets.symmetric(
                            horizontal: widthSize(4),
                            vertical: heightSize(3),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: _isEmail ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isEmail
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeInOut,
                                width: widthSize(22),
                                height: heightSize(22),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthSize(252),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'SMS Notification (Fee charged)',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Receive transaction notification via SMS',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: isDark?sAccountColor:sGrey2,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isSms = !_isSms),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeInOut,
                          width: widthSize(54),
                          height: heightSize(28),
                          padding: EdgeInsets.symmetric(
                            horizontal: widthSize(4),
                            vertical: heightSize(3),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: _isSms ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isSms
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeInOut,
                                width: widthSize(22),
                                height: heightSize(22),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthSize(252),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Push Notification',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Allow transactions to show on notification',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: isDark?sAccountColor:sGrey2,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isPush = !_isPush),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeInOut,
                          width: widthSize(54),
                          height: heightSize(28),
                          padding: EdgeInsets.symmetric(
                            horizontal: widthSize(4),
                            vertical: heightSize(3),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: _isPush ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isPush
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeInOut,
                                width: widthSize(22),
                                height: heightSize(22),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
