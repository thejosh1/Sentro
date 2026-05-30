import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
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
          children: [
            SizedBox(height: heightSize(64),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                SvgPicture.asset(
                  logoLight,
                  width: widthSize(116.39),
                  height: heightSize(28),
                  colorFilter: isDark?ColorFilter.mode(
                    sNavContainer,
                    BlendMode.srcIn,
                  ):null,
                ),
                SvgPicture.asset(
                  isDark?headPhoneWhite:headPhone,
                  width: widthSize(43.52),
                  height: heightSize(50),
                )
              ],
            ),
            SizedBox(height: heightSize(34),),
            CText(
              text: 'Create your 4 Digit PIN',
              size: 22,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(5),),
            Center(
              child: CText(
                text: 'Provide your 4 Digit transaction PIN',
                fontWeight: CFONT.wRegular,
                size: 18,
                fontFamily: CFONT.FAMILY,
                color: Theme.of(context).brightness == Brightness.dark
                    ? sDarkModeMutedText // dark mode muted text
                    : sLightModeMutedText,
              ),
            ),
            SizedBox(height: heightSize(30),),
            Container(
              width: widthSize(156),
              height: heightSize(47),
              padding: EdgeInsets.symmetric(horizontal: widthSize(16)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Values().buttonRadius20 * 5),
                color: sNavContainer,
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
                          : Colors.white,
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