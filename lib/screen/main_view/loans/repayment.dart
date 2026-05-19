import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class Repayment extends StatefulWidget {
  const Repayment({super.key});

  @override
  State<Repayment> createState() => _RepaymentState();
}

class _RepaymentState extends State<Repayment> {
  bool _isRead = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(arrowBackWhite, width: widthSize(42), height: heightSize(42)),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: heightSize(2.5)),
            CText(
              text: 'Repayment',
              size: 18,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
            ),
            CText(
              text: 'Liquidate loan to increase your credit score',
              size: 14,
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
              height: 20/14,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(24)),
            CText(
              text: 'Due Loan',
              size: 14,
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
              color: sGrey1,
            ),
            SizedBox(height: heightSize(5)),
            CText(
              text: 'N10,000,000',
              size: 18,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
              color: sNavContainer,
            ),
            SizedBox(height: heightSize(5)),
            CText(
              text: '~ N15,000,000 remaining',
              size: 14,
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: heightSize(28.97),),
            AppTextField(
              showNairaPrefix: true,
              hasBottomMargin: false,
              height: heightSize(55),
              hint: '₦0.00',
              controller: TextEditingController(),
              suffixWidth: 94,
              suffixWidget: Container(
                height: heightSize(25.86),
                padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(124.89), color: sContainerColor),
                child: Center(child: CText(text: 'Liquidate all', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR)),
              ),
              inputType: TextInputType.number,
              error: '',
              validFunction: (_) => null,
            ),
            SizedBox(height: heightSize(25.03),),
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
                        text: 'Repayment Summary',
                        size: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: CFONT.MEDIUM,
                        color: sNavContainer,
                      ),
                      SizedBox(height: heightSize(15),),
                      // ── Items ──────────────────────────────────
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Amount',
                            size: 13,
                            fontFamily: CFONT.REGULAR,
                            fontWeight: FontWeight.w400,
                            color: sGrey1,
                          ),

                          CText(
                            text: 'N10,000,000',
                            size: 14,
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(10),),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Monthly Interest',
                            size: 13,
                            fontFamily: CFONT.REGULAR,
                            fontWeight: FontWeight.w400,
                            color: sGrey1,
                          ),

                          CText(
                            text: '1.7%',
                            size: 14,
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(10),),
                      Divider(color: sDarkBorder,),
                      SizedBox(height: heightSize(10),),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Interest Amount',
                            size: 13,
                            fontFamily: CFONT.REGULAR,
                            fontWeight: FontWeight.w400,
                            color: sGrey1,
                          ),

                          CText(
                            text: 'N10,000',
                            size: 14,
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(50),),
                      Divider(color: sDarkBorder,),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Repayment Amount',
                            size: 13,
                            fontFamily: CFONT.REGULAR,
                            fontWeight: FontWeight.w400,
                            color: sGrey1,
                          ),

                          CText(
                            text: 'N0.00',
                            size: 16,
                            fontFamily: CFONT.BOLD,
                            fontWeight: FontWeight.w700,
                            color: sNavContainer,
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(6),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(12.5),),
            Container(
              height: heightSize(85),
              padding: EdgeInsets.symmetric(horizontal: widthSize(15),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                border: Border.all(color: sDarkBorder),
                color: sSentroLightGreen.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        text: 'Auto Repayment',
                        size: 14,
                        fontFamily: CFONT.MEDIUM,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: heightSize(5),),
                      SizedBox(
                        width: widthSize(263),
                        child: CText(
                          text: 'Repay loans automatically from main balance on the loan’s due date.',
                          size: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: CFONT.REGULAR,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: widthSize(12),),
                  GestureDetector(
                    onTap: () => setState(() => _isRead = !_isRead),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      width: widthSize(54),
                      height: heightSize(28),
                      padding: EdgeInsets.symmetric(
                        horizontal: widthSize(4),
                        vertical: heightSize(3),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: _isRead ? sNavContainer : sDarkBorder,
                      ),
                      child: Row(
                        mainAxisAlignment: _isRead
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: widthSize(22),
                            height: heightSize(22),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            ActionButton(
              text: 'Repay Now',
              color: sActionButton,
              textColor: Colors.white,
              callback: (){
                Get.back();
              },
            ),
            SizedBox(height: heightSize(12.5),),
          ],
        ),
      ),
    );
  }
}
