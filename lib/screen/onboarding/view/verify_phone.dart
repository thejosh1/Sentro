import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';
import 'package:sentro/core/widgets/text_field.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  TextEditingController ctrl = TextEditingController();

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: heightSize(34),),
              CText(
                text: 'Verify phone number',
                size: 22,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wBold,
              ),
              SizedBox(height: heightSize(5),),
              CText(
                text: 'Verify your phone number that you registered, a code will be sent shortly',
                fontWeight: CFONT.wRegular,
                size: 18,
                height: 1.5,
                fontFamily: CFONT.FAMILY,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? sDarkModeMutedText // dark mode muted text
                    : sLightModeMutedText,
              ),
              SizedBox(height: heightSize(30),),
              AppTextField(
                obscureText: false,
                title: CText(
                  text: 'Phone Number',
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                  size: 16,
                ),
                prefixWidget: Container(
                  width: widthSize(56),
                  height: heightSize(28),
                  margin: EdgeInsets.only(left: widthSize(8),),
                  padding: EdgeInsets.symmetric(
                      horizontal: widthSize(5), vertical: heightSize(4)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: sNavContainer,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        nigeria,
                        width: widthSize(20),
                        height: heightSize(20),
                      ),
                      SizedBox(width: widthSize(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: widthSize(5),
                            height: heightSize(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sActionButton,
                            ),
                          ),
                          SizedBox(width: widthSize(3),),
                          Container(
                            width: widthSize(5),
                            height: heightSize(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sActionButton,
                            ),
                          ),
                          SizedBox(width: widthSize(3),),
                          Container(
                            width: widthSize(5),
                            height: heightSize(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sActionButton,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                hint: '08...',
                hintColor: sLightHintText,
                color: sActionButton,
                controller: ctrl,
                inputType: TextInputType.phone,
                error: '',
                validFunction: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return "Phone number cannot be empty";
                  }
                  return value
                      .trim()
                      .length != 10
                      ? 'Enter 10 digits number'
                      : null;
                },
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
            color: useAccent ? accent : null,
            borderColor: useAccent ? accent : null,
            textColor: sNavContainer,
            callback: () {
              FocusScope.of(context).unfocus();
              Get.toNamed(
                Routes.confirmPhoneNumber,
                arguments: {
                  "flow": "login",
                },
              );
            },
            load: false,
          );
        }),
      ),
    );
  }
}