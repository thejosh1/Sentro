import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
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
        borderRadius: BorderRadius.circular(Values().buttonRadius10),
        // Dark: existing dark container; Light: AppTheme surface
        color: isDark ? sContainerColor : colorScheme.surface,
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
          // ── Header row ───────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                text: 'Investment & Savings',
                fontFamily: CFONT.MEDIUM,
                fontWeight: FontWeight.w500,
                size: 14,
                height: 1.67,
                color: colorScheme.onSurface,
              ),
              Row(
                children: [
                  CText(
                    text: 'New Goal',
                    size: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                    // Light: use primary green for the action label
                    color: isDark
                        ? colorScheme.onSurface
                        : colorScheme.primary,
                  ),
                  SizedBox(width: widthSize(5)),
                  SvgPicture.asset(
                    addition,
                    width: widthSize(24),
                    height: heightSize(24),
                    // Light: tint the + icon with primary green
                    colorFilter: isDark
                        ? null
                        : ColorFilter.mode(
                      colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: heightSize(14)),

          // ── Investment items row ──────────────────────────────────
          // Investment icons are colourful illustrations (birthday cake,
          // car, house, plane, utilities) — no tinting applied so their
          // original Figma palette shows through in both themes.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              investmentItem(
                  assetName: birthday,
                  title: 'My Birthday',
                  colorScheme: colorScheme,
                  callback: () {}),
              investmentItem(
                  assetName: car,
                  title: 'New Car',
                  colorScheme: colorScheme,
                  callback: () {}),
              investmentItem(
                  assetName: house,
                  title: 'New House',
                  colorScheme: colorScheme,
                  callback: () {}),
              investmentItem(
                  assetName: plane,
                  title: 'Travel Plans',
                  colorScheme: colorScheme,
                  callback: () {}),
              investmentItem(
                  assetName: utilities,
                  title: 'Utilities',
                  colorScheme: colorScheme,
                  callback: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

Widget investmentItem({
  required String assetName,
  required String title,
  required ColorScheme colorScheme,
  required VoidCallback callback,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    colorScheme: colorScheme,
    onTap: callback,
  );
}

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _AnimatedCategoryItem({
    required this.assetName,
    required this.title,
    required this.colorScheme,
    required this.onTap,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _pressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 120),
                // Investment icons are full-colour illustrations —
                // no colorFilter so they render with their original hues.
                child: SvgPicture.asset(
                  widget.assetName,
                  height: heightSize(55.88),
                  width: widthSize(55.88),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text: widget.title,
                size: 12,
                fontWeight: FontWeight.w400,
                fontFamily: CFONT.REGULAR,
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