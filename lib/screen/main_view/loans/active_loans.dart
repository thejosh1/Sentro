import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class ActiveLoans extends StatefulWidget {
  const ActiveLoans({super.key});

  @override
  State<ActiveLoans> createState() => _ActiveLoansState();
}

class _ActiveLoansState extends State<ActiveLoans> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim1;
  late Animation<double> _progressAnim2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnim1 = Tween<double>(begin: 0, end: 3500000 / 5000000).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _progressAnim2 = Tween<double>(begin: 0, end: 1200000 / 5000000).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _cardHeader({
    required String type,
    required String name,
    required String status,
    required Color statusColor,
  }) {
    return Row(
      children: [
        SvgPicture.asset(takeLoan, width: widthSize(36), height: heightSize(36)),
        SizedBox(width: widthSize(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(text: type, size: 10, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: sGrey2),
            CText(text: name, size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
          ],
        ),
        const Expanded(child: SizedBox.shrink()),
        Container(
          width: widthSize(52),
          height: heightSize(21),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: statusColor.withOpacity(0.1),
          ),
          child: Center(
            child: CText(text: status, size: 12.57, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: statusColor),
          ),
        ),
      ],
    );
  }

  Widget _progressSection({
    required Animation<double> anim,
    required String leftLabel,
    required String rightLabel,
    bool showPercent = false,
    Color activeColor = sNavContainer,
  }) {
    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) {
        final percent = (anim.value * 100).toStringAsFixed(0);
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: anim.value,
                minHeight: heightSize(6),
                backgroundColor: activeColor.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(activeColor),
              ),
            ),
            SizedBox(height: heightSize(9)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(text: showPercent ? '$percent% repaid' : leftLabel, size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                CText(text: rightLabel, size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _cardFooter() {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.repayment,
      ),
      child: Container(
        width: double.maxFinite,
        height: heightSize(38),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: sSentroLightGreen,
        ),
        child: Center(
          child: CText(
            text: 'Repay Loan',
            size: 14,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wMedium,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.takeLoan);
                  },
                  child: Container(
                    width: widthSize(129),
                    height: heightSize(35.67),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(83.34),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CText(
                          text: 'Take Loans',
                          size: 14,
                          fontWeight: CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                        ),
                        SizedBox(width: widthSize(5),),
                        SvgPicture.asset(add, width: widthSize(24), height: heightSize(24),)
                      ],
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: heightSize(23.33),),
            CText(
              text: 'Active Loans',
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              size: 18,
              height: 20/18,
            ),
            SizedBox(height: 2.5,),
            CText(
              text: 'Monitor your active loans',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(20.5)),

            Container(
              padding: EdgeInsets.symmetric(horizontal: widthSize(11), vertical: heightSize(11)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.63), color: sDarkFill),
              child: Column(
                children: [

                  // ── Card 1 — Active ──────────────────────────────
                  _cardShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'Personal Loan', name: '30 May 2026', status: 'Active', statusColor: sNavContainer),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'of N5,000,000 disbursed', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: sGrey1),
                        SizedBox(height: heightSize(8.5)),
                        _progressSection(
                          anim: _progressAnim1,
                          leftLabel: '',
                          rightLabel: 'Due 30 Jun, 2026',
                          showPercent: true,
                          activeColor: sNavContainer,
                        ),
                        SizedBox(height: heightSize(11)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Min. Amount', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                CText(text: 'N10,000', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Early Repayment', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                CText(text: '5% penalty', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Auto Repay', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                Row(
                                  children: [
                                    CText(text: 'Yes', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                                    SizedBox(width: widthSize(2.5)),
                                    SvgPicture.asset(tick, width: widthSize(12), height: heightSize(12)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── Card 2 — Overdue ─────────────────────────────
                  _cardShell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'PERSONAL LOAN', name: '30 May, 2026', status: 'Active', statusColor: sNavContainer),
                        SizedBox(height: heightSize(10)),
                        Padding(
                          padding: EdgeInsets.only(left: widthSize(41)),
                          child: CText(text: 'Loan is overdue, late repayment fine may apply', size: 12, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: sCancel),
                        ),
                        SizedBox(height: heightSize(14)),
                        CText(text: 'N1,200,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'of N5,000,000 disbursed', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: sGrey1),
                        SizedBox(height: heightSize(8.5)),
                        _progressSection(
                          anim: _progressAnim2,
                          leftLabel: '',
                          rightLabel: 'Due 30 Jun, 2026',
                          showPercent: true,
                          activeColor: sNavContainer,
                        ),
                        SizedBox(height: heightSize(11)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Min. Amount', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                CText(text: 'N10,000', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Early Repayment', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                CText(text: '5% penalty', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Auto Repay', size: 10, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                                SizedBox(height: heightSize(0.5)),
                                Row(
                                  children: [
                                    CText(text: 'Yes', size: 12, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
                                    SizedBox(width: widthSize(2.5)),
                                    SvgPicture.asset(tick, width: widthSize(12), height: heightSize(12)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(123)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardShell({required Widget child,}) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.goalsDetails),
      child: Container(
        padding: EdgeInsets.only(
          left: widthSize(15),
          top: heightSize(18),
          right: widthSize(15),
          bottom: heightSize(17),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.72),
          color: sSavingsColor,
        ),
        child: child,
      ),
    );
  }
}