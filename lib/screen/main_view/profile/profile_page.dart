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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark ? arrowBackWhite : arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                CText(
                  text: 'Profile',
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                  size: 18,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.myQrPage);
                  },
                  child: SvgPicture.asset(
                    profileScan,
                    width: widthSize(32),
                    height: heightSize(32),
                    colorFilter: isDark?null:ColorFilter.mode(
                      Colors.black, BlendMode.srcIn,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: heightSize(31.5)),

            // TITLE (Avatar with badge)
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: widthSize(125),
                  height: heightSize(125),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: widthSize(40),
                    height: heightSize(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sNavContainer,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        camera,
                        width: widthSize(28),
                        height: heightSize(28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(22.67),),
            name(isDark),
            SizedBox(height: heightSize(37.33),),
            profileInfo(colorScheme, isDark),
            SizedBox(height: heightSize(24),),
            accentColors(),
            SizedBox(height: heightSize(73),),
            ActionButton(
              text: 'Continue',
              color: sNavContainer,
              textColor: sActionButton,
              callback: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget name(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CText(
          text: 'Richmond Nnamdi Uche',
          size: 18,
          fontWeight: CFONT.wRegular,
          fontFamily: CFONT.FAMILY,
        ),
        SizedBox(height: heightSize(5),),
        Container(
          height: heightSize(28.67),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(83.34),
            color: isDark?sBeneficiaryColor:sLightHintText,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: widthSize(10)),
              Container(
                width: widthSize(14.67),
                height: heightSize(14.67),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(nigeria),
              ),
              SizedBox(width: widthSize(8)),
              CText(
                text: 'Bowman MFB - 9060007015',
                size: 11.67,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
              ),
              SizedBox(width: widthSize(17.83)),
            ],
          ),
        ),
      ],
    );
  }

  Widget profileInfo(ColorScheme colorScheme, bool isDark) {
    return Column(
      children: [
        CText(
          text: 'PERSONAL INFORMATION',
          size: 12,
          height: 16/12,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wMedium,
          color: sGrey1,
        ),
        SizedBox(height: heightSize(15),),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: widthSize(21), 
            top: heightSize(29), 
            right: widthSize(25),
            bottom: heightSize(25),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDark?sDarkFill:sLightFill,
          ),
          child: Column(
            children: [
              _receiptRow(
                title: 'FullName',
                value: Text(
                  'Richmond Richmond Uche',
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: CFONT.wMedium,
                    fontSize: 15,
                    fontFamily: CFONT.FAMILY,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: sDarkBorder,),
              SizedBox(height: 10,),
              _receiptRow(
                title: 'Sentro Tag',
                value: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '@richmond',
                      textAlign: TextAlign.right,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: CFONT.wMedium,
                        fontSize: 15,
                        fontFamily: CFONT.FAMILY,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: widthSize(8),),
                    SvgPicture.asset(edit2, width: widthSize(18), height: heightSize(18),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: sDarkBorder,),
              SizedBox(height: 10,),
              _receiptRow(
                title: 'Email',
                value: Text(
                  'richmond@email.com',
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: CFONT.wMedium,
                    fontSize: 15,
                    fontFamily: CFONT.FAMILY,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: sDarkBorder,),
              SizedBox(height: 10,),
              _receiptRow(
                title: 'Phone Number',
                value: Text(
                  '0906000000',
                  textAlign: TextAlign.right,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: CFONT.wMedium,
                    fontSize: 15,
                    fontFamily: CFONT.FAMILY,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _receiptRow({
    required String title,
    required Widget value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CText(
          text: title,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 14,
          color: sConfirmTextColor,
        ),

        SizedBox(width: widthSize(20)),

        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: value,
          ),
        ),
      ],
    );
  }

  Widget accentColors() {
    return Column(
      children: [
        CText(
          text: 'ACCENT COLOURS',
          fontWeight: CFONT.wMedium,
          fontFamily: CFONT.FAMILY,
          size: 12,
          height: 16 / 12,
          color: sGrey1,
        ),
        SizedBox(height: heightSize(15)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: widthSize(21),
            vertical: heightSize(20),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: sDarkFill,
          ),
          child: Obx(() {
            final current = AccentController.to.accent.value;
            return Row(
              children: AccentController.options.map((color) {
                final isSelected = current.value == color.value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => AccentController.to.setAccent(color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: widthSize(13)),
                      width: widthSize(32),
                      height: heightSize(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: widthSize(3))
                            : null,
                        boxShadow: isSelected
                            ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)]
                            : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}

