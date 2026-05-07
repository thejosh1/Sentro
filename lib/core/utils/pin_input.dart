import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/utils/text.dart';

class PinputField extends StatefulWidget {
  final TextEditingController controller;
  const PinputField({super.key, required this.controller});

  @override
  State<PinputField> createState() => _PinputFieldState();
}

class _PinputFieldState extends State<PinputField> {
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor    = isDark ? sDarkBorder : sLightBorder;
    final textColor      = Theme.of(context).colorScheme.onSurface;
    final focusedColor   = const Color(0xFF0F403B);   // sActionButton
    final submittedColor = const Color(0xFF0F403B);   // sActionButton

    final defaultPinTheme = PinTheme(
      width: 58,
      height: 58,
      textStyle: TextStyle(
        fontSize: 22,
        color: textColor,
        fontFamily: CFONT.SEMIBOLD,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        color: isDark
            ? const Color(0xFF252525)   // card surface dark
            : const Color(0xFFFFFFFF),  // white light
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // ✅ left-leaning
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: widget.controller,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              length: 4,
              separatorBuilder: (index) => const SizedBox(width: 14),
              validator: (value) => null,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) => debugPrint('onCompleted: $pin'),
              onChanged: (value) => debugPrint('onChanged: $value'),
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedColor,
                  ),
                ],
              ),
              // focused — green border, same bg
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: focusedColor, width: 1.5),
                ),
              ),
              // submitted — filled with sActionButton
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(10),
                  color: submittedColor,
                  border: Border.all(color: submittedColor),
                ),
                textStyle: TextStyle(
                  fontSize: 22,
                  color: const Color(0xFFC2E96A),  // lime on dark green
                  fontFamily: CFONT.SEMIBOLD,
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinputField2 extends StatefulWidget {
  final TextEditingController controller;
  const PinputField2({super.key, required this.controller});

  @override
  State<PinputField2> createState() => _PinputField2State();
}

class _PinputField2State extends State<PinputField2> {
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor    = isDark ? sDarkBorder : sLightBorder;
    final textColor      = Theme.of(context).colorScheme.onSurface;
    final focusedColor   = const Color(0xFF0F403B);
    final submittedColor = const Color(0xFF0F403B);

    final defaultPinTheme = PinTheme(
      width: 58,
      height: 58,
      textStyle: TextStyle(
        fontSize: 22,
        color: textColor,
        fontFamily: CFONT.SEMIBOLD,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        color: isDark
            ? const Color(0xFF252525)
            : const Color(0xFFFFFFFF),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              obscureText: true,
              controller: widget.controller,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              length: 4,
              separatorBuilder: (index) => const SizedBox(width: 32),
              validator: (value) => null,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) => debugPrint('onCompleted: $pin'),
              onChanged: (value) => debugPrint('onChanged: $value'),
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: focusedColor, width: 1.5),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(10),
                  color: submittedColor,
                  border: Border.all(color: submittedColor),
                ),
                textStyle: TextStyle(
                  fontSize: 22,
                  color: const Color(0xFFC2E96A),
                  fontFamily: CFONT.SEMIBOLD,
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}