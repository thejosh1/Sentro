import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class InvestmentCategories extends StatelessWidget {
  const InvestmentCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.maxFinite,
      height: heightSize(144),
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
                    SvgPicture.asset(
                      addition,
                      width: widthSize(24),
                      height: heightSize(24),
                      colorFilter: isDark
                          ? null
                          : ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: widthSize(54),
                      height: heightSize(54),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: widget.progress),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return CustomPaint(
                            painter: _RoundedRectProgressPainter(
                              progress: value,
                              activeColor: isDark?sNavContainer:sActionButton,
                              inactiveColor: isDark?sNavContainer.withOpacity(0.4):sActionButton.withOpacity(0.4),
                              strokeWidth: 3,
                              radius: 16,
                            ),
                          );
                        },
                      ),
                    ),

                    SvgPicture.asset(
                      widget.assetName,
                      height: heightSize(49),
                      width: widthSize(49),
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
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

class _RoundedRectProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;
  final double radius;

  _RoundedRectProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    // ── inactive border ─────────────────────────
    final bgPaint = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, bgPaint);

    // ── active progress border ──────────────────
    final fgPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path()..addRRect(rrect);

    final metric = path.computeMetrics().first;

    final extractPath = metric.extractPath(
      0,
      metric.length * progress.clamp(0.0, 1.0),
    );

    canvas.drawPath(extractPath, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _RoundedRectProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}