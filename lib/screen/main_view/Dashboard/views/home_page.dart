import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/available_balance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(62),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: widthSize(50),
                      height: heightSize(50),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(avatar),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(width: widthSize(10),),
                    Column(
                      children: [
                        CText(
                          text: 'Hi, Richmond',
                          size: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: CFONT.REGULAR,
                        ),
                        Container(
                          width: widthSize(72.69),
                          height: heightSize(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(113.27),
                            color: isDark?sTierColor:sResendCode,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(goldMedal),
                              SizedBox(width: widthSize(3),),
                              CText(text: 'Tier 3', fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, size: 15.88,)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: widthSize(43.52),
                          height: heightSize(43.52),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark?sDarkFill:sNavContainer.withOpacity(0.25),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              headPhone,
                              width: widthSize(25.93),
                              height: heightSize(25.93),
                              colorFilter: ColorFilter.mode(
                                isDark?Colors.white:Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -4,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: widthSize(36.11),
                            height: heightSize(13.89),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.93),
                              color: isDark?Colors.white:sNavContainer,
                            ),
                            child: Center(
                              child: CText(
                                text: 'Help?',
                                fontFamily: CFONT.BOLD,
                                size: 7.41,
                                fontWeight: FontWeight.w700,
                                color: sCancel,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: widthSize(39.17),
                          height: heightSize(39.17),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark?sDarkFill:sNavContainer.withOpacity(0.25),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              notification,
                              width: widthSize(23.33),
                              height: heightSize(23.33),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -1,
                          left: 0,
                          right: -5,
                          child: Container(
                            width: widthSize(12.5),
                            height: heightSize(12.5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sBvnButton,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: heightSize(40),),
            AvailableBalance(),
          ],
        ),
      ),
    );
  }
}
