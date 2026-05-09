import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';

class BillerCategories extends StatelessWidget {
  const BillerCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: heightSize(111),
      padding: EdgeInsets.symmetric(horizontal: widthSize(12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values().buttonRadius20),
        color: sContainerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // ← evenly spread
        children: [
          billerItem(assetName: mobile, title: 'Top Up', callback: () {}),
          billerItem(assetName: electricity, title: 'Pay Bills', callback: () {}),
          billerItem(assetName: gift, title: 'Gift Cards', callback: () {}),
          billerItem(assetName: key, title: 'Save Money', callback: () {}),
          billerItem(assetName: loans, title: 'Loans', callback: () {}),
        ],
      ),
    );
  }
}

Widget billerItem({
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
                child: Container(
                  height: heightSize(50),
                  width: widthSize(50),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      sNavContainer.red,
                      sNavContainer.green,
                      sNavContainer.blue,
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(Values().buttonRadius20),
                  ),
                  child: SvgPicture.asset(
                    widget.assetName,
                    height: heightSize(36),
                    width: widthSize(36),
                    fit: BoxFit.contain,
                  ),
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
