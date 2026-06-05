import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class InvestmentCategories extends StatelessWidget {
  const InvestmentCategories({super.key});

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: widthSize(13),
        top: heightSize(9),
        right: widthSize(13),
        bottom: heightSize(15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values().buttonRadius20),
        color: isDark ? sContainerColor : sLightFill,
        boxShadow: isDark
            ? null
            : [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header ───────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                text: 'Investment & Savings',
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                size: 14,
                height: 1.67,
                color: colorScheme.onSurface,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.startSaving);
                },
                child: Row(
                  children: [
                    CText(
                      text: 'New Goal',
                      size: 14,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      color: isDark
                          ? colorScheme.onSurface
                          : colorScheme.primary,
                    ),
                    SizedBox(width: widthSize(5)),
                    Obx(() {
                      final accent = AccentController.to.accent.value;
                      final useAccent = !_isDefaultAccent(accent);
                      return SvgPicture.asset(
                        addition,
                        width: widthSize(24),
                        height: heightSize(24),
                        colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):isDark
                            ? null
                            : ColorFilter.mode(
                          colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: heightSize(10)),

          // ── Items row ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              investmentItem(
                assetName: birthday,
                title: 'My Birthday',
                progress: 0.75,
                colorScheme: colorScheme,
                callback: () {
                  Get.toNamed(Routes.activeGoals);
                },
              ),
              investmentItem(
                assetName: car,
                title: 'New Car',
                progress: 0.45,
                colorScheme: colorScheme,
                callback: () {
                  Get.toNamed(Routes.activeGoals);
                },
              ),
              investmentItem(
                assetName: house,
                title: 'New House',
                progress: 0.90,
                colorScheme: colorScheme,
                callback: () {
                  Get.toNamed(Routes.activeGoals);
                },
              ),
              investmentItem(
                assetName: plane,
                title: 'Travel Plans',
                colorScheme: colorScheme,
                progress: 0.25,
                callback: () {
                  Get.toNamed(Routes.activeGoals);
                },
              ),
              investmentItem(
                assetName: utilities,
                title: 'Utilities',
                progress: 0.50,
                colorScheme: colorScheme,
                callback: () {
                  Get.toNamed(Routes.activeGoals);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── ITEM WRAPPER ───────────────────────────────────────────────

Widget investmentItem({
  required String assetName,
  required String title,
  required ColorScheme colorScheme,
  required VoidCallback callback,
  double progress = 0.0,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    colorScheme: colorScheme,
    onTap: callback,
    progress: progress,
  );
}

// ── ANIMATED ITEM ──────────────────────────────────────────────

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final double progress;

  const _AnimatedCategoryItem({
    required this.assetName,
    required this.title,
    required this.colorScheme,
    required this.onTap,
    this.progress = 0.0,
  });

  @override
  State<_AnimatedCategoryItem> createState() => _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<_AnimatedCategoryItem> {
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedScale(
      scale: _pressed ? 0.92 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _pressed ? 0.7 : 1.0,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Column(
            children: [
              AnimatedScale(
                scale: _pressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Obx(() {
                  final accent = AccentController.to.accent.value;
                  final useAccent = !_isDefaultAccent(accent);
                  final activeColor = useAccent ? accent : isDark ? sNavContainer : sActionButton;

                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: widget.progress),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return SizedBox(
                        width: widthSize(60),  // slightly larger to fit stroke around container
                        height: heightSize(60),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Progress ring drawn around the container
                            CustomPaint(
                              size: Size(widthSize(63), heightSize(63)),
                              painter: _CircularProgressPainter(
                                progress: value,
                                activeColor: activeColor,
                                strokeWidth: 2.5,
                              ),
                            ),

                            // White rounded container with SVG inside
                            Container(
                              width: widthSize(55.88),
                              height: heightSize(55.88),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  widget.assetName,
                                  height: heightSize(30),
                                  width: widthSize(30),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text: widget.title,
                size: 12,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                height: 1.67,
                color: widget.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    // inactive track — transparent, so nothing drawn
    // active arc
    if (progress > 0) {
      final fgPaint = Paint()
        ..color = activeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,                    // start from top
        2 * math.pi * progress.clamp(0.0, 1.0),
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.activeColor != activeColor;
  }
}