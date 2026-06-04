// ignore_for_file: avoid_print, use_super_parameters
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';

import 'numeric_key.dart';

class KeyboardPin extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback callback;
  final VoidCallback? onBiometricPressed; // New: Biometric callback
  final bool showBiometric; // New: Show biometric button
  final bool isBiometricLoading; // New: Loading state for biometric

  const KeyboardPin({
    Key? key,
    required this.controller,
    required this.callback,
    this.onBiometricPressed,
    this.showBiometric = false,
    this.isBiometricLoading = false,
  }) : super(key: key);

  @override
  State<KeyboardPin> createState() => _KeyboardPinState();
}

class _KeyboardPinState extends State<KeyboardPin> {
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

  String text = '';
  final TextEditingController textController = TextEditingController();


  void _handlePinComplete() {
    // Only call the callback if PIN is complete (4 digits)
    if (widget.controller.text.length == 4) {
      widget.callback();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biometric Login Button (shown above keyboard if enabled)

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(text),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: NumericKeyboard(
                showBiometric: widget.showBiometric,
                onKeyboardTap: (value) {
                  setState(() {
                    // Only add digit if less than 4 digits
                    if (widget.controller.text.length < 4) {
                      widget.controller.text =
                          widget.controller.text + value.toString();
                      print(widget.controller.text);

                      // Automatically trigger callback when 4 digits are entered
                      if (widget.controller.text.length == 4) {
                        // Small delay to show the last digit before processing
                        Future.delayed(const Duration(milliseconds: 200), () {
                          _handlePinComplete();
                        });
                      }
                    }
                  });
                },
                textColor: Theme.of(context).colorScheme.onSurface,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                leftButtonFn: () {
                  setState(() {
                    if (widget.controller.text.isNotEmpty) {
                      widget.controller.text = widget.controller.text
                          .substring(0, widget.controller.text.length - 1);
                    }
                  });
                },
                leftIcon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: sCancel,
                ),
                // Right button now only works when PIN is complete
                rightButtonFn: _handlePinComplete,
                rightIcon: Icon(
                  Icons.arrow_forward_outlined,
                  size: 30,
                  color: widget.controller.text.length == 4 ? sDeepGreen : sDarkFill,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}