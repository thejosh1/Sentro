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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController bvnController = TextEditingController();

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
            Padding(
              padding: EdgeInsets.only(right: widthSize(7)),
              child: PageHeader(
                isDark: false,
                trailing: Obx(() {
                  final accent = AccentController.to.accent.value;
                  final isDefault = AccentController.options.first.value == accent.value;
                  return CText(
                    text: 'Why is BVN required?',
                    color: isDefault?isDark ? sNavContainer : sActionButton:accent,
                    size: 16,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                  );
                }),
              ),
            ),
            SizedBox(height: heightSize(34),),
            CText(
              text: 'Create account with BVN',
              size: 22,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(5),),
            CText(
              text: 'You will receive a verification code to your phone used to register your BVN',
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    text: 'BVN',
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    size: 16,
                  ),
                  CText(
                    text: 'Bank Verification Number',
                    size: 16,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: isDark ? sDarkHintText : sLightHintText,
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
            SizedBox(height: heightSize(30),),
            Obx(() {
              final accent = AccentController.to.accent.value;

              return SizedBox(
                height: heightSize(42),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: accent,
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(horizontal: widthSize(24)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                      side: BorderSide(color: accent),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 👈 KEY FIX
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        call,
                        width: widthSize(20),
                        height: heightSize(20),
                        colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
                      ),
                      SizedBox(width: widthSize(8)),
                      CText(
                        text: 'Dial *565*0#',
                        size: 13,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                      ),
                    ],
                  ),
                ),
              );
            })
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
          final useAccent = !_isDefaultAccent(accent);
          return ActionButton(
            text: "Continue",
            color: useAccent?accent:null,
            borderColor: useAccent?accent:null,
            textColor: sNavContainer,
            callback: () {
              Get.toNamed(
                Routes.confirmPhoneNumber,
                arguments: {
                  "flow": "bvn",
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