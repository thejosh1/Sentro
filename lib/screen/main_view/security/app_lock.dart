import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class AppLock extends StatefulWidget {
  const AppLock({super.key});

  @override
  State<AppLock> createState() => _AppLockState();
}

class _AppLockState extends State<AppLock> {
  bool _istrue = false;
  @override
  Widget build(BuildContext context) {
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
                    arrowBackWhite,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                Spacer(),
                CText(
                  text: 'App Lock',
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
              text: 'PIN & BIOMETRIC LOCK',
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
                color: sDarkFill,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
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
                      Expanded(
                        child: Spacer(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.enableBiometrics);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: widthSize(12), vertical: heightSize(5.67)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: sNavContainer.withOpacity(0.1),
                          ),
                          child: CText(
                            text: 'Active',
                            size: 16,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sNavContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(15),),
                  Divider(color: sDarkBorder,),
                  SizedBox(height: heightSize(15),),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Biometrics Unlock',
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
                      Expanded(
                        child: Spacer(),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _istrue = !_istrue),
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
                            color: _istrue ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _istrue
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
