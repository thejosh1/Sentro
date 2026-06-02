import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class ChooseSentroTag extends StatefulWidget {
  const ChooseSentroTag({super.key});

  @override
  State<ChooseSentroTag> createState() => _ChooseSentroTagState();
}

class _ChooseSentroTagState extends State<ChooseSentroTag> {
  TextEditingController tagController = TextEditingController();

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
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64),),
            Obx(() {
              final accent = AccentController.to.accent.value;
              final useAccent = !_isDefaultAccent(accent);
              return Row(
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
              );
            }),
            SizedBox(height: heightSize(34),),
            CText(
              text: 'Choose your Sentro Tag',
              size: 22,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'Finaka Tag is your unique name for receiving money on Sentro',
              fontWeight: CFONT.wRegular,
              size: 18,
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
                text: 'Sentro Tag',
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                size: 16,
              ),
              suffixWidget: GestureDetector(
                onTap: () {
                  tagController.clear();
                },
                child: SvgPicture.asset(
                  cancelSquare,
                  width: widthSize(19.5),
                  height: heightSize(19.5),
                ),
              ),
              hint: '@',
              color: sActionButton,
              controller: tagController,
              inputType: TextInputType.text,
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "Choose a sentro tag.";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: widthSize(25),
          right: widthSize(25),
          bottom: heightSize(10),
        ),
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          return ActionButton(
            text: "Continue",
            callback: () {
              FocusScope.of(context).unfocus();
              Get.toNamed(Routes.createPin);
            },
            load: false,
          );
        }),
      ),
    );
  }
}