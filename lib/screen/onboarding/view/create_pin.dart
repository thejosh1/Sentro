import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';

import 'package:sentro/core/widgets/keyboard_pin.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  TextEditingController pinController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  Future<void> _onSubmitPin() async {
    final pin = controller.text.trim();
    if (pin.length < 4) {
      // cToast(title: "Invalid PIN", message: "Enter your 4-digit PIN", color: kRed);
      return;
    } else {
      Get.toNamed(Routes.welcome);
    }
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64),),
            Padding(
              padding: EdgeInsets.only(right: widthSize(7)),
              child: PageHeader(
                trailing: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: widthSize(43.52),
                      height: heightSize(43.52),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: sNavContainer.withOpacity(0.25),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          headPhone,
                          width: widthSize(25.93),
                          height: heightSize(25.93),
                          colorFilter: ColorFilter.mode(
                            isDark?sLemon:sActionButton,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: widthSize(36.11),
                        height: heightSize(13.89),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.93),
                          color: sNavContainer,
                        ),
                        child: Center(
                          child: CText(
                            text: 'Help?',
                            fontFamily: CFONT.BOLD,
                            size: 7.41,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: heightSize(34),),
            CText(
              text: 'Create your 4 Digit PIN',
              size: 22,
              fontFamily: CFONT.BOLD,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'This PIN will be used for your account transaction confirmations',
              fontWeight: FontWeight.w400, size: 18, fontFamily: CFONT.REGULAR, color: Theme.of(context).brightness == Brightness.dark
                ? sDarkModeMutedText // dark mode muted text
                : sLightModeMutedText,
            ),
            SizedBox(height: heightSize(30),),
            Container(
              width: widthSize(156),
              height: heightSize(47),
              padding: EdgeInsets.symmetric(horizontal: widthSize(16)),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(Values().buttonRadius20 * 5),
                color: isDark ? sDarkFill : sLightPinContainer,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(4, (index) {
                  final isFilled = index < controller.text.length;

                  return Container(
                    width: widthSize(18),
                    height: heightSize(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled
                          ? sActionButton
                          : sPinIndicator,
                    ),
                  );
                }),
              ),
            ),
            Spacer(),
            KeyboardPin(
              controller: controller,
              callback: _onSubmitPin,
            ),
            SizedBox(height: heightSize(67),),
          ],
        ),
      ),
    );
  }
}
