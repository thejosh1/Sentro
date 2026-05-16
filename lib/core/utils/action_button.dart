import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/values.dart';

import 'text.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? callback;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final bool load;
  final FontWeight? fontWeight;
  final double? height;
  final double? fontSize;

  const ActionButton({
    super.key,
    required this.text,
    this.callback,
    this.color,
    this.textColor,
    this.borderColor,
    this.disabledColor,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.load = false,
    this.fontWeight,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final bool enabled = callback != null && load == false;
    final bg     = enabled
        ? (color ?? sActionButton)
        : (disabledColor ?? sActionButton.withOpacity(0.8));
    final bord   = enabled
        ? (borderColor ?? sActionButton)
        : (disabledBorderColor ?? sActionButton.withOpacity(0.3));
    final txtCol = enabled
        ? (textColor ?? Colors.white)
        : (disabledTextColor ?? Colors.white.withOpacity(0.6));

    return GestureDetector(
      onTap: load ? null : callback,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height ?? 58,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Values().buttonRadius10+1.17),
          border: Border.all(width: 1, color: bord),
        ),
        child: Center(
          child: load
              ? const _RollingLogo()  // always uses the baked-in SVG
              : CText(
            text: text,
            fontFamily: CFONT.MEDIUM,
            fontWeight: fontWeight ?? FontWeight.w600,
            size: fontSize ?? 16,
            color: txtCol,
          ),
        ),
      ),
    );
  }
}

class _RollingLogo extends StatefulWidget {
  const _RollingLogo();

  @override
  State<_RollingLogo> createState() => _RollingLogoState();
}

class _RollingLogoState extends State<_RollingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => Transform.rotate(
        angle: _controller.value * 2 * 3.14159265,
        child: child,
      ),
      child: SvgPicture.asset(
        logo1x,
        width: 36,
        height: 36,
      ),
    );
  }
}
