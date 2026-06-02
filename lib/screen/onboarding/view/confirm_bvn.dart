import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';
import 'package:sentro/core/widgets/text_field.dart';

class ConfirmBvn extends StatelessWidget {
  const ConfirmBvn({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isDefaultAccent(Color c) {
      final defaultAccent = AccentController.options.first;
      return c.value == defaultAccent.value;
    }

    TextEditingController bvnNameController = TextEditingController();
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
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
              SizedBox(height: heightSize(30),),
              CText(
                text: 'Confirm Bvn Information',
                fontWeight: CFONT.wBold,
                fontFamily: CFONT.FAMILY,
                size: 22,
              ),
              SizedBox(height: heightSize(5),),
              CText(
                text: 'This is the biodata we found on your BVN, kindly confirm by choosing continue',
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                size: 18,
                color: isDark ? sDarkModeMutedText : sLightModeMutedText,
              ),
              SizedBox(height: heightSize(30),),
              AppTextField(
                title: CText(
                  text: 'BVN - Full Names',
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                  size: 16,
                ),
                hint: 'John James Doe',
                controller: bvnNameController,
                inputType: TextInputType.number,
                error: '',
                validFunction: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return "Please enter your full name.";
                  }
                  return null;
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
          return ActionButton(
            color: accent,
            borderColor: accent,
            text: "Continue",
            callback: () {
              FocusScope.of(context).unfocus();
              Get.toNamed(Routes.createPassword);
            },
            load: false,
          );
        }),
      ),
    );
  }
}