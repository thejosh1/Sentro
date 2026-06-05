import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class FaceVerification extends StatelessWidget {
  const FaceVerification({super.key});

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Padding(
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
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                      colorFilter: useAccent
                          ? ColorFilter.mode(accent, BlendMode.srcIn)
                          : null,
                    ),
                  ),
                  SvgPicture.asset(
                    logoLight,
                    width: widthSize(116.39),
                    height: heightSize(28),
                    colorFilter: useAccent ? ColorFilter.mode(
                        accent, BlendMode.srcIn) : isDark ? ColorFilter.mode(
                      sNavContainer,
                      BlendMode.srcIn,
                    ) : null,
                  ),
                  SvgPicture.asset(
                    isDark ? headPhoneWhite : headPhone,
                    width: widthSize(43.52),
                    height: heightSize(50),
                  )
                ],
              ),
              SizedBox(height: heightSize(30),),
              Center(
                child: CText(
                  text: 'Face Verification',
                  fontWeight: CFONT.wBold,
                  fontFamily: CFONT.FAMILY,
                  size: 22,
                ),
              ),
              SizedBox(height: heightSize(5),),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'For the safety of your account, please ensure you ',
                  style: TextStyle(
                    color: isDark ? sGrey1 : sGrey2,
                    fontSize: 16,
                    fontWeight: CFONT.wRegular,
                    fontFamily: CFONT.FAMILY,
                  ),
                  children: [
                    TextSpan(
                      text: '....DE',
                      style: TextStyle(
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wBold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' is the one making this request',
                      style: TextStyle(
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wBold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: widthSize(25),
          right: widthSize(25),
          bottom: heightSize(10),
        ),
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          return ActionButton(
            text: "Continue",
            color: useAccent?accent:null,
            borderColor: useAccent?accent:null,
            textColor: sNavContainer,
            callback: () {
              FocusScope.of(context).unfocus();

              // Capture if this came down from the reset parameters pipeline
              final isReset = Get.arguments?['isReset'] == true;

              // Route to Create PIN, handing over the flow tracker payload
              Get.toNamed(Routes.createPin, arguments: {
                'isReset': isReset,
              });
            },
            load: false,
          );
        }),
      ),
    );
  }
}