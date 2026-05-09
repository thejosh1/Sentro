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
        color: sContainerColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                text: 'Investment & Savings',
                fontFamily: CFONT.MEDIUM,
                fontWeight: FontWeight.w500,
                size: 14,
                height: 1.67,
              ),
              Row(
                children: [
                  CText(
                    text: 'New Goal',
                    size: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                  ),
                  SizedBox(width: widthSize(5),),
                  SvgPicture.asset(
                    addition,
                    width: widthSize(24),
                    height: heightSize(24),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: heightSize(14),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // ← evenly spread
            children: [
              investmentItem(assetName: birthday, title: 'My Birthday', callback: () {}),
              investmentItem(assetName: car, title: 'New Car', callback: () {}),
              investmentItem(assetName: house, title: 'New House', callback: () {}),
              investmentItem(assetName: plane, title: 'Travel Plans', callback: () {}),
              investmentItem(assetName: utilities, title: 'Utilities', callback: () {}),
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
  required VoidCallback callback,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    onTap: callback,
  );
}

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final VoidCallback onTap;

  const _AnimatedCategoryItem({
    required this.assetName,
    required this.title,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
