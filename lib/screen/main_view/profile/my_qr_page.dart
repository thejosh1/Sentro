import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

class MyQrPage extends StatelessWidget {
  const MyQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    arrowBackWhite,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(26.46),),
            CText(
              text: 'My QR Code',
              size: 19.85,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
            ),
            SizedBox(height: heightSize(2.76),),
            CText(
              text: 'Instantly receive money using QR Code',
              size: 16,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              height: 22.05/16,
            ),
            SizedBox(height: heightSize(38.73),),
            Container(
              width: double.maxFinite,
              height: heightSize(412),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: sDarkBorder,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    qrCode,
                    width: widthSize(332),
                    height: heightSize(351),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: heightSize(22),),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(19),
                vertical: heightSize(22),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: sDarkFill,
                border: Border.all(color: sDarkBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: widthSize(40),
                    height: heightSize(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(sentroTag),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(width: widthSize(15),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: 'Richmond Uche',
                        size: 14,
                        fontWeight: CFONT.wMedium,
                        fontFamily: CFONT.FAMILY,
                      ),
                      CText(
                        text: '@richmonduche',
                        size: 12,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        color: sAccountColor,
                      )
                    ],
                  ),
                  Expanded(child: SizedBox.shrink()),
                  SvgPicture.asset(
                    copy,
                    width: widthSize(30),
                    height: heightSize(30),
                    colorFilter: ColorFilter.mode(
                      sSentroLightGreen, BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: widthSize(10),),
                  SvgPicture.asset(
                    share,
                    width: widthSize(30),
                    height: heightSize(30),
                    colorFilter: ColorFilter.mode(
                      sSentroLightGreen, BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SvgPicture.asset(logo, width: widthSize(136.53), height: heightSize(32),),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
