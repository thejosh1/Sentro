import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
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
                    arrowBackWhite,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                Spacer(),
                CText(
                  text: 'Change Password',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  height: 20/18,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: heightSize(35),),
            CText(
              text: 'Create password',
              size: 22,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'Your password protects your account from unauthorised login access',
              fontWeight: CFONT.wRegular,
              size: 18,
              fontFamily: CFONT.FAMILY,
              color: isDark?sGrey1:sGrey2,
            ),
            SizedBox(height: heightSize(30),),
            AppTextField(
              obscureText: true,
              title: CText(
                text: 'Password',
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                size: 16,
              ),
              hint: '●●●●●●●●●●',
              color: sActionButton,
              controller: createPasswordController,
              inputType: TextInputType.visiblePassword,
              obscureOnIcon: SvgPicture.asset(
                hide,
                width: widthSize(24),
                height: heightSize(24),
              ),
              obscureOffIcon: SvgPicture.asset(
                visibilityOff,
                width: widthSize(24),
                height: heightSize(24),
              ),
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "Password cannot be empty.";
                }
                return null;
              },
            ),
            SizedBox(height: heightSize(15),),
            AppTextField(
              obscureText: true,
              title: CText(
                text: 'Repeat Password',
                fontWeight: CFONT.wMedium,
                fontFamily: CFONT.FAMILY,
                size: 16,
              ),
              hint: '●●●●●●●●●●',
              color: sActionButton,
              controller: repeatPasswordController,
              inputType: TextInputType.visiblePassword,
              obscureOnIcon: SvgPicture.asset(hide, width: widthSize(24), height: heightSize(24),),
              obscureOffIcon: SvgPicture.asset(visibilityOff, width: widthSize(24), height: heightSize(24),),
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "Password cannot be empty.";
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
        child: ActionButton(
          text: "Continue",
          callback: () {
            FocusScope.of(context).unfocus();
            Get.toNamed(Routes.chooseSentroTag);
          },
          load: false,
        ),
      ),
    );
  }
}
