import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';

import '../constants/asset_path.dart';

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
                ? (widget.obscureOnIcon ?? Icon(Icons.visibility_off, color: iconColor))
                : (widget.obscureOffIcon ??
                SvgPicture.asset(hide, width: widthSize(24), height: heightSize(24))),
          ),
        ),
      );
    }

    if (widget.suffixWidget != null) {
      return Padding(
        padding: EdgeInsets.only(right: widthSize(21.23)),
        child: SizedBox(
          width: widthSize(widget.suffixWidth??48),
          child: Center(child: widget.suffixWidget),
        ),
      );
    }

    return null;
  }

  Widget? _resolvePrefix() {
    if (widget.prefixWidget == null) return null;
    return Padding(
      padding: EdgeInsets.only(
        top: heightSize(15),
        bottom: heightSize(15),
        right: widthSize(15),
      ),
      child: widget.prefixWidget,
    );
  }

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Values().buttonRadius10),
    borderSide: const BorderSide(color: Color(0xFF313131)),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;

    final borderColor = isDark ? sDarkBorder : sLightBorder;
    final hintColor   = widget.hintColor ?? (isDark ? sDarkHintText : sLightHintText);
    final textColor   = Theme.of(context).colorScheme.onSurface;
    final iconColor   = isDark ? sDarkHintText : sLightHintText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          widget.title!,
          const SizedBox(height: 6),
        ],
        Container(
          height: heightSize(widget.height ?? 58),
          width: size.width,
          margin: widget.hasBottomMargin
              ? const EdgeInsets.only(bottom: 10)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: isDark ? sDarkFill : Colors.transparent,
            border: Border.all(
              color: isDark ? sDarkBorder : sLightBorder,
            ),
            borderRadius: BorderRadius.circular(
              Values().buttonRadius10,
            ),
          ),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            expands: !_isObscured && widget.maxLines == null ? false : false, // ← always false now unless explicitly multiline
            maxLines: _isObscured ? 1 : (widget.maxLines ?? 1),
            minLines: null,
            readOnly: widget.readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: widget.enabled,
            controller: widget.controller,
            obscureText: _isObscured,
            validator: widget.validFunction,
            onChanged: widget.onSavedFunction,
            keyboardType: widget.inputType,
            cursorColor: Theme.of(context).colorScheme.primary,
            style: TextStyle(color: textColor, fontSize: fontSize(14)),
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,

              contentPadding: EdgeInsets.symmetric(
                horizontal: widthSize(16),
                vertical: heightSize(12),
              ),

              hintText: widget.hint,
              hintStyle: TextStyle(color: hintColor),

              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
              errorBorder: inputBorder,
              focusedErrorBorder: inputBorder,
              disabledBorder: inputBorder,

              errorStyle: const TextStyle(
                height: 0,
                fontSize: 0,
              ),

              // ── Naira prefix ──────────────────────────────────
              prefix: widget.showNairaPrefix
                  ? Padding(
                padding: EdgeInsets.only(right: widthSize(4)),
                child: Text(
                  '₦',
                  style: TextStyle(
                    fontSize: fontSize(14),
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                    color: textColor,
                  ),
                ),
              )
                  : null,

              prefixIcon: _resolvePrefix(),
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
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize(height ?? 48);
    final textColor   = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: width ?? size.width,
      padding: EdgeInsets.symmetric(
        vertical: heightSize(12),
        horizontal: widthSize(16),
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(7.5),
        border: Border.all(color: borderColor ?? sDarkBorder),
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
              validator: (value) => null,
              onChanged: (value) {
                if (onSavedFunction != null) onSavedFunction!(value);
                if (onChanged != null) onChanged!(value);
              },
              onFieldSubmitted: onSubmitFunction,
              keyboardType: inputType,
              textAlignVertical: TextAlignVertical.center,
              showCursor: true,
              cursorColor: Theme.of(context).colorScheme.primary,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: textColor, fontSize: fontSize(14)),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: TextStyle(
                  color: hintColor ?? sGrey2,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
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
                errorMaxLines: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}