import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/utils/text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';

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
  final Widget? obscureOnIcon;
  final Widget? obscureOffIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool hasBottomMargin;
  final bool showNairaPrefix;
  final int? maxLines;
  final num? suffixWidth;
  final List<TextInputFormatter>? inputFormatters;
  final double? verticalPadding;

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
    this.title,
    this.obscureOnIcon,
    this.obscureOffIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.hasBottomMargin = true,
    this.showNairaPrefix = false,
    this.maxLines,
    this.suffixWidth,
    this.inputFormatters,
    this.verticalPadding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText ?? false;
  }

  void _toggle() {
    setState(() => _isObscured = !_isObscured);
    widget.onToggle?.call(_isObscured);
  }

  bool get _isMultiline => (widget.maxLines ?? 1) > 1;

  Widget? _resolveSuffix(Color iconColor) {
    if (widget.obscureText == true) {
      return SizedBox(
        width: 48,
        child: Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
            onPressed: _toggle,
            icon: _isObscured
                ? (widget.obscureOnIcon ??
                Icon(Icons.visibility_off, color: iconColor))
                : (widget.obscureOffIcon ??
                SvgPicture.asset(
                  hide,
                  width: widthSize(24),
                  height: heightSize(24),
                )),
          ),
        ),
      );
    }

    if (widget.suffixWidget != null) {
      return Padding(
        padding: EdgeInsets.only(right: widthSize(21.23)),
        child: SizedBox(
          width: widthSize(widget.suffixWidth ?? 48),
          child: Center(child: widget.suffixWidget),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final accent = AccentController.to.accent.value;
    final isDefaultAccent =
        AccentController.options.first.value == accent.value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hintColor =
        widget.hintColor ?? (isDark ? sDarkHintText : sLightHintText);
    final textColor = Theme.of(context).colorScheme.onSurface;
    final iconColor = isDark ? sDarkHintText : sLightHintText;
    final baseBorderColor = isDark ? sDarkBorder : sLightBorder;

    final borderColor = isDefaultAccent
        ? baseBorderColor
        : accent.withOpacity(0.4);
    final fillColor = isDark ? sDarkFill : Colors.transparent;

    const double _vPad = 20;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Values().buttonRadius10),
      borderSide: BorderSide(color: borderColor),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          widget.title!,
          SizedBox(height: heightSize(8)),
        ],
        Container(
          height: _isMultiline ? (widget.height != null ? heightSize(widget.height!) : null) : null,
          margin: widget.hasBottomMargin
              ? const EdgeInsets.only(bottom: 10)
              : EdgeInsets.zero,
          child: TextFormField(
            textAlignVertical: _isMultiline
                ? TextAlignVertical.top
                : TextAlignVertical.center,
            maxLines: _isObscured ? 1 : widget.maxLines,
            minLines: null,
            expands: false,
            readOnly: widget.readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: widget.enabled,
            controller: widget.controller,
            obscureText: _isObscured,
            validator: widget.validFunction,
            onChanged: widget.onSavedFunction,
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,
            cursorColor: Theme.of(context).colorScheme.primary,
            cursorHeight: fontSize(18),
            style: TextStyle(
              color: textColor,
              fontSize: fontSize(14),
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              height: 1.0,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              contentPadding: _isMultiline
                  ? EdgeInsets.symmetric(
                horizontal: widthSize(16.76),
                vertical: heightSize(16),
              )
                  : EdgeInsets.only(
                left: widget.showNairaPrefix
                    ? widthSize(4)
                    : widthSize(16.76),
                right: widthSize(24),
                top: widget.verticalPadding ?? _vPad,
                bottom: widget.verticalPadding ?? _vPad,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: hintColor,
                fontSize: fontSize(14),
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                height: 1.0,
              ),
              border: border,
              enabledBorder: border,
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(Values().buttonRadius10),
                borderSide: BorderSide(
                  color: isDefaultAccent
                      ? Theme.of(context).colorScheme.primary
                      : accent,
                  width: 1.5,
                ),
              ),
              errorBorder: border,
              focusedErrorBorder: border,
              disabledBorder: border,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              prefixIcon: widget.showNairaPrefix
                  ? Padding(
                padding: EdgeInsets.only(
                  left: widthSize(16.76),
                  right: widthSize(6),
                ),
                child: IntrinsicWidth(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '₦',
                      style: TextStyle(
                        inherit: false,
                        fontSize: fontSize(14),
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              )
                  : widget.prefixWidget != null
                  ? Padding(
                padding: EdgeInsets.only(
                  left: widthSize(12),
                  right: widthSize(4),
                ),
                child: IntrinsicWidth(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.prefixWidget,
                  ),
                ),
              )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 0,
                minWidth: 0,
              ),
              suffixIcon: _resolveSuffix(iconColor),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Date Formatter ───────────────────────────────────────────────────────────

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 8) text = text.substring(0, 8);

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) buffer.write('/');
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// ── Naira Currency Formatter ──────────────────────────────────────────────────

class NairaInputFormatter extends TextInputFormatter {
  final _formatter = NumberFormat('#,###', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(text: '');
    }

    // Isolate pure input payload (allow digits and a single optional period)
    String cleanText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Halt formatting execution if multiple decimals are typed
    if (cleanText.split('.').length > 2) {
      return oldValue;
    }

    // Limit decimal inputs directly to a maximum of 2 spaces
    if (cleanText.contains('.')) {
      final parts = cleanText.split('.');
      if (parts[1].length > 2) {
        cleanText = '${parts[0]}.${parts[1].substring(0, 2)}';
      }
    }

    String integerPart = cleanText;
    String decimalPart = '';

    if (cleanText.contains('.')) {
      final parts = cleanText.split('.');
      integerPart = parts[0];
      decimalPart = parts.length > 1 ? parts[1] : '';
    }

    // Apply thousands comma grouping to the whole number section
    if (integerPart.isNotEmpty) {
      final parsedValue = double.tryParse(integerPart);
      if (parsedValue != null) {
        integerPart = _formatter.format(parsedValue);
      }
    }

    // Stitch the complete currency representation back together
    String formattedText = integerPart;
    if (cleanText.contains('.')) {
      formattedText += '.$decimalPart';
    }

    // Calculate selection offset based on non-comma string data
    int originalCursorPos = newValue.selection.baseOffset;
    int nonCommaCountBeforeCursor = 0;
    for (int i = 0; i < originalCursorPos && i < newValue.text.length; i++) {
      if (newValue.text[i] != ',') {
        nonCommaCountBeforeCursor++;
      }
    }

    int targetCursorPos = 0;
    int trackingCount = 0;
    while (targetCursorPos < formattedText.length && trackingCount < nonCommaCountBeforeCursor) {
      if (formattedText[targetCursorPos] != ',') {
        trackingCount++;
      }
      targetCursorPos++;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: targetCursorPos),
    );
  }
}
// ── Search field ──────────────────────────────────────────────────────────────

class AuthSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType inputType;
  final String hint;
  final String error;
  final Function validFunction;
  final ValueChanged<String>? onSavedFunction;
  final ValueChanged<String>? onChanged;
  final Function(String)? onSubmitFunction;
  final Color? color;
  final Color? hintColor;
  final bool? enabled;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;

  const AuthSearchField({
    super.key,
    this.controller,
    required this.hint,
    required this.inputType,
    required this.error,
    required this.validFunction,
    this.onSavedFunction,
    this.onChanged,
    this.onSubmitFunction,
    this.color,
    this.enabled = true,
    this.height,
    this.width,
    this.hintColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final accent = AccentController.to.accent.value;
    final isDefaultAccent =
        AccentController.options.first.value == accent.value;

    final baseBorder = borderColor ?? sDarkBorder;

    return Container(
      width: width ?? double.maxFinite,
      height: height != null ? heightSize(height!) : null, // ← use height
      padding: EdgeInsets.symmetric(
        vertical: heightSize(12),
        horizontal: widthSize(16),
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 7.5), // ← use radius
        border: Border.all(
          color: isDefaultAccent ? baseBorder : accent.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            search,
            width: widthSize(16),
            height: heightSize(16),
            colorFilter: const ColorFilter.mode(sGrey2, BlendMode.srcIn),
          ),
          SizedBox(width: widthSize(10)),
          Expanded(
            child: TextFormField(
              controller: controller,
              autovalidateMode: AutovalidateMode.disabled,
              enabled: enabled,
              validator: (_) => null,
              onChanged: (v) {
                onSavedFunction?.call(v);
                onChanged?.call(v);
              },
              onFieldSubmitted: onSubmitFunction,
              keyboardType: inputType,
              textAlignVertical: TextAlignVertical.center,
              showCursor: true,
              cursorColor: Theme.of(context).colorScheme.primary,
              cursorHeight: fontSize(16),
              textInputAction: TextInputAction.search,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize(14),
                fontFamily: CFONT.FAMILY,
                height: 1.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.transparent,
                hintText: hint,
                hintStyle: TextStyle(
                  color: hintColor ?? sGrey2,
                  fontSize: fontSize(12),
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                  height: 1.0,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                isCollapsed: true,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}