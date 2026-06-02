import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

class LinkedDevices extends StatelessWidget {
  const LinkedDevices({super.key});

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
                SizedBox(width: widthSize(92),),
                CText(
                  text: 'Linked Devices',
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
              text: 'RECENTLY LOGGED IN',
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
                  Row(
                    children: [
                      SvgPicture.asset(
                        linkedDevices,
                        width: widthSize(38),
                        height: heightSize(38),
                        colorFilter: ColorFilter.mode(isDark?sNavContainer:sActionButton, BlendMode.srcIn),
                      ),
                      SizedBox(width: widthSize(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Infinix X6855, Android',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            height: 16.67/14,
                          ),
                          CText(
                            text: '31 May, 2026 · 11:30 AM',
                            size: 12,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            color: sAccountColor,
                            height: 16.67/12,
                          ),
                          SizedBox(height: heightSize(8),),
                          Row(
                            children: [
                              Image.asset(
                                location,
                                width: widthSize(20),
                                height: heightSize(20),
                              ),
                              SizedBox(width: widthSize(5),),
                              CText(
                                text: '31 May, 2026 · 11:30 AM',
                                size: 12,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: sAccountColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  Row(
                    children: [
                      SvgPicture.asset(
                        linkedDevices,
                        width: widthSize(38),
                        height: heightSize(38),
                        colorFilter: ColorFilter.mode(isDark?sNavContainer:sActionButton, BlendMode.srcIn),
                      ),
                      SizedBox(width: widthSize(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Infinix X6855, Android',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            height: 16.67/14,
                          ),
                          CText(
                            text: '31 May, 2026 · 11:30 AM',
                            size: 12,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            color: sAccountColor,
                            height: 16.67/12,
                          ),
                          SizedBox(height: heightSize(8),),
                          Row(
                            children: [
                              Image.asset(
                                location,
                                width: widthSize(20),
                                height: heightSize(20),
                              ),
                              SizedBox(width: widthSize(5),),
                              CText(
                                text: '31 May, 2026 · 11:30 AM',
                                size: 12,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: sAccountColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  Row(
                    children: [
                      SvgPicture.asset(
                        linkedDevices,
                        width: widthSize(38),
                        height: heightSize(38),
                        colorFilter: ColorFilter.mode(isDark?sNavContainer:sActionButton, BlendMode.srcIn),
                      ),
                      SizedBox(width: widthSize(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Infinix X6855, Android',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            height: 16.67/14,
                          ),
                          CText(
                            text: '31 May, 2026 · 11:30 AM',
                            size: 12,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                            color: sAccountColor,
                            height: 16.67/12,
                          ),
                          SizedBox(height: heightSize(8),),
                          Row(
                            children: [
                              Image.asset(
                                location,
                                width: widthSize(20),
                                height: heightSize(20),
                              ),
                              SizedBox(width: widthSize(5),),
                              CText(
                                text: '31 May, 2026 · 11:30 AM',
                                size: 12,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: sAccountColor,
                              )
                            ],
                          )
                        ],
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
