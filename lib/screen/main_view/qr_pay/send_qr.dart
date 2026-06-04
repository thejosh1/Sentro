import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';
import 'package:sentro/core/widgets/keyboard_pin.dart';

class SendQr extends StatefulWidget {
  const SendQr({super.key});

  @override
  State<SendQr> createState() => _SendQrState();
}

class _SendQrState extends State<SendQr> {
  TextEditingController pinController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  Future<void> _onSubmitAmount() async {
    final value = double.tryParse(controller.text.trim()) ?? 0;

    if (value <= 0) return;

    Get.toNamed(Routes.confirmPin);
  }

  bool get isComplete {
    final value = double.tryParse(controller.text.trim()) ?? 0;
    return value > 0;
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        final active = isComplete;

        // ── Consolidated Button Color Matrix ─────────────────────────────────
        Color buttonColor;
        if (active) {
          buttonColor = useAccent ? accent : (isDark ? sNavContainer : sActionButton);
        } else {
          if (useAccent) {
            buttonColor = accent.withOpacity(0.4);
          } else {
            buttonColor = isDark
                ? sNavContainer.withOpacity(0.4)
                : sActionButton.withOpacity(0.4);
          }
        }

        final textCol = active ? sActionButton : Colors.white.withOpacity(0.4);

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            widthSize(25), 0, widthSize(25), 0,
          ),
          child: Column(
            children: [
              SizedBox(height: heightSize(64)),

              // ── Header ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      arrowBackWhite,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent ? ColorFilter.mode(
                          accent, BlendMode.srcIn) : null,
                    ),
                  ),
                  BalancePill(isDark: isDark)
                ],
              ),

              SizedBox(height: heightSize(30)),
              CText(
                text: 'Send Money',
                size: 22,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wBold,
              ),
              SizedBox(height: heightSize(15)),
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
              SizedBox(height: heightSize(5)),
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
              SizedBox(height: heightSize(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    text: '₦',
                    size: 32,
                    fontWeight: CFONT.wRegular,
                    color: useAccent ? accent : (isDark ? sNavContainer : sActionButton),
                  ),
                  SizedBox(width: widthSize(8)),
                  CText(
                    text: controller.text.isEmpty ? '0' : controller.text,
                    size: 65,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wMedium,
                  ),
                ],
              ),
              SizedBox(height: heightSize(20)),
              KeyboardPin(
                controller: controller,
                callback: _onSubmitAmount,
                showBiometric: false,
              ),
              SizedBox(height: heightSize(21)),

              // ── Action Button ──────────────────────────────────────────────
              ActionButton(
                text: 'Continue',
                // Active configuration
                color: buttonColor,
                borderColor: buttonColor,
                textColor: textCol,
                // Disabled state configuration overrides fallback parameters
                disabledColor: buttonColor,
                disabledBorderColor: buttonColor,
                disabledTextColor: textCol,
                callback: active ? _onSubmitAmount : null,
              ),
              SizedBox(height: heightSize(61)),
            ],
          ),
        );
      }),
    );
  }
}