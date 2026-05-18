import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/goals_model.dart';
import 'package:sentro/core/utils/text.dart';

class GoalsDetails extends StatefulWidget {
  const GoalsDetails({super.key});

  @override
  State<GoalsDetails> createState() => _GoalsDetailsState();
}

class _GoalsDetailsState extends State<GoalsDetails> {
  String amountOnly(String value) {
    return value.split(' on ').first;
  }
  @override
  Widget build(BuildContext context) {
    final GoalModel goal = Get.arguments as GoalModel;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    arrowBackWhite, width: widthSize(42), height: heightSize(42),
                  ),
                ),
                CText(
                  text: 'Details',
                  size: 18,
                  height: 20/18,
                  fontWeight: FontWeight.w500,
                  fontFamily: CFONT.MEDIUM,
                ),
                Container(
                  width: widthSize(52),
                  height: heightSize(21),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: sNavContainer.withOpacity(0.1),
                  ),
                  child: Center(
                    child: CText(
                      text: 'Active',
                      size: 12.57,
                      fontWeight: FontWeight.w400,
                      fontFamily: CFONT.REGULAR,
                      color: sNavContainer,
                    ),
                  ),
                ),
              ],
            ),
            CText(
              text: goal.type,
              size: 14,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(45),),
            CText(
              text: goal.name,
              size: 20,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: heightSize(21),),
            _detailItem(
              title: 'BALANCE',
              value: goal.balance,
              isPayout: false,
              isInterest: false,
            ),
            _detailItem(
              title: 'TARGET',
              value: amountOnly(goal.target ?? ''),
              isPayout: false,
              isInterest: false,
            ),
            _detailItem(
              title: 'INTEREST RATE',
              value: goal.interestRate,
              isPayout: false,
              isInterest: true,
            ),
            _detailItem(
              title: 'MATURES',
              value: goal.matures,
              isPayout: false,
              isInterest: false,
            ),
            _detailItem(
              title: 'Payout Frequency',
              value: '14.8%',
              reinvest: goal.reinvest,
              isPayout: true,
              isInterest: true,
            ),
            Spacer(),
            Container(
              width: double.maxFinite,
              height: heightSize(55),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.71),
                color: sNavContainer,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    text: 'Top Up',
                    size: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: CFONT.MEDIUM,
                    color: sActionButton,
                  ),
                  SizedBox(width: widthSize(5),),
                  SvgPicture.asset(
                    add,
                    width: widthSize(24),
                    height: heightSize(24),
                    colorFilter: ColorFilter.mode(
                      sActionButton,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: heightSize(17),),
            Container(
              width: double.maxFinite,
              height: heightSize(55),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.71),
                color: Colors.transparent,
                border: Border.all(color: sGrey2)
              ),
              child: Center(
                child: CText(
                  text: 'Withdraw',
                  size: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: CFONT.MEDIUM,
                ),
              ),
            ),
            SizedBox(height: heightSize(34),),
          ],
        ),
      ),
    );
  }

  Widget _detailItem({
    required String title,
    required String value,

    bool isPayout = false,
    bool isInterest = false,
    bool reinvest = false,
  }) {
    if (!isPayout) {
      return Container(
        height: heightSize(70.14),
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: widthSize(20),
          top: heightSize(12),
          bottom: heightSize(15.14),
        ),
        margin: EdgeInsets.only(bottom: 10.86),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.63),
          border: Border.all(color: sDarkBorder),
          color: sDarkFill,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText(
              text: title,
              size: 12,
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
              color: sGrey1,
            ),

            SizedBox(height: heightSize(5)),

            CText(
              text: value,
              size: 14,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
              color: isInterest
                  ? sNavContainer
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      );
    }

    return Row(
      children: [

        /// Payout Frequency
        Expanded(
          child: Container(
            height: heightSize(70),
            padding: EdgeInsets.symmetric(horizontal: widthSize(14)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.63),
              color: sDarkFill,
              border: Border.all(color: sDarkBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: title,
                  size: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                  color: sGrey1,
                ),

                SizedBox(height: heightSize(5)),

                CText(
                  text: value,
                  size: 14,
                  fontFamily: CFONT.MEDIUM,
                  fontWeight: FontWeight.w500,
                  color: isInterest
                      ? sNavContainer
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: widthSize(12)),

        /// Reinvest
        Expanded(
          child: Container(
            height: heightSize(70),
            padding: EdgeInsets.symmetric(horizontal: widthSize(14)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.63),
              color: sDarkFill,
              border: Border.all(color: sDarkBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: 'Reinvest at maturity',
                  size: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                  color: sGrey1,
                ),

                SizedBox(height: heightSize(5)),

                reinvest
                    ? Row(
                  children: [
                    SvgPicture.asset(
                      tick,
                      width: widthSize(18),
                      height: heightSize(18),
                    ),

                    SizedBox(width: widthSize(4)),

                    Expanded(
                      child: CText(
                        text: 'Yes - auto reinvest',
                        fontFamily: CFONT.MEDIUM,
                        fontWeight: FontWeight.w500,
                        size: 14,
                      ),
                    ),
                  ],
                )
                    : CText(
                  text: 'No',
                  fontFamily: CFONT.MEDIUM,
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
