import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';

import 'keyboard_pin.dart';

class ConfirmTransaction extends StatefulWidget {
  const ConfirmTransaction({super.key});

  @override
  State<ConfirmTransaction> createState() => _ConfirmTransactionState();
}

class _ConfirmTransactionState extends State<ConfirmTransaction> {
  TextEditingController pinController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  // Track incorrect pin validation attempts
  int _remainingAttempts = 5;

  Future<void> _onSubmitPin() async {
    final pin = controller.text.trim();
    if (pin.length < 4) return;

    final accent = AccentController.to.accent.value;
    final useAccent = !_isDefaultAccent(accent);

    // TODO: Replace this conditional check with your production API authentication check
    // Simulating validation: let's assume '1234' is the correct pin for testing
    bool isCorrectPin = (pin == '1234');

    if (isCorrectPin) {
      final args = Get.arguments as Map<String, dynamic>?;
      final isCardCreation = args?['isCardCreation'] == true;
      final isPayAccountCreation = args?['isPayAccountCreation'] == true;

      if (isCardCreation) {
        Get.offAllNamed(Routes.mainView, arguments: {
          'cardCreated': true,
          'goToTab': 3,
        });
      } else if (isPayAccountCreation) {
        Get.offAllNamed(Routes.mainView, arguments: {
          'payAccountCreated': true,
          'goToTab': 4,
        });
      } else {
        Get.back();
      }
    } else {
      // Clear input pad immediately for security and handle error state counter
      controller.clear();
      setState(() {
        if (_remainingAttempts > 0) _remainingAttempts--;
      });

      _showIncorrectPinDialog(useAccent, accent);
    }
  }

  // ── Incorrect PIN Dialog Overlay ───────────────────────────────────────────
  void _showIncorrectPinDialog(bool useAccent, Color accent) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: widthSize(28)),
          child: Container(
            padding: EdgeInsets.fromLTRB(
                widthSize(25), heightSize(67), widthSize(25), heightSize(45)
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF262626) : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom Built Mock Representation of Error Asset Icon
                SvgPicture.asset(incorrectPin, width: widthSize(78.5),
                  height: heightSize(71),),

                SizedBox(height: heightSize(24)),

                CText(
                  text: 'Incorrect PIN',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  color: isDark ? Colors.white : Colors.black,
                ),

                SizedBox(height: heightSize(24)),

                CText(
                  text: 'You have entered an incorrect PIN. You have $_remainingAttempts more attempts before your account will be locked',
                  size: 14,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                  color: isDark ? Colors.white : Colors.black,
                  textAlign: TextAlign.center,
                  height: 1.4,
                ),

                SizedBox(height: heightSize(35)),

                // Try Again Button Action wrapper
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: double.maxFinite,
                    height: heightSize(54),
                    decoration: BoxDecoration(
                      color: useAccent ? accent : isDark
                          ? sNavContainer
                          : sActionButton,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: CText(
                        text: 'Try Again',
                        size: 16,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        color: sActionButton,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightSize(32)),

                // Reset PIN trigger flow text link
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                        Routes.confirmPin, arguments: {'isReset': true});
                  },
                  child: CText(
                    text: 'Reset PIN',
                    size: 15,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: useAccent ? accent : sNavContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
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
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
          child: Column(
            children: [
              SizedBox(height: heightSize(64)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                      logo, width: widthSize(116.39), height: heightSize(28), colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,),
                  const Spacer(),
                  SvgPicture.asset(isDark ? headPhoneWhite : headPhone,
                      width: widthSize(43.52), height: heightSize(50)),
                ],
              ),
              SizedBox(height: heightSize(31)),
              CText(
                text: 'Confirm your 4 Digit PIN',
                size: 22,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wBold,
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text: 'Authorise this action',
                fontWeight: CFONT.wRegular,
                size: 18,
                fontFamily: CFONT.FAMILY,
                color: isDark ? sDarkModeMutedText : sLightModeMutedText,
              ),
              SizedBox(height: heightSize(30)),
              Container(
                width: widthSize(156),
                height: heightSize(47),
                padding: EdgeInsets.symmetric(horizontal: widthSize(16)),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Values().buttonRadius20 * 5),
                  color: useAccent ? accent : sNavContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(4, (index) {
                    final isFilled = index < controller.text.length;

                    return Container(
                      width: widthSize(18),
                      height: heightSize(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled
                            ? sActionButton
                            : Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              const Spacer(),
              KeyboardPin(
                controller: controller,
                callback: _onSubmitPin,
                showBiometric: true,
              ),
              SizedBox(height: heightSize(67)),
            ],
          ),
        );
      }),
    );
  }
}