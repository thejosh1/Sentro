import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';
import 'package:sentro/core/widgets/text_field.dart';

class ConfirmBvn extends StatelessWidget {
  const ConfirmBvn({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController bvnNameController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64),),
            PageHeader(
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
            SizedBox(height: heightSize(30),),
            CText(
              text: 'Confirm Bvn Information',
              fontWeight: FontWeight.w700,
              fontFamily: CFONT.BOLD,
              size: 22,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'This is the biodata we found on your BVN, kindly\nconfirm by choosing continue',
              fontWeight: FontWeight.w400,
              fontFamily: CFONT.REGULAR,
              size: 18,
              color: isDark?sDarkModeMutedText:sLightModeMutedText,
            ),
            SizedBox(height: heightSize(30),),
            AppTextField(
              height: heightSize(58),
              title: CText(
                text: 'BVN - Full Names',
                fontWeight: FontWeight.w500,
                fontFamily: CFONT.MEDIUM,
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
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: widthSize(25),
            right: widthSize(25),
            bottom: heightSize(10)),
        child: ActionButton(
          text: "Continue",
          callback: () {
            Get.toNamed(Routes.createPassword);
          },
          load: false,
        ),
      ),
    );
  }
}
