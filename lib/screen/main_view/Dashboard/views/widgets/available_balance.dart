import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.maxFinite,
          height: heightSize(196),
          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values().buttonRadius20),
            color: isDark?sContainerColor:sResendCode,
          ),
          child: Column(
            children: [
              SizedBox(height: heightSize(13),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CText(
                    text: 'Available Balance',
                    size: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                    color: sContainerTextDark,
                  ),
                  Container(
                    width: widthSize(211),
                    height: heightSize(31.97),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(83.34),
                      color: sButtonFillDark,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: widthSize(14.67),
                          height: heightSize(14.67),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(nigeria),
                        ),
                        SizedBox(width: widthSize(2.5),),
                        SvgPicture.asset(
                          arrowDown,
                          width: widthSize(20),
                          height: heightSize(20),
                          colorFilter: ColorFilter.mode(
                            isDark?Colors.white:Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: widthSize(8),),
                        CText(
                          text: 'Kuda MFB - 9060007015',
                          size: 11.67,
                          fontFamily: CFONT.REGULAR,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: heightSize(22.32),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextNaira(
                    text: '0.00',
                    size: 22,
                    fontWeight: FontWeight.w700,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            token,
                            width: widthSize(21),
                            height: heightSize(21),
                          ),
                          SizedBox(height: heightSize(3.48),),
                          CText(
                            text: '0.00',
                            fontWeight: FontWeight.w400,
                            size: 20,
                            fontFamily: CFONT.REGULAR,
                          )
                        ],
                      ),
                      CText(text: 'Sentro Token', size: 10, fontFamily: CFONT.ITALIC,)
                    ],
                  )
                ],
              ),
              SizedBox(height: heightSize(21),),
              Container(
                width: double.maxFinite,
                height: heightSize(heightSize(50),),
                padding: EdgeInsets.only(
                  left: widthSize(32),
                  right: widthSize(26.22),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius11+1),
                  color: sButtonFillDark,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        CText(
                          text: 'Transfer',
                          fontFamily: CFONT.MEDIUM,
                          fontWeight: FontWeight.w500,
                          size: 18,
                        ),
                        SizedBox(width: widthSize(2.5),),
                        SvgPicture.asset(
                          sendMoney,
                          width: widthSize(14.07),
                          height: heightSize(17),
                        ),
                      ],
                    ),
                    SizedBox(width: widthSize(34.22),),
                    VerticalDivider(
                      width: 34, thickness: 2, color: sGrey, indent: 8, endIndent: 8,
                    ),
                    SizedBox(width: widthSize(34.22),),
                    Row(
                      children: [
                        CText(
                          text: 'Receive',
                          fontFamily: CFONT.MEDIUM,
                          fontWeight: FontWeight.w500,
                          size: 18,
                        ),
                        SizedBox(width: widthSize(2.5),),
                        SvgPicture.asset(
                          receiveMoney,
                          width: widthSize(14.07),
                          height: heightSize(17),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: -38,
          child: Container(
            width: widthSize(52),
            height: heightSize(52),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white
                  : Colors.white,

              border: Border.all(
                color: sButtonFillDark,
                width: 6,
              ),
            ),

            child: Center(
              // child: SvgPicture.asset(
              //   transferSwap, // your middle icon
              //   width: widthSize(20),
              //   height: heightSize(20),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
