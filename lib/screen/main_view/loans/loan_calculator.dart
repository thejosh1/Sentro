import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class LoanCalculator extends StatefulWidget {
  const LoanCalculator({super.key});

  @override
  State<LoanCalculator> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(90.46)),
            CText(
              text: 'Loan Calculator',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
            ),
            SizedBox(height: heightSize(2.76)),
            CText(
              text: '20% Interest Rate',
              size: 18,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              color: sNavContainer,
            ),
            SizedBox(height: heightSize(47.78)),
            AppTextField(
              title: CText(
                text: 'Loan Amount (N)',
                size: 16,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
              ),
              showNairaPrefix: true,
              hasBottomMargin: false,
              height: heightSize(55),
              hint: '₦0.00',
              controller: amountController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (_) => null,
            ),
            SizedBox(height: heightSize(12.5),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: 'Duration',
                  size: 16,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                ),
                SizedBox(height: heightSize(5),),
                GestureDetector(
                  onTap: () async {
                    // Bottom sheet code commented out
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: widthSize(15), top: heightSize(20.5), right: widthSize(19), bottom: heightSize(20.5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Values().buttonRadius10,),
                      color: sDarkFill,
                      border: Border.all(color:sDarkBorder,),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: CText(
                            text: '6 Month',
                            size: 14,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                          ),
                        ),
                        AnimatedRotation(
                          turns: 0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: SvgPicture.asset(
                            arrowDown,
                            width: widthSize(20),
                            height: heightSize(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(12.5),),
            Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(15),
                    vertical: heightSize(18),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.17),
                    color: sDarkFill,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Card Title ─────────────────────────────
                      CText(
                        text: 'Interest Preview',
                        size: 16,
                        fontWeight: CFONT.wMedium,
                        fontFamily: CFONT.FAMILY,
                        color: sNavContainer,
                      ),
                      SizedBox(height: heightSize(15),),
                      // ── Items ──────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Loan Amount',
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey1,
                          ),
                          CText(
                            text: 'N0.00',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Loan Rate',
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey1,
                          ),
                          CText(
                            text: '20%',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Monthly',
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey1,
                          ),
                          CText(
                            text: '1.7%',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Total Interest (1 year)',
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey1,
                          ),
                          CText(
                            text: 'N10',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            color: sNavContainer,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(17),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Total Payback',
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey1,
                          ),
                          CText(
                            text: 'N0.00',
                            size: 16,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wBold,
                            color: sNavContainer,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(6),),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(8)),
                CText(
                  text: 'This is just an interest calculator, fines for late payment is not included. Late payment penalty is 1% of total loan collected',
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: sGrey2,
                ),
              ],
            ),
            Spacer(),
            ActionButton(
              text: 'Take Loan',
              color: Colors.transparent,
              borderColor: sGrey2,
              textColor: Colors.white,
              callback: (){
                Get.toNamed(Routes.eligibilityTest);
              },
            ),
            SizedBox(height: heightSize(12.5),),
          ],
        ),
      ),
    );
  }
}