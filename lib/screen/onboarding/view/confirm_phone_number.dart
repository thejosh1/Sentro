import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/pin_input.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  const ConfirmPhoneNumber({super.key,});

  @override
  State<ConfirmPhoneNumber> createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {
  late final String flow;
  TextEditingController otpController = TextEditingController();

  Timer? _timer;
  int _start = 45;
  bool counter = false;

  void startTimer() {
    counter = true;
    _start = 45;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            counter = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  resendToken() async {
    if (counter == false) {
      startTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    flow = Get.arguments?['flow'] ?? '';
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64),),
            PageHeader(
              trailing: SvgPicture.asset(
                headPhone,
                width: widthSize(43.52),
                height: heightSize(50),

              ),
            ),
            SizedBox(height: heightSize(30),),
            CText(
              text: 'Confirm Phone Number',
              fontWeight: FontWeight.w700,
              fontFamily: CFONT.BOLD,
              size: 22,
            ),
            SizedBox(height: heightSize(5),),
            RichText(
              text: TextSpan(
                text: 'Enter the code sent to',
                style: TextStyle(
                  color: isDark? sDarkModeMutedText : sLightModeMutedText,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                ),
                children: [
                  TextSpan(
                    text: '...6010',
                    style: TextStyle(
                      fontFamily: CFONT.BOLD,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: isDark?Colors.white:Colors.black,
                    )
                  )
                ]
              ),
            ),
            SizedBox(height: heightSize(30),),
            PinputField(
              controller: otpController,
            ),
            SizedBox(height: heightSize(30),),
            CText(
              text: "Didn't get code?",
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
              size: 16,
            ),
            SizedBox(height: heightSize(10),),
            Container(
              width: widthSize(174),
              height: heightSize(42),
              padding: EdgeInsets.symmetric(horizontal: widthSize(24), vertical: heightSize(12)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Values().buttonRadius22-1),
                color: isDark?sDarkFill:sResendCode,
                border: Border.all(color: isDark?sDarkBorder:sBorderLight)
              ),
              child: Row(
                children: [
                  CText(
                    text: 'Resend code',
                    size: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                  ),
                  SizedBox(width: widthSize(8),),
                  CText(
                    text: '$_start sec',
                    size: 13,
                    fontFamily: CFONT.MEDIUM,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: widthSize(25),
            right: widthSize(25),
            bottom: heightSize(10)),
        child: ActionButton(
          text: "Continue",
          callback: () {
            switch (flow) {
              case "bvn":
                Get.toNamed(Routes.confirmBvn);
                break;
              case "resetPassword":
                Get.toNamed(Routes.resetPassword);
                break;

              default:
                Get.toNamed(Routes.login);
            }
          },
          load: false,
        ),
      ),
    );
  }
}
