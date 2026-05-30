import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

// ── Model ─────────────────────────────────────────────────────────────────────

enum TransactionStatus { successful, failed, pending }

class TransactionItem {
  final String icon;
  final String type;
  final String amount;
  final String time;
  final TransactionStatus status;

  const TransactionItem({
    required this.icon,
    required this.type,
    required this.amount,
    required this.time,
    required this.status,
  });
}

final List<TransactionItem> _dummyTransactions = [
  TransactionItem(icon: transferHistory,  type: 'Transfer to bank',              amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: transferHistory,  type: 'Transfer to Sentro Tag',        amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: data,             type: 'Mobile Data', amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: bettingWhite,     type: 'Betting',                       amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: invest,           type: 'Investment',                    amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: invest,           type: 'Investment - Withdrawal',       amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: loansService,     type: 'Loan',                          amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: loansService,     type: 'Loan - Repayment',              amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: qrPayWhite,       type: 'QR Pay - Received',             amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: qrPayWhite,       type: 'QR Pay - Paid',                 amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: electricity,      type: 'Electricity',                   amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: gift,             type: 'Gift Card - Sell',              amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: gift,             type: 'Gift Card - Buy',               amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: julo,             type: 'Julo Energy - Pay',             amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: savingsWhite,     type: 'Savings',                       amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: savingsWhite,     type: 'Savings - Withdrawal',          amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: cardWhite,        type: 'Card',                          amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.successful),
  TransactionItem(icon: bnpl,             type: 'BNPL - Purchase',               amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.failed),
  TransactionItem(icon: mobileWhite,      type: 'Airtime',                       amount: '₦500.50',     time: '12:45.10 · 14 May, 2026', status: TransactionStatus.failed),
];

// ── Page ──────────────────────────────────────────────────────────────────────

class TransactionHistory extends StatefulWidget {
  final bool showBackButton;
  const TransactionHistory({super.key, this.showBackButton=true});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  String? _openDropdown;

  final List<String> _statuses = ['All', 'Successful', 'Failed', 'Pending'];
  final List<String> _services = ['All', 'Transfer', 'Airtime', 'Data', 'Electricity', 'Betting', 'Investment', 'Loans', 'QR Pay', 'Gift Cards', 'Savings', 'Cards', 'BNPL', 'Julo Energy'];
  final List<String> _months   = ['January 2026', 'February 2026', 'March 2026', 'April 2026', 'May 2026'];

  String _selectedStatus  = 'Status';
  String _selectedService = 'Services';
  String _selectedMonth   = 'May 2026';

  void _toggleFilter(String key) {
    setState(() {
      _openDropdown = _openDropdown == key ? null : key;
    });
  }
  final _searchController = TextEditingController();
  List<TransactionItem> _filtered = _dummyTransactions;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? _dummyTransactions
          : _dummyTransactions
          .where((t) =>
          t.type.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Color _statusColor(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.successful: return sNavContainer;
      case TransactionStatus.failed:     return sRed;
      case TransactionStatus.pending:    return sGrey;
    }
  }

  String _statusLabel(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.successful: return 'Successful';
      case TransactionStatus.failed:     return 'Failed';
      case TransactionStatus.pending:    return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark      = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final listBg     = isDark ? sDarkFill        : colorScheme.surface;
    final listBorder = isDark ? sDarkBorder       : sLightBorder;
    final divider    = isDark
        ? Colors.white.withOpacity(0.07)
        : Colors.black.withOpacity(0.05);
    final iconBg     = isDark
        ? Colors.white.withOpacity(0.08)
        : colorScheme.primary.withOpacity(0.08);
    final typeColor  = isDark ? Colors.white      : colorScheme.onSurface;
    final timeColor  = isDark ? sGrey2            : sLightModeMutedText;
    final amtColor   = isDark ? Colors.white      : colorScheme.onSurface;
    final filterBg   = isDark ? sDarkFill         : colorScheme.surface;
    final filterBdr  = isDark ? sDarkBorder       : sLightBorder;
    final dividerBar = isDark
        ? Colors.white.withOpacity(0.4)
        : Colors.black.withOpacity(0.15);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // ── Scrollable content ─────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize(64)),

                  // ── Header ──────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.showBackButton)
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            isDark ? arrowBackWhite : arrowBack,
                            width: widthSize(42),
                            height: heightSize(42),
                          ),
                        )
                      else
                        SizedBox(width: widthSize(42)),
                      CText(
                        text: 'Transactions History',
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      SvgPicture.asset(
                        isDark?headPhoneWhite:headPhone,
                        width:  widthSize(39.17),
                        height: heightSize(45),
                      ),
                    ],
                  ),

                  SizedBox(height: heightSize(42)),

                  // ── Filter chips ─────────────────────────────
                  // ── Filter chips ─────────────────────────────
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _DropdownBox(
                              header: '',
                              value: _selectedStatus,
                              isOpen: _openDropdown == 'status',
                              onTap: () => _toggleFilter('status'),
                              isDark: isDark,
                              colorScheme: colorScheme,
                              dropdown: _openDropdown == 'status'
                                  ? _FilterDropdown(
                                isDark: isDark,
                                colorScheme: colorScheme,
                                formats: _statuses,
                                selected: _selectedStatus,
                                onSelect: (f) => setState(() {
                                  _selectedStatus = f;
                                  _openDropdown = null;
                                }),
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(width: widthSize(12)),
                          Expanded(
                            child: _DropdownBox(
                              header: '',
                              value: _selectedService,
                              isOpen: _openDropdown == 'service',
                              onTap: () => _toggleFilter('service'),
                              isDark: isDark,
                              colorScheme: colorScheme,
                              dropdown: _openDropdown == 'service'
                                  ? _FilterDropdown(
                                isDark: isDark,
                                colorScheme: colorScheme,
                                formats: _services,
                                selected: _selectedService,
                                onSelect: (f) => setState(() {
                                  _selectedService = f;
                                  _openDropdown = null;
                                }),
                              )
                                  : null,
                            ),
                          ),
                          SizedBox(width: widthSize(12)),
                          Expanded(
                            child: _DropdownBox(
                              header: '',
                              value: _selectedMonth,
                              isOpen: _openDropdown == 'month',
                              onTap: () => _toggleFilter('month'),
                              isDark: isDark,
                              colorScheme: colorScheme,
                              dropdown: _openDropdown == 'month'
                                  ? _FilterDropdown(
                                isDark: isDark,
                                colorScheme: colorScheme,
                                formats: _months,
                                selected: _selectedMonth,
                                onSelect: (f) => setState(() {
                                  _selectedMonth = f;
                                  _openDropdown = null;
                                }),
                              )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: heightSize(18)),

                  // ── Inflow / Outflow ─────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _flowBox('₦50,000.00', 'Inflow',  isDark, colorScheme),
                      SizedBox(width: widthSize(42)),
                      Container(
                        width: 1.5,
                        height: heightSize(34),
                        color: dividerBar,
                      ),
                      SizedBox(width: widthSize(42)),
                      _flowBox('₦50,000.00', 'Outflow', isDark, colorScheme),
                    ],
                  ),

                  SizedBox(height: heightSize(14)),

                  // ── Search + list ────────────────────────────
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listBg,
                      border: Border.all(color: listBorder),
                      boxShadow: isDark
                          ? null
                          : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: heightSize(14)),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: widthSize(18),
                          ),
                          child: AuthSearchField(
                            height:       heightSize(48),
                            borderColor:  filterBdr,
                            color:        listBg,
                            hint:         'Search recent',
                            inputType:    TextInputType.text,
                            error:        '',
                            validFunction: (v) => v!,
                            onChanged:    _onSearch,
                            controller:   _searchController,
                          ),
                        ),

                        SizedBox(height: heightSize(8)),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: widthSize(18),
                            vertical:   heightSize(8),
                          ),
                          itemCount: _filtered.length,
                          separatorBuilder: (_, __) => Container(
                            height: 0.5,
                            color: divider,
                          ),
                          itemBuilder: (context, i) {
                            final t = _filtered[i];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: heightSize(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icon + type + time
                                  Row(
                                    children: [
                                      Container(
                                        width:  widthSize(42),
                                        height: heightSize(42),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: iconBg,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            t.icon,
                                            width:  widthSize(22),
                                            height: heightSize(22),
                                            colorFilter: ColorFilter.mode(
                                              isDark
                                                  ? Colors.white
                                                  : colorScheme.primary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: widthSize(10)),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            text: t.type,
                                            fontFamily: CFONT.FAMILY,
                                            fontWeight: CFONT.wMedium,
                                            size: 14,
                                            color: typeColor,
                                          ),
                                          SizedBox(height: heightSize(2)),
                                          CText(
                                            text: t.time,
                                            fontFamily: CFONT.FAMILY,
                                            fontWeight: CFONT.wRegular,
                                            size: 10,
                                            color: timeColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Amount + status
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      // ₦ uses system font via inherit:false
                                      Text(
                                        t.amount,
                                        style: TextStyle(
                                          inherit: false,
                                          fontSize: fontSize(14),
                                          fontWeight: FontWeight.w600,
                                          color: amtColor,
                                        ),
                                      ),
                                      SizedBox(height: heightSize(2)),
                                      CText(
                                        text: _statusLabel(t.status),
                                        fontFamily: CFONT.FAMILY,
                                        fontWeight: CFONT.wRegular,
                                        size: 10,
                                        color: _statusColor(t.status),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // bottom space so content clears the sticky button
                  SizedBox(height: heightSize(100)),
                ],
              ),
            ),
          ),

          // ── Sticky Download Statement button ───────────────
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.fromLTRB(
              widthSize(25),
              heightSize(12),
              widthSize(25),
              heightSize(32),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: heightSize(55),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.17),
                  border: Border.all(color: sNavContainer),
                ),
                child: Center(
                  child: CText(
                    text: 'Download Statement',
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wMedium,
                    size: 16,
                    color: isDark ? Colors.white : colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter box ─────────────────────────────────────────────────────────────


  // ── Flow box ───────────────────────────────────────────────────────────────

  Widget _flowBox(
      String amount,
      String label,
      bool isDark,
      ColorScheme colorScheme,
      ) {
    return Column(
      children: [
        // ₦ via inherit:false so system font renders the glyph
        Text(
          amount,
          style: TextStyle(
            inherit: false,
            fontSize: fontSize(16),
            fontWeight: FontWeight.w600,
            color: sNavContainer,
          ),
        ),
        SizedBox(height: heightSize(3)),
        CText(
          text: label,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 12,
          color: isDark ? sConfirmTextColor : sLightModeMutedText,
        ),
      ],
    );
  }
}

class _DropdownBox extends StatelessWidget {
  final String header;
  final String value;
  final bool isOpen;
  final VoidCallback onTap;
  final bool isDark;
  final ColorScheme colorScheme;
  final Widget? dropdown;

  const _DropdownBox({
    required this.header,
    required this.value,
    required this.isOpen,
    required this.onTap,
    required this.isDark,
    required this.colorScheme,
    this.dropdown,
  });

  @override
  Widget build(BuildContext context) {
    final filterBg  = isDark ? sDarkFill : colorScheme.surface;
    final filterBdr = isDark ? sDarkBorder : sLightBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header.isNotEmpty) ...[
          CText(
            text: header,
            size: 13,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wRegular,
          ),
          SizedBox(height: heightSize(5)),
        ],

        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: heightSize(51),
            padding: EdgeInsets.symmetric(horizontal: widthSize(12)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(isOpen ? 0 : 10),
                bottomRight: Radius.circular(isOpen ? 0 : 10),
              ),
              color: filterBg,
              border: Border.all(color: filterBdr),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CText(
                    text: value,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    size: 13,
                    color: isDark ? Colors.white : colorScheme.onSurface,
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    arrowDown,
                    width: widthSize(18),
                    height: heightSize(18),
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white54 : Colors.black45,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        if (dropdown != null) dropdown!,
      ],
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final List<String> formats;
  final String selected;
  final ValueChanged<String> onSelect;
  final bool isDark;
  final ColorScheme colorScheme;

  const _FilterDropdown({
    required this.formats,
    required this.selected,
    required this.onSelect,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: isDark ? sDarkBorder : sLightBorder,
        border: Border.all(color: isDark ? sDarkBorder : sLightBorder),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Column(
          children: formats.map((f) {
            final isSelected = f == selected;
            return GestureDetector(
              onTap: () => onSelect(f),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(14),
                  vertical: heightSize(10),
                ),
                color: isDark ? sTierColor : colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CText(
                        text: f,
                        size: 13,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                        color: isSelected ? sNavContainer : (isDark ? Colors.white : colorScheme.onSurface),
                      ),
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width: widthSize(16),
                        height: heightSize(16),
                        colorFilter: const ColorFilter.mode(sNavContainer, BlendMode.srcIn),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}