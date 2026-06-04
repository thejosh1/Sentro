import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';
import 'package:sentro/core/widgets/keyboard_pin.dart';

import '../../../core/constants/enums.dart';

class TransactionAction extends StatefulWidget {
  const TransactionAction({super.key});

  @override
  State<TransactionAction> createState() => _TransactionActionState();
}

class _TransactionActionState extends State<TransactionAction> {
  TextEditingController pinController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  late final TransactionActionType actionType;

  double _parseAmount(String text) {
    final cleanText = text.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanText) ?? 0;
  }

  Future<void> _onSubmitAmount() async {
    final value = _parseAmount(controller.text);
    if (value > 0) {
      Get.toNamed(Routes.confirmPin);
    }
  }

  bool get isComplete {
    final value = double.tryParse(controller.text.trim()) ?? 0;
    return value > 0;
  }

  @override
  void initState() {
    super.initState();
    actionType = Get.arguments ?? TransactionActionType.topUp;

    controller.addListener(() {
      setState(() {});
    });
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  bool get isWithdraw => actionType == TransactionActionType.withdraw;

  static const double usdToNgnRate = 1750;

  double get usdAmount {
    return double.tryParse(controller.text) ?? 0;
  }

  double get ngnAmount {
    return usdAmount * usdToNgnRate;
  }

  String get formattedNaira {
    return NumberFormat('#,##0.00').format(ngnAmount);
  }

  String get formattedInput {
    if (controller.text.isEmpty) return '0';

    // Splits decimal string gracefully to ensure smooth typing inputs
    final parts = controller.text.split('.');
    final intPart = double.tryParse(parts[0]) ?? 0;
    final formattedInt = NumberFormat('#,##0').format(intPart);

    return parts.length > 1 ? '$formattedInt.${parts[1]}' : formattedInt;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          widthSize(25), 0, widthSize(25), 0,
        ),
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          final active = isComplete;

          // ── Button Color State Matrix ──────────────────────────────────────
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

          return Column(
            children: [
              SizedBox(height: heightSize(64)),

              // ── Header ─────────────────────────────────────────────────────
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
                  BalancePill(isDark: isDark),
                ],
              ),

              SizedBox(height: heightSize(37.87)),
              CText(
                text: isWithdraw ? 'Withdraw' : 'Fund Card',
                size: 22,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wBold,
              ),
              SizedBox(height: heightSize(15)),
              CText(
                text: isWithdraw
                    ? 'Bal: \$275.05 (₦481,337.50)'
                    : 'Minimum of \$5 (₦8,750.00)',
                size: 18,
                fontWeight: CFONT.wRegular,
                color: sGrey2,
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
                    text: formattedInput,
                    size: 65,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wMedium,
                  ),
                ],
              ),
              SizedBox(height: heightSize(35)),
              CText(
                text: 'Naira Equivalent\n(₦$formattedNaira)',
                size: 18,
                fontWeight: CFONT.wRegular,
                color: isDark ? sGrey1 : sGrey2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: heightSize(20)),
              KeyboardPin(
                controller: controller,
                callback: () {},
                showBiometric: false,
              ),
              SizedBox(height: heightSize(21)),

              // ── Action Button ──────────────────────────────────────────────
              ActionButton(
                text: 'Continue',
                // Enabled Configuration
                color: buttonColor,
                borderColor: buttonColor,
                textColor: textCol,
                // Disabled Configuration (avoids internal sActionButton fallback)
                disabledColor: buttonColor,
                disabledBorderColor: buttonColor,
                disabledTextColor: textCol,
                callback: active ? _onSubmitAmount : null,
              ),
            ],
          );
        }),
      ),
    );
  }
}