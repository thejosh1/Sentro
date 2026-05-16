import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

// ── Dummy model ────────────────────────────────────────────────────────────

enum TransactionStatus { successful, failed, pending }

class TransactionItem {
  final String icon;
  final String type;
  final String amount;
  final String time;
  final TransactionStatus status;
  final double iconWidth;
  final double iconHeight;

  const TransactionItem({
    required this.icon,
    required this.type,
    required this.amount,
    required this.time,
    required this.status,
    this.iconWidth = 27.36,
    this.iconHeight = 27.36,
  });
}

final List<TransactionItem> _dummyTransactions = [
  TransactionItem(icon: transfer, type: 'Transfer to Bank', amount: '₦500.50', time: '12:45 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: data, type: 'Mobile Data', amount: '₦1,000.00', time: '10:30 · 14 May, 2026', status: TransactionStatus.successful, iconWidth: 22.8, iconHeight: 20.4),
  TransactionItem(icon: mobileWhite, type: 'Airtime Top-up', amount: '₦200.00', time: '09:15 · 14 May, 2026', status: TransactionStatus.failed, iconWidth: 22.8, iconHeight: 20.4),
  TransactionItem(icon: electricity, type: 'Electricity Bill', amount: '₦5,000.00', time: '08:00 · 13 May, 2026', status: TransactionStatus.successful,),
  TransactionItem(icon: loansService, type: 'Loan Repayment', amount: '₦10,000.00', time: '07:45 · 13 May, 2026', status: TransactionStatus.pending),
  TransactionItem(icon: gift, type: 'Gift Card Purchase', amount: '₦3,500.00', time: '18:20 · 12 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: betting, type: 'Betting Deposit', amount: '₦750.00', time: '16:10 · 12 May, 2026', status: TransactionStatus.failed),
  TransactionItem(icon: savings, type: 'Savings Deposit', amount: '₦20,000.00', time: '14:00 · 11 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: invest, type: 'Investment', amount: '₦500.00', time: '11:30 · 11 May, 2026', status: TransactionStatus.successful, iconWidth: 13.39, iconHeight: 15.73),
  TransactionItem(icon: invest, type: 'Investment - Withdrawal', amount: '₦500.00', time: '11:30 · 11 May, 2026', status: TransactionStatus.successful, iconWidth: 13.39, iconHeight: 15.73),
  TransactionItem(icon: mobileWhite, type: 'Airtime Top-up', amount: '₦100.00', time: '09:00 · 10 May, 2026', status: TransactionStatus.pending, iconWidth: 22.8, iconHeight: 20.4),
];

// ── Screen ─────────────────────────────────────────────────────────────────

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final TextEditingController _searchController = TextEditingController();
  bool isSheetOpen = false;
  List<TransactionItem> _filtered = _dummyTransactions;

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? _dummyTransactions
          : _dummyTransactions
          .where((t) => t.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Color _statusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.successful:
        return sNavContainer;
      case TransactionStatus.failed:
        return sRed;
      case TransactionStatus.pending:
        return sGrey;
    }
  }

  String _statusLabel(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.successful:
        return 'Successful';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.pending:
        return 'Pending';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ───────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: widthSize(35),
                  height: heightSize(35),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      arrowBack,
                      width: widthSize(14.87),
                      height: heightSize(13.12),
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
                CText(
                  text: 'Transactions History',
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                  size: 18,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: widthSize(43.52),
                      height: heightSize(43.52),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.surface,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          headPhone,
                          width: widthSize(25.93),
                          height: heightSize(25.93),
                          colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: widthSize(36.11),
                        height: heightSize(13.89),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.93),
                          color: isDark ? Colors.white : colorScheme.primary,
                        ),
                        child: Center(
                          child: CText(
                            text: 'Help?',
                            fontFamily: CFONT.BOLD,
                            size: 7.41,
                            fontWeight: FontWeight.w700,
                            color: isDark ? sCancel : colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: heightSize(41.9)),

            // ── Filters ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: heightSize(51.19),
                    padding: EdgeInsets.only(left: widthSize(19.89), right: widthSize(24.05)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sDarkFill,
                      border: Border.all(color: sDarkBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(text: 'Status', size: 14, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, height: 17.34 / 14),
                        AnimatedRotation(
                          turns: isSheetOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: SvgPicture.asset(arrowDown, width: widthSize(20), height: heightSize(20)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widthSize(12.1),),
                Expanded(
                  child: Container(
                    height: heightSize(51.19),
                    padding: EdgeInsets.only(left: widthSize(11.39), right: widthSize(15.19)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sDarkFill,
                      border: Border.all(color: sDarkBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(text: 'Services', size: 14, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, height: 17.34 / 14),
                        AnimatedRotation(
                          turns: isSheetOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: SvgPicture.asset(arrowDown, width: widthSize(20), height: heightSize(20)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widthSize(12.1),),
                Expanded(
                  child: Container(
                    height: heightSize(51.19),
                    padding: EdgeInsets.only(left: widthSize(13.98), right: widthSize(15.19)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sDarkFill,
                      border: Border.all(color: sDarkBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(text: 'May 2026', size: 14, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, height: 17.34 / 14),
                        AnimatedRotation(
                          turns: isSheetOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: SvgPicture.asset(arrowDown, width: widthSize(20), height: heightSize(20)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: heightSize(17.9)),

            // ── Inflow / Outflow ─────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CText(text: '₦50,000.00', fontWeight: FontWeight.w500, fontFamily: CFONT.REGULAR, size: 16, color: sNavContainer),
                    SizedBox(height: heightSize(2.76)),
                    CText(text: 'Inflow', fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, size: 12, color: sConfirmTextColor),
                  ],
                ),
                SizedBox(width: widthSize(42)),
                Container(width: widthSize(1.5), height: heightSize(34), color: Colors.white.withOpacity(0.4)),
                SizedBox(width: widthSize(42)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CText(text: '₦50,000.00', fontWeight: FontWeight.w500, fontFamily: CFONT.REGULAR, size: 16, color: sNavContainer),
                    SizedBox(height: heightSize(2.76)),
                    CText(text: 'Outflow', fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, size: 12, color: sConfirmTextColor),
                  ],
                ),
              ],
            ),

            SizedBox(height: heightSize(13.14)),

            // ── Transaction list ─────────────────────────────────
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: sDarkFill,
              ),
              child: Column(
                children: [
                  SizedBox(height: heightSize(16.96),),
                  // ── Search — one for the whole list ──────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize(18)),
                    child: AuthSearchField(
                      height: heightSize(40),
                      borderColor: sDarkBorder,
                      color: sDarkFill,
                      hint: 'Search recent',
                      inputType: TextInputType.text,
                      error: '',
                      validFunction: (v) => v!,
                      onChanged: _onSearch,
                      onSubmitFunction: (q) {},
                      controller: _searchController,
                    ),
                  ),

                  SizedBox(height: heightSize(16)),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: heightSize(16.96),
                      horizontal: widthSize(18),
                    ),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => Padding(
                      padding: EdgeInsets.symmetric(vertical: heightSize(10)),
                      child: Container(height: 0.5, color: Colors.white.withOpacity(0.1)),
                    ),
                    itemBuilder: (context, index) {
                      final t = _filtered[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: widthSize(38),
                                height: heightSize(38),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    t.icon,
                                    width: widthSize(t.iconWidth),
                                    height: heightSize(t.iconHeight),
                                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              SizedBox(width: widthSize(10)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText(text: t.type, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM, size: 14, color: sGrey1),
                                  CText(text: t.time, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, size: 10, color: sGrey2),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CText(text: t.amount, size: 14, fontWeight: FontWeight.w500, fontFamily: CFONT.MEDIUM, color: sGrey1),
                              SizedBox(height: heightSize(2.5)),
                              CText(text: _statusLabel(t.status), size: 10, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, color: _statusColor(t.status)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: heightSize(28)),
            Container(
              height: heightSize(55),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                border: Border.all(color: sNavContainer),
              ),
              child: Center(
                child: CText(
                  text: 'Download Statement',
                  fontWeight: FontWeight.w500,
                  fontFamily: CFONT.MEDIUM,
                  size: 16,
                ),
              ),
            ),
            SizedBox(height: heightSize(29)),
          ],
        ),
      ),
    );
  }
}