import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';

class PageHeader extends StatelessWidget {
  final Widget? trailing;
  const PageHeader({super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: trailing!=null?
      MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (Get.key.currentState?.canPop() ?? false) {
              Get.back();
            }
          },
          child: SvgPicture.asset(
            arrowBack,
            width: widthSize(35),
            height: heightSize(35),
          ),
        ),

        if (trailing != null) ...[
          const SizedBox(width: 8), // optional spacing
          trailing!,
        ],
      ],
    );
  }
}
