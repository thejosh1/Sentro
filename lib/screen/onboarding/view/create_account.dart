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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController bvnController = TextEditingController();
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
                trailing: CText(
                  text: 'Why is BVN required?',
                  color: sTextGreen,
                  size: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: CFONT.MEDIUM,
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
              controller: bvnController,
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
            Get.toNamed(
              Routes.confirmPhoneNumber,
              arguments: {
              "flow": "bvn",
              },
            );
          },
          load: false,
        ),
      ),
    );
  }
}
