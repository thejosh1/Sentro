import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
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
  bool _isRead = false;
  bool _isReset = false;

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
    _isReset = Get.arguments?['isReset'] == true;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightSize(64),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent
                          ? ColorFilter.mode(accent, BlendMode.srcIn)
                          : null,
                    ),
                  ),
                  SvgPicture.asset(
                    logoLight,
                    width: widthSize(116.39),
                    height: heightSize(28),
                    colorFilter: useAccent ? ColorFilter.mode(
                        accent, BlendMode.srcIn) : isDark ? ColorFilter.mode(
                      sNavContainer,
                      BlendMode.srcIn,
                    ) : null,
                  ),
                  SvgPicture.asset(
                    isDark ? headPhoneWhite : headPhone,
                    width: widthSize(43.52),
                    height: heightSize(50),
                  )
                ],
              ),
              SizedBox(height: heightSize(30),),
              CText(
                text: 'Confirm Phone Number',
                fontWeight: CFONT.wBold,
                fontFamily: CFONT.FAMILY,
                size: 22,
              ),
              SizedBox(height: heightSize(5),),
              RichText(
                text: TextSpan(
                  text: 'Enter the code sent to',
                  style: TextStyle(
                    color: isDark ? sDarkModeMutedText : sLightModeMutedText,
                    fontSize: 18,
                    fontWeight: CFONT.wRegular,
                    fontFamily: CFONT.FAMILY,
                  ),
                  children: [
                    TextSpan(
                      text: '...6010',
                      style: TextStyle(
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wBold,
                        fontSize: 18,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightSize(30),),
              PinputField(
                controller: otpController,
              ),
              SizedBox(height: heightSize(30),),
              CText(
                text: "Didn't get code?",
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                size: 16,
              ),
              SizedBox(height: heightSize(10),),
              Container(
                // width: widthSize(174),
                // height: heightSize(42),
                padding: EdgeInsets.symmetric(
                    horizontal: widthSize(24), vertical: heightSize(12)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      Values().buttonRadius22 - 1),
                  color: Colors.transparent,
                  border: Border.all(
                      color: useAccent ? accent : isDark
                          ? sNavContainer
                          : sActionButton),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CText(
                      text: 'Resend code',
                      size: 13,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                    ),
                    SizedBox(width: widthSize(8),),
                    CText(
                      text: '$_start sec',
                      size: 13,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if(_isReset) ...[
                Column(
                  children: [
                    SizedBox(height: heightSize(30)),
                    Container(
                      //height: heightSize(85),
                      padding: EdgeInsets.symmetric(horizontal: widthSize(15), vertical: heightSize(13)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.17),
                        border: Border.all(color: sSentroLightGreen),
                        color: sSentroLightGreen.withOpacity(0.25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CText(
                                text: 'Terms and conditions',
                                size: 14,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wMedium,
                              ),
                              SizedBox(height: heightSize(5),),
                              SizedBox(
                                width: widthSize(263),
                                child: CText(
                                  text: 'By confirming, you authorise Sentro to debit your selected funding source. For Fixed Deposits and T-Bills, funds are locked until maturity.',
                                  size: 12,
                                  fontWeight: CFONT.wRegular,
                                  fontFamily: CFONT.FAMILY,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: widthSize(12),),
                          GestureDetector(
                            onTap: () => setState(() => _isRead = !_isRead),
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
                                color: _isRead ? sNavContainer : sDarkBorder,
                              ),
                              child: Row(
                                mainAxisAlignment: _isRead
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
                    ),
                  ],
                ),
              ]
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: widthSize(25),
          right: widthSize(25),
          bottom: heightSize(10),
        ),
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          return ActionButton(
            text: "Continue",
            color: useAccent?accent:null,
            borderColor: useAccent?accent:null,
            textColor: sNavContainer,
            callback: () {
              FocusScope.of(context).unfocus();
              if (_isReset) {
                Get.toNamed(Routes.faceVerification, arguments: {
                  'isReset': true,
                });
              } else {
                // Standard non-reset fallback routes
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
              }
            },
            load: false,
          );
        }),
      ),
    );
  }
}