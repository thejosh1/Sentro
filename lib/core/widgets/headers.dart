import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        Container(
          width: widthSize(42),
          height: heightSize(42),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sNavContainer.withOpacity(0.4),
          ),
          child: Center(
            child: SvgPicture.asset(
              arrowBack,
              width: widthSize(14.87),
              height: heightSize(13.12),
            ),
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
