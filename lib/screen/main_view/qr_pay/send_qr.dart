import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/keyboard_pin.dart';

class SendQr extends StatefulWidget {
  const SendQr({super.key});

  @override
  State<SendQr> createState() => _SendQrState();
}

class _SendQrState extends State<SendQr> {
  TextEditingController pinController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  Future<void> _onSubmitPin() async {
    final pin = controller.text.trim();
    if (pin.length < 4) {
      // cToast(title: "Invalid PIN", message: "Enter your 4-digit PIN", color: kRed);
      return;
    } else {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          widthSize(25), 0, widthSize(25), 0,
        ),
        child: Column(
          children: [
            SizedBox(height: heightSize(64),),
            // ── Header ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(arrowBackWhite, width: widthSize(42), height: heightSize(42)),
                ),
                Container(
                  width: widthSize(170.01),
                  height: heightSize(34.18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124.89),
                    color: sDarkFill,
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
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                height: 22.65 / 15.86,
                              ),
                            ),
                            TextSpan(
                              text: '.00',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                height: 22.65 / 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: widthSize(3.75)),
                      SvgPicture.asset(visibilityOff, width: widthSize(24), height: heightSize(24)),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: heightSize(30),),
            CText(
              text: 'Send Money',
              size: 22,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(15),),
            Container(
              width: widthSize(55),
              height: heightSize(55),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(sentroTag),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: '@richmond',
              fontWeight: CFONT.wMedium,
              size: 18,
              fontFamily: CFONT.FAMILY,
            ),
            CText(
              text: 'Richmond Uche',
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: sAccountColor,
            ),
            SizedBox(height: heightSize(80),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  text: '₦',
                  size: 32,
                  fontWeight: CFONT.wRegular,
                 // fontFamily: CFONT.FAMILY,
                ),
                SizedBox(width: widthSize(8),),
                CText(
                  text: '0',
                  size: 65,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                ),
              ],
            ),
            SizedBox(height: heightSize(103),),
            KeyboardPin(
              controller: controller,
              callback: _onSubmitPin,
              showBiometric: false,
            ),
            SizedBox(height: heightSize(61),),
          ],
        ),
      ),
    );
  }
}