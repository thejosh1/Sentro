import 'package:flutter/material.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';

class CFONT {
  static const SEMIBOLD = "perfectly-vintages-font-by-keithzo";
  static const BOLD = "Satoshi-Bold";
  static const MEDIUM = "Satoshi-Medium";
  static const REGULAR = "Satoshi-Regular";
  static const ITALIC = "Satoshi";
}

class CText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  final String? fontFamily;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final double? height;
  final bool? allowOverflow;
  final TextDecoration? decoration;
  final Color? backgroundColor;
  final FontStyle? fontStyle;

  const CText({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.onClick,
    this.fontFamily,
    this.letterSpacing,
    this.textAlign,
    this.height,
    this.decoration,
    this.allowOverflow = false,
    this.backgroundColor,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? Theme.of(context).colorScheme.onSurface;

    if (onClick == null) {
      return Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        softWrap: true,
        overflow: TextOverflow.visible,
        //maxLines: 1,
        style: TextStyle(
          fontStyle: fontStyle ?? FontStyle.normal,
          fontSize: fontSize(size ?? 16),
          fontWeight: fontWeight ?? FontWeight.w400,
          fontFamily: fontFamily,
          color: defaultColor,
          height: height ?? 1,
          decoration: decoration ?? TextDecoration.none,
          backgroundColor: backgroundColor,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ),
      );
    }

    return TextButton(
      onPressed: () => onClick?.call(),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize(size ?? 16),
          fontWeight: fontWeight ?? FontWeight.w400,
          fontFamily: fontFamily,
          color: defaultColor,
        ),
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final String title;
  final double? size;
  final bool? required;
  final FontWeight? fontWeight;
  final bool? isPersonalInformation;

  const TextTitle({
    required this.title,
    this.size,
    this.required = false,
    this.fontWeight,
    this.isPersonalInformation = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = Theme.of(context).colorScheme.onSurface;
    final requiredColor = Theme.of(context).colorScheme.error;

    final titleSpan = RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: fontSize(size ?? 16),
          fontWeight: fontWeight ?? FontWeight.w600,
          color: titleColor,
        ),
        children: required == true
            ? [
          TextSpan(
            text: " *",
            style: TextStyle(color: requiredColor),
          ),
        ]
            : [],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleSpan,
        const SizedBox(height: 10)
      ],
    );
  }
}

class TextNaira extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? nairaColor;

  const TextNaira({
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.nairaColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedColor =
        color ?? Theme.of(context).colorScheme.onSurface;

    final resolvedNairaColor =
        nairaColor ?? resolvedColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "₦",
          style: TextStyle(
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: size ?? 16,
            color: resolvedNairaColor,
            height: 1.2,
          ),
        ),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: size ?? 16,
            color: resolvedColor,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}