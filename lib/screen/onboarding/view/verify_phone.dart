import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
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
                      top: 2,
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: heightSize(34),),
            CText(
              text: 'Verify phone number',
              size: 22,
              fontFamily: CFONT.BOLD,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'Verify your phone number that you registered, a code will be sent shortly',
              fontWeight: FontWeight.w400, size: 18, fontFamily: CFONT.REGULAR, color: Theme.of(context).brightness == Brightness.dark
                ? sDarkModeMutedText // dark mode muted text
                : sLightModeMutedText,
            ),
            SizedBox(height: heightSize(30),),
            AppTextField(
              obscureText: false,
              title: CText(
                text: 'Phone Number',
                fontWeight: FontWeight.w500,
                fontFamily: CFONT.MEDIUM,
                size: 16,
              ),
              prefixWidget: Container(
                width: widthSize(56),
                height: heightSize(28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius15-1),
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
                        Container(
                          width: widthSize(5),
                          height: heightSize(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sActionButton,
                          ),
                        ),
                        Container(
                          width: widthSize(5),
                          height: heightSize(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sActionButton,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              hint: '08...',
              color: sActionButton,
              controller: ctrl,
              inputType: TextInputType.phone,
              error: '',
              validFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Phone number cannot be empty";
                }
                return value.trim().length != 10
                    ? 'Enter 10 digits number'
                    : null;
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
            Get.toNamed(
              Routes.confirmPhoneNumber,
              arguments: {
                "flow": "login",
              },
            );
          },
          load: false,
        ),
      ),
    );
  }
}
