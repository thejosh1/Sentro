import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';
import 'package:sentro/core/widgets/text_field.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  TextEditingController createPasswordController = TextEditingController();
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
              text: 'Create account with BVN',
              size: 22,
              fontFamily: CFONT.BOLD,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'You will receive a verification code to your phone used to register your BVN',
              fontWeight: FontWeight.w400, size: 18, fontFamily: CFONT.REGULAR, color: Theme.of(context).brightness == Brightness.dark
                ? sDarkModeMutedText // dark mode muted text
                : sLightModeMutedText,
            ),
            SizedBox(height: heightSize(30),),
            AppTextField(
              obscureText: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    text: 'BVN',
                    fontWeight: FontWeight.w500,
                    fontFamily: CFONT.MEDIUM,
                    size: 16,
                  ),
                  CText(
                    text: 'Bank Verification Number',
                    size: 16,
                    fontFamily: CFONT.REGULAR,
                    fontWeight: FontWeight.w400,
                    color: isDark?sDarkHintText:sLightHintText,
                  ),
                ],
              ),
              hint: 'Enter Bvn',
              controller: createPasswordController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "BVN cannot be empty.";
                }
                return null;
              },
            ),
            SizedBox(height: heightSize(20),),
            SizedBox(
              height: heightSize(42),
              width: widthSize(155),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: sLemon,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                      side: BorderSide(
                        color: sLemon,
                      )
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                        call,
                        width: widthSize(20),
                        height: heightSize(20),
                        colorFilter: isDark?ColorFilter.mode(Colors.white, BlendMode.srcIn):null),
                    CText(
                      text: 'Dial *565*0#',
                      size: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: CFONT.REGULAR,
                    ),
                  ],
                ),
              ),
            )
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
            Get.toNamed(Routes.confirmPhoneNumber);
          },
          load: false,
        ),
      ),
    );
  }
}
