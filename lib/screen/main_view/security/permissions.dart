import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/permission_controller.dart';
import 'package:sentro/core/utils/text.dart';

class Permissions extends StatefulWidget {
  const Permissions({super.key});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  final PermissionController perm = PermissionController.to;
  bool _isContact = false;
  bool _isLocation = false;
  bool _isBiometric = false;

  @override
  void initState() {
    super.initState();
    PermissionController.to.checkCameraPermission();
  }

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
                  text: 'Permissions',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widthSize(252),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Camera',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Allow Sentro to use your camera for QR Scan',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        final isGranted = PermissionController.to.cameraGranted.value;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: widthSize(54),
                          height: heightSize(28),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: isGranted ? sNavContainer : sDarkBorder,
                          ),
                          child: GestureDetector(
                            onTap: () => PermissionController.to.requestCameraPermission(),
                            child: Align(
                              alignment: isGranted
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: widthSize(22),
                                height: heightSize(22),
                                margin: EdgeInsets.all(widthSize(3)),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
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
                              text: 'Contact',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Allow Sentro to use your contact for Airtime & Data',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isContact = !_isContact),
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
                            color: _isContact ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isContact
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
                              text: 'Map Location',
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
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isLocation = !_isLocation),
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
                            color: _isLocation ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isLocation
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
                              text: 'Biometric Unlock',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wMedium,
                              height: 16.67/14,
                            ),
                            CText(
                              text: 'Allow the use of biometrics to unlock app',
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: sAccountColor,
                              height: 16.67/12,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _isBiometric = !_isBiometric),
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
                            color: _isBiometric ? sNavContainer : sDarkBorder,
                          ),
                          child: Row(
                            mainAxisAlignment: _isBiometric
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
