import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';


// ── Data ──────────────────────────────────────────────────────────────────────

class _MonthYear {
  final int month;
  final int year;
  _MonthYear(this.month, this.year);

  String get label {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${names[month - 1]} $year';
  }

  bool isBefore(_MonthYear other) =>
      year < other.year || (year == other.year && month < other.month);

  bool isAfter(_MonthYear other) =>
      year > other.year || (year == other.year && month > other.month);
}

List<_MonthYear> _buildMonthOptions() {
  final now = DateTime.now();
  final options = <_MonthYear>[];
  for (int i = 0; i < 24; i++) {
    final dt = DateTime(now.year, now.month - i, 1);
    options.add(_MonthYear(dt.month, dt.year));
  }
  return options;
}

const _formats = ['PDF', 'Excel', 'Image'];

// ── Page ──────────────────────────────────────────────────────────────────────

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  final _monthOptions = _buildMonthOptions();

  late _MonthYear _startDate;
  late _MonthYear _endDate;
  String _format = 'PDF';
  bool _termsAccepted = false;
  String? _openDropdown;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _endDate = _MonthYear(now.month, now.year);
    final start = DateTime(now.year, now.month - 2, 1);
    _startDate = _MonthYear(start.month, start.year);
  }

  void _toggle(String key) =>
      setState(() => _openDropdown = _openDropdown == key ? null : key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize(64)),

                  // ── Header ───────────────────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          isDark?arrowBackWhite:arrowBack,
                          width: widthSize(42),
                          height: heightSize(42),
                        ),
                      ),
                      const Spacer(),
                      CText(
                        text: 'Account Statement',
                        size: 18,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        height: 20 / 18,
                      ),
                      const Spacer(),
                    ],
                  ),

                  SizedBox(height: heightSize(51)),

                  CText(
                    text: 'GENERATE ACCOUNT STATEMENT',
                    size: 12,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    color: isDark?sGrey1:sGrey2,
                  ),

                  SizedBox(height: heightSize(16)),

                  // ── Form card ─────────────────────────────
                  Container(
                    padding: EdgeInsets.only(
                      left: widthSize(16),
                      top: heightSize(22),
                      right: widthSize(16),
                      bottom: heightSize(22),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark?sDarkFill:sLightFill,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Start + End ─────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: _DropdownBox(
                                header: 'Start Date',
                                value: _startDate.label,
                                isOpen: _openDropdown == 'start',
                                onTap: () => _toggle('start'),
                                isDark: isDark,
                                dropdown: _openDropdown == 'start'
                                    ? _MonthDropdown(
                                  isDark: isDark,
                                  options: _monthOptions,
                                  selected: _startDate,
                                  disableAfter: _endDate,
                                  onSelect: (m) => setState(() {
                                    _startDate = m;
                                    _openDropdown = null;
                                  }),
                                )
                                    : null,
                              ),
                            ),
                            SizedBox(width: widthSize(12)),
                            Expanded(
                              child: _DropdownBox(
                                header: 'End Date',
                                value: _endDate.label,
                                isOpen: _openDropdown == 'end',
                                onTap: () => _toggle('end'),
                                isDark: isDark,
                                dropdown: _openDropdown == 'end'
                                    ? _MonthDropdown(
                                  isDark: isDark,
                                  options: _monthOptions,
                                  selected: _endDate,
                                  disableBefore: _startDate,
                                  onSelect: (m) => setState(() {
                                    _endDate = m;
                                    _openDropdown = null;
                                  }),
                                )
                                    : null,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: heightSize(15)),

                        // ── Format ──────────────────────────
                        _DropdownBox(
                          header: 'Document Format',
                          value: _format,
                          isOpen: _openDropdown == 'format',
                          onTap: () => _toggle('format'),
                          isDark: isDark,
                          dropdown: _openDropdown == 'format'
                              ? _FormatDropdown(
                            isDark: isDark,
                            formats: _formats,
                            selected: _format,
                            onSelect: (f) => setState(() {
                              _format = f;
                              _openDropdown = null;
                            }),
                          )
                              : null,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(16)),

                  // ── Email notice ──────────────────────────
                  // Row(
                  //   children: [
                  //     Container(
                  //       width: widthSize(28),
                  //       height: heightSize(28),
                  //       decoration: BoxDecoration(
                  //         color: sNavContainer.withOpacity(0.15),
                  //         borderRadius: BorderRadius.circular(6),
                  //       ),
                  //       child: Center(
                  //         child: SvgPicture.asset(
                  //           emailIcon,
                  //           width: widthSize(16),
                  //           height: heightSize(16),
                  //           colorFilter: ColorFilter.mode(
                  //             sNavContainer, BlendMode.srcIn,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: widthSize(8)),
                  //     Expanded(
                  //       child: RichText(
                  //         text: TextSpan(
                  //           style: TextStyle(
                  //             fontSize: fontSize(12),
                  //             fontFamily: CFONT.FAMILY,
                  //             fontWeight: CFONT.wRegular,
                  //             color: sNavContainer,
                  //           ),
                  //           children: const [
                  //             TextSpan(
                  //               text: 'Account statement be sent this email ',
                  //             ),
                  //             TextSpan(
                  //               text: 'u***da@***.com',
                  //               style: TextStyle(fontWeight: FontWeight.w600),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //
                  // SizedBox(height: heightSize(16)),

                  // ── Terms card ────────────────────────────
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(16),
                      vertical: heightSize(16),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sSentroLightGreen.withOpacity(0.25),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                text: 'Terms and conditions',
                                size: 14,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wMedium,
                                height: 18.63/14,
                              ),
                              SizedBox(height: heightSize(6)),
                              CText(
                                text:
                                'By confirming, you authorise Sentro to send your bank '
                                    'transaction history from the provided dates to the email '
                                    'address attached to your account.',
                                size: 12,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wRegular,
                                color: Colors.white
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: widthSize(12)),
                        // ── Toggle ─────────────────────────
                        GestureDetector(
                          onTap: () =>
                              setState(() => _termsAccepted = !_termsAccepted),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeInOut,
                            width: widthSize(54),
                            height: heightSize(28),
                            padding: EdgeInsets.symmetric(
                              horizontal: widthSize(4),
                              vertical: heightSize(3),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: _termsAccepted
                                  ? sNavContainer
                                  : sDarkBorder,
                            ),
                            child: Row(
                              mainAxisAlignment: _termsAccepted
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
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

                  SizedBox(height: heightSize(40)),
                ],
              ),
            ),
          ),

          // ── Bottom button ─────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              widthSize(25),
              0,
              widthSize(25),
              heightSize(42),
            ),
            child: GestureDetector(
              onTap: _termsAccepted ? () {
                Get.toNamed(Routes.confirmPin);
              } : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.maxFinite,
                height: heightSize(55),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.17),
                  border: Border.all(
                    color: _termsAccepted
                        ? sNavContainer
                        : sDarkBorder,
                  ),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Request Statement',
                    size: 16,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dropdown trigger ──────────────────────────────────────────────────────────

class _DropdownBox extends StatelessWidget {
  final String header;
  final String value;
  final bool isOpen;
  final VoidCallback onTap;
  final Widget? dropdown;
  final bool isDark;

  const _DropdownBox({
    required this.header,
    required this.value,
    required this.isOpen,
    required this.onTap,
    required this.isDark,
    this.dropdown,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          text: header,
          size: 14,
          fontWeight: CFONT.wRegular,
          fontFamily: CFONT.FAMILY,
        ),
        SizedBox(height: heightSize(6)),
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: heightSize(51),
            padding: EdgeInsets.symmetric(horizontal: widthSize(14)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(isOpen ? 0 : 10),
                bottomRight: Radius.circular(isOpen ? 0 : 10),
              ),
              color: isDark?sDarkFill:sLightFill,
              border: Border.all(
                color: isOpen ? sNavContainer : sDarkBorder,
              ),
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
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    arrowDown,
                    width: widthSize(20),
                    height: heightSize(20),
                    colorFilter: isDark?null:ColorFilter.mode(sGrey2, BlendMode.srcIn),
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

// ── Month picker ──────────────────────────────────────────────────────────────

class _MonthDropdown extends StatelessWidget {
  final List<_MonthYear> options;
  final _MonthYear selected;
  final _MonthYear? disableBefore;
  final _MonthYear? disableAfter;
  final ValueChanged<_MonthYear> onSelect;
  final bool isDark;

  const _MonthDropdown({
    required this.options,
    required this.selected,
    required this.onSelect,
    required this.isDark,
    this.disableBefore,
    this.disableAfter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: heightSize(200)),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: isDark?sDarkBorder:sLightBorder,
        border: Border.all(color: sNavContainer),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            final m = options[index];
            final isSelected =
                m.month == selected.month && m.year == selected.year;
            final isDisabled =
                (disableBefore != null && m.isBefore(disableBefore!)) ||
                    (disableAfter != null && m.isAfter(disableAfter!));

            return GestureDetector(
              onTap: isDisabled ? null : () => onSelect(m),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(14),
                  vertical: heightSize(12),
                ),
                color: Colors.transparent,
                child: CText(
                  text: m.label,
                  size: 13,
                  fontFamily: CFONT.FAMILY,
                  fontWeight:
                  isSelected ? CFONT.wMedium : CFONT.wRegular,
                  color: isDisabled
                      ? sGrey1.withOpacity(0.35)
                      : isSelected
                      ? sNavContainer
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Format picker ─────────────────────────────────────────────────────────────

class _FormatDropdown extends StatelessWidget {
  final List<String> formats;
  final String selected;
  final bool isDark;
  final ValueChanged<String> onSelect;

  const _FormatDropdown({
    required this.formats,
    required this.selected,
    required this.onSelect,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: isDark?sDarkBorder:sLightBorder,
        border: Border.all(color: sNavContainer),
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
                  vertical: heightSize(13),
                ),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      text: f,
                      size: 13,
                      fontFamily: CFONT.FAMILY,
                      fontWeight:
                      isSelected ? CFONT.wMedium : CFONT.wRegular,
                      color: isSelected ? sNavContainer : null,
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width: widthSize(16),
                        height: heightSize(16),
                        colorFilter: ColorFilter.mode(
                          sNavContainer, BlendMode.srcIn,
                        ),
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
