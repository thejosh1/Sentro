import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';

class PageHeader extends StatelessWidget {
  final Widget? trailing;
  final bool isDark;

  const PageHeader({
    super.key,
    this.trailing,
    required this.isDark,
  });

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final accent = AccentController.to.accent.value;
      final useAccent = !_isDefaultAccent(accent);

      return Row(
        mainAxisAlignment: trailing != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (Get.key.currentState?.canPop() ?? false) {
                Get.back();
              }
            },
            child: SvgPicture.asset(
              isDark ? arrowBackWhite : arrowBack,
              width: widthSize(42),
              height: heightSize(42),
              colorFilter: useAccent
                  ? ColorFilter.mode(accent, BlendMode.srcIn)
                  : null,
            ),
          ),

          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      );
    });
  }
}