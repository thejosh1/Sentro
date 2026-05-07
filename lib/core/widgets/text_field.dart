import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
// import 'package:flutter_svg/svg.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final String error;
  final String? Function(String?) validFunction;
  final Function(String)? onSavedFunction;
  final Function(String)? onSubmitFunction;
  final Color? color;
  final Color? hintColor;
  final bool? enabled;
  final double? height;
  final bool? obscureText;
  final bool readOnly;
  final ValueChanged<bool>? onToggle;
  final Widget? title;

  const AppTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.error,
    required this.validFunction,
    this.onSavedFunction,
    this.color,
    this.onSubmitFunction,
    this.enabled = true,
    this.height,
    this.hintColor,
    this.obscureText = false,
    this.readOnly = false,
    this.onToggle,
    this.title
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText!;
  }

  void _toggle() {
    setState(() => _isObscured = !_isObscured);
    widget.onToggle?.call(_isObscured);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;

    // ── colors that switch per mode ──────────────────────────────
    final borderColor = isDark
        ? sDarkBorder
        : sLightBorder;

    final hintColor = widget.hintColor ?? (isDark
        ? sDarkHintText          // readable on dark bg
        : sLightHintText);        // your light mode spec

    final textColor = Theme.of(context).colorScheme.onSurface;
    // #111111 light / #FFFFFF dark

    final fillColor = widget.color ?? (isDark
        ? sDarkFill          // card surface dark
        : const Color(0xFFFFFFFF));        // white light

    final iconColor = isDark
        ? sDarkHintText
        : sLightHintText;
    // ─────────────────────────────────────────────────────────────

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          widget.title!,
          const SizedBox(height: 6),
        ],

        Container(
          height: heightSize(widget.height ?? 56),
          width: size.width,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(Values().buttonRadius10),
          ),
          child: TextFormField(
            readOnly: widget.readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: widget.enabled,
            controller: widget.controller,
            obscureText: _isObscured,
            validator: widget.validFunction,
            onChanged: widget.onSavedFunction,
            keyboardType: widget.inputType,
            cursorColor: Theme.of(context).colorScheme.primary,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize(14),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: widthSize(24),
                vertical: widget.height == null ? 0.0 : widget.height! / 10,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(color: hintColor),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              suffixIcon: widget.obscureText == true
                  ? SizedBox(
                width: 48,
                child: Center(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                    onPressed: _toggle,
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: iconColor,
                    ),
                  ),
                ),
              )
                  : null,
              suffixIconConstraints:
              const BoxConstraints(minWidth: 40, minHeight: 40),
            ),
          ),
        ),
      ],
    );
  }
}