import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/goals_model.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class ActiveGoals extends StatefulWidget {
  const ActiveGoals({super.key});

  @override
  State<ActiveGoals> createState() => _ActiveGoalsState();
}

class _ActiveGoalsState extends State<ActiveGoals> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim;
  late Animation<double> _dollarProgressAnim;

  static const double _current = 3500000;
  static const double _target = 5000000;
  static const double _dollarCurrent = 8200;
  static const double _dollarTarget = 20000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnim = Tween<double>(begin: 0, end: _current / _target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _dollarProgressAnim = Tween<double>(begin: 0, end: _dollarCurrent / _dollarTarget).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── Shared card sections ───────────────────────────────────────────────

  Widget _cardHeader({
    required String type,
    required String name,
    required String status,
    required Color statusColor,
    required bool isDark
  }) {
    return Row(
      children: [
        SvgPicture.asset(barChat, width: widthSize(38), height: heightSize(38)),
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
            color: isDark?statusColor.withOpacity(0.1):statusColor.withOpacity(0.2),
          ),
          child: Center(
            child: CText(text: status, size: 12.57, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?statusColor:sActionButton),
          ),
        ),
      ],
    );
  }

  Widget _cardFooter({
    required String interestRate,
    required String interestPaid,
    required bool reinvest,
    Color? rateColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(text: 'Interest Rate', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, size: 10, color: sGrey2),
            CText(text: interestRate, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 12, color: rateColor),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(text: 'Interest Paid', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, size: 10, color: sGrey2),
            CText(text: interestPaid, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 12),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(text: 'Reinvest', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, size: 10, color: sGrey2),
            Row(
              children: [
                CText(text: reinvest ? 'Yes' : 'No', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 12),
                if (reinvest) ...[
                  SizedBox(width: widthSize(2.5)),
                  SvgPicture.asset(tick, width: widthSize(12), height: heightSize(12)),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _payoutBox({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.maxFinite,
      height: heightSize(51),
      padding: EdgeInsets.only(left: widthSize(14), top: heightSize(6)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(0.05),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(text: label, size: 10, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: sGrey2),
          SizedBox(height: heightSize(2)),
          CText(text: value, size: 15, fontWeight: CFONT.wMedium, fontFamily: CFONT.FAMILY, color: color),
        ],
      ),
    );
  }

  Widget _progressSection({
    required Animation<double> anim,
    required String leftLabel,
    required String rightLabel,
    bool showPercent = false,
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
                backgroundColor: sNavContainer.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(sNavContainer),
              ),
            ),
            SizedBox(height: heightSize(9)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(text: showPercent ? '$percent% complete' : leftLabel, size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                CText(text: rightLabel, size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _cardShell({required Widget child, required GoalModel goal, required bool isDark}) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.goalsDetails, arguments: goal),
      child: Container(
        padding: EdgeInsets.only(
          left: widthSize(15),
          top: heightSize(18),
          right: widthSize(15),
          bottom: heightSize(17),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.72),
          color: isDark?sSavingsColor:sLightFill,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(isDark?arrowBackWhite:arrowBack, width: widthSize(42), height: heightSize(42)),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.startSaving),
                  child: Container(
                    width: widthSize(126),
                    height: heightSize(35.67),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(83.34),
                      color: isDark?Colors.white.withOpacity(0.1):Colors.black.withOpacity(0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CText(text: 'New Goal', size: 14, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY),
                        SizedBox(width: widthSize(5)),
                        SvgPicture.asset(add, width: widthSize(24), height: heightSize(24)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightSize(23.3)),
            CText(text: 'Active Goals', fontFamily: CFONT.FAMILY, size: 18, fontWeight: CFONT.wMedium),
            SizedBox(height: heightSize(2.5)),
            CText(text: 'Monitor your savings progress', fontFamily: CFONT.FAMILY, size: 14, fontWeight: CFONT.wRegular, height: 20 / 14, color: isDark?sConfirmTextColor:sGrey2),
            SizedBox(height: heightSize(20.5)),

            Container(
              padding: EdgeInsets.symmetric(horizontal: widthSize(11), vertical: heightSize(11)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.63), color: isDark?sDarkFill:Colors.black.withOpacity(0.1)),
              child: Column(
                children: [

                  // ── 1. Target Savings ──────────────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Target Savings',
                      name: 'Equipment Funds',
                      status: 'Active',
                      balance: 'N3,500,000',
                      target: 'N5,000,000',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      matures: '30 Jun, 2026',
                      reinvest: true,
                      subtitle: 'of N5,000,000 goal',
                      accentColor: sNavContainer,
                      progressValue: _current / _target,
                      hasProgress: true,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'Target Savings', name: 'Equipment Funds', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'of N5,000,000 goal', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _progressSection(anim: _progressAnim, leftLabel: '', rightLabel: 'Matures 30 Jun, 2026', showPercent: true),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '10% p.a', interestPaid: 'Monthly', reinvest: true),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 2. FGN Treasury Bills ──────────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'FGN Treasury Bills',
                      name: 'Q2 2026 T-Bills',
                      status: 'Active',
                      target: 'N578,125 on July 15',
                      balance: 'N3,500,000',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      matures: '30 Jun, 2026',
                      reinvest: true,
                      subtitle: 'CBN-backed · Zero risk',
                      accentColor: sPurple,
                      hasProgress: false,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'FGN TREASURY BILLS', name: 'Q2 2026 T-Bills', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'CBN-backed · Zero risk', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _payoutBox(label: 'Next interest payout', value: 'N578,125 on July 15', color: sPurple),
                        SizedBox(height: heightSize(9)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(text: '91 days tenor', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                            CText(text: 'Matures 30 Jun, 2026', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                          ],
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '10% p.a', interestPaid: 'Monthly', reinvest: true, rateColor: sPurple),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 3. Dollar Savings ──────────────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Dollar Savings',
                      name: 'USD Savings Vault',
                      status: 'Active',
                      balance: '\$8,200.00',
                      target: '\$20,000',
                      interestRate: '5.7% p.a',
                      interestPaid: 'Monthly',
                      matures: '30 Jun, 2026',
                      reinvest: false,
                      subtitle: '~ N12,382,000 at current rate (N135)',
                      accentColor: sNavContainer,
                      progressValue: _dollarCurrent / _dollarTarget,
                      hasProgress: true,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'DOLLAR SAVINGS', name: 'USD Savings Vault', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N8,200.00', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: '~ N12,382,000 at current rate (N135)', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _progressSection(
                          anim: _dollarProgressAnim,
                          leftLabel: '\$8,200 of \$20,000',
                          rightLabel: '· Matures 30 Jun, 2026',
                          showPercent: false,
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '5.7% p.a', interestPaid: 'Monthly', reinvest: false),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 4. Fixed Deposit ───────────────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Fixed Deposit',
                      name: 'New Car Lock',
                      status: 'Locked',
                      balance: 'N3,500,000',
                      target: 'N578,125 on July 15',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      matures: '30 Jun, 2026',
                      reinvest: true,
                      subtitle: 'Locked until 30 Jun, 2026',
                      accentColor: sLightBlue,
                      hasProgress: false,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'FIXED DEPOSIT', name: 'New Car Lock', status: 'Locked', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'Locked until 30 Jun, 2026', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _payoutBox(label: 'Projected total at maturity', value: 'N578,125 on July 15', color: sLightBlue),
                        SizedBox(height: heightSize(9)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(text: '180 days', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                            CText(text: 'Matures 30 Jun, 2026', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                          ],
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Interest Rate', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, size: 10, color: sGrey2),
                                CText(text: '10% p.a', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 12, color: sLightBlue),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(text: 'Reinvest', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, size: 10, color: sGrey2),
                                Row(
                                  children: [
                                    CText(text: 'Yes', fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium, size: 12),
                                    SizedBox(width: widthSize(2.5)),
                                    SvgPicture.asset(tick, width: widthSize(12), height: heightSize(12)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 5. Flexible Savings (Amber) ────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Flexible Savings',
                      name: 'Business Vault',
                      target: 'N578,125 on July 15',
                      status: 'Active',
                      balance: 'N3,500,000',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      matures: '30 Jun, 2026',
                      reinvest: true,
                      subtitle: 'CBN-backed · Zero risk',
                      accentColor: sAmber,
                      hasProgress: false,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'FLEXIBLE SAVINGS', name: 'Business Vault', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'CBN-backed · Zero risk', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _payoutBox(label: 'Next interest payout', value: 'N578,125 on July 15', color: sAmber),
                        SizedBox(height: heightSize(9)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(text: '91 days', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                            CText(text: 'Matures 30 Jun, 2026', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                          ],
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '10% p.a', interestPaid: 'Monthly', reinvest: true, rateColor: sAmber),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 6. Mutual Fund ─────────────────────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Mutual Fund',
                      name: 'New Car Lock',
                      status: 'Active',
                      balance: 'N3,500,000',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      target: 'N578,125,000',
                      matures: 'Withdraw anytime',
                      reinvest: true,
                      subtitle: '+ ₦246,700 interest earned',
                      accentColor: sLilac,
                      hasProgress: false,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'MUTUAL FUND', name: 'New Car Lock', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: '+ ₦246,700 interest earned', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _payoutBox(label: 'Portfolio value today', value: 'N578,125,000', color: sLilac),
                        SizedBox(height: heightSize(9)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(text: 'Open-ended', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                            CText(text: 'Withdraw anytime', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                          ],
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '10% p.a', interestPaid: 'Monthly', reinvest: true, rateColor: sLilac),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(13)),

                  // ── 7. Flexible Savings (SeaGreen) ────────────
                  _cardShell(
                    goal: GoalModel(
                      type: 'Flexible Savings',
                      name: 'Business Vault',
                      status: 'Active',
                      balance: 'N3,500,000',
                      target: 'N578,125,000',
                      interestRate: '10% p.a',
                      interestPaid: 'Monthly',
                      matures: 'Withdraw anytime',
                      reinvest: true,
                      subtitle: 'No lock-in · Withdraw anytime',
                      accentColor: sSeaGreen,
                      hasProgress: false,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cardHeader(type: 'FLEXIBLE SAVINGS', name: 'Business Vault', status: 'Active', statusColor: sNavContainer, isDark: isDark,),
                        SizedBox(height: heightSize(18)),
                        CText(text: 'N3,500,000', size: 18, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wBold),
                        SizedBox(height: heightSize(2.5)),
                        CText(text: 'No lock-in · Withdraw anytime', size: 11, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, color: isDark?sGrey1:sGrey2),
                        SizedBox(height: heightSize(8.5)),
                        _payoutBox(label: 'Portfolio value today', value: 'N578,125,000', color: sSeaGreen),
                        SizedBox(height: heightSize(9)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(text: 'Open-ended', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                            CText(text: 'Withdraw anytime', size: 11, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular, color: sGrey2),
                          ],
                        ),
                        SizedBox(height: heightSize(11)),
                        Divider(color: sDarkBorder),
                        SizedBox(height: heightSize(10)),
                        _cardFooter(interestRate: '10% p.a', interestPaid: 'Monthly', reinvest: true, rateColor: sSeaGreen),
                      ],
                    ),
                    isDark: isDark,
                  ),

                  SizedBox(height: heightSize(36)),
                ],
              ),
            ),
            SizedBox(height: heightSize(67)),
          ],
        ),
      ),
    );
  }
}