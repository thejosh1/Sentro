import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

// Clear UI configuration model for currency options
class SwapCurrencyDetails {
  final String code;
  final String name;
  final String flag;
  final String symbol;
  final double rateToNgn;
  final String maxLimit;

  const SwapCurrencyDetails({
    required this.code,
    required this.name,
    required this.flag,
    required this.symbol,
    required this.rateToNgn,
    required this.maxLimit,
  });
}

class SwapCurrencyPage extends StatefulWidget {
  const SwapCurrencyPage({super.key});

  @override
  State<SwapCurrencyPage> createState() => _SwapCurrencyPageState();
}

class _SwapCurrencyPageState extends State<SwapCurrencyPage> {
  final TextEditingController _fromAmountController = TextEditingController(text: "0.00");
  final TextEditingController _toAmountController = TextEditingController(text: "0.00");

  // Available country nodes dataset matching prior screen options
  final List<SwapCurrencyDetails> _currencies = [
    SwapCurrencyDetails(code: 'GBP', name: 'Great Britain Pound', flag: britain, symbol: '£', rateToNgn: 1720.00, maxLimit: '£25,000 MAX'),
    SwapCurrencyDetails(code: 'USD', name: 'United States Dollar', flag: america, symbol: '\$', rateToNgn: 1500.00, maxLimit: '\$30,000 MAX'),
    SwapCurrencyDetails(code: 'EUR', name: 'Eurozone Euro', flag: euro, symbol: '€', rateToNgn: 1610.00, maxLimit: '€20,000 MAX'),
    SwapCurrencyDetails(code: 'GHS', name: 'Ghanaian Cedi', flag: ghana, symbol: '₵', rateToNgn: 105.00, maxLimit: '₵100,000 MAX'),
    SwapCurrencyDetails(code: 'RWF', name: 'Rwandan Franc', flag: rwanda, symbol: 'FRw', rateToNgn: 1.15, maxLimit: 'FRw 5,000,000 MAX'),
    SwapCurrencyDetails(code: 'NGN', name: 'Nigerian Naira', flag: naija, symbol: '₦', rateToNgn: 1.00, maxLimit: '₦50,000,000 MAX'),
  ];

  late SwapCurrencyDetails _sourceCurrency;
  late SwapCurrencyDetails _targetCurrency;

  @override
  void initState() {
    super.initState();
    _sourceCurrency = _currencies.firstWhere((c) => c.code == 'GBP');
    _targetCurrency = _currencies.firstWhere((c) => c.code == 'NGN');
    _fromAmountController.addListener(_calculateConversion);
  }

  @override
  void dispose() {
    _fromAmountController.removeListener(_calculateConversion);
    _fromAmountController.dispose();
    _toAmountController.dispose();
    super.dispose();
  }

  // Calculates cross-rates dynamically based on base NGN weights
  double get _currentCrossRate => _sourceCurrency.rateToNgn / _targetCurrency.rateToNgn;

  void _calculateConversion() {
    final input = double.tryParse(_fromAmountController.text) ?? 0.0;
    if (input == 0.0) {
      _toAmountController.text = "0.00";
    } else {
      final converted = input * _currentCrossRate;
      _toAmountController.text = converted.toStringAsFixed(2);
    }
    setState(() {});
  }

  // Dynamic selection drawer configuration factory layout
  void _showCurrencyPicker({required bool isSource}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = AccentController.to.accent.value;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: widthSize(24), vertical: heightSize(20)),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161616) : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: widthSize(40),
                height: heightSize(5),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: heightSize(20)),
            CText(
              text: isSource ? 'Select Source Currency' : 'Select Receive Currency',
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wBold,
            ),
            SizedBox(height: heightSize(16)),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _currencies.length,
                separatorBuilder: (_, __) => Divider(color: isDark ? Colors.white10 : Colors.black45),
                itemBuilder: (context, index) {
                  final item = _currencies[index];
                  final isSelected = isSource ? (_sourceCurrency.code == item.code) : (_targetCurrency.code == item.code);

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      setState(() {
                        if (isSource) {
                          _sourceCurrency = item;
                        } else {
                          _targetCurrency = item;
                        }
                        _calculateConversion();
                      });
                      Get.back();
                    },
                    leading: ClipOval(
                      child: Image.asset(
                        item.flag,
                        width: widthSize(32),
                        height: heightSize(32),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: CText(
                      text: item.code,
                      size: 15,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                    ),
                    subtitle: CText(
                      text: item.name,
                      size: 12,
                      fontFamily: CFONT.FAMILY,
                      color: isDark ? Colors.white54 : sGrey2,
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: accentColor, size: widthSize(22))
                        : null,
                  );
                },
              ),
            ),
            SizedBox(height: heightSize(10)),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        // Active functional themes driven by live state metrics
        final accentColor = AccentController.to.accent.value;
        final inputAmount = double.tryParse(_fromAmountController.text) ?? 0.0;
        final computedReceive = inputAmount > 0.0 ? (inputAmount * _currentCrossRate) : _currentCrossRate;
        final useAccent = !_isDefaultAccent(accentColor);
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heightSize(64)),

                    // ── Header Bar ───────────────────────────────────────────
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        isDark ? arrowBackWhite : arrowBack,
                        width: widthSize(42),
                        height: heightSize(42),
                        colorFilter: useAccent?ColorFilter.mode(accentColor, BlendMode.srcIn):null,
                      ),
                    ),
                    SizedBox(height: heightSize(18.35)),

                    // ── Hero Headers Display ─────────────────────────────────
                    Center(
                      child: Column(
                        children: [
                          CText(
                            text: 'Swap Currency',
                            size: 22.05,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                          ),
                          SizedBox(height: heightSize(6)),
                          CText(
                            text: 'Exchange global values directly inside secure balance pools',
                            size: 14,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: isDark ? sConfirmTextColor : sGrey2,
                            textAlign: TextAlign.center,
                            height: 22.05/14,
                          ),
                          SizedBox(height: heightSize(2.76)),
                          CText(
                            text: '${_sourceCurrency.symbol}1 ~ ${_targetCurrency.symbol}${_currentCrossRate.toStringAsFixed(2)}',
                            size: 16,
                            //fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            color: accentColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(30)),

                    // ── SWAP FROM CONFIGURATION BLOCK ────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(text: 'Swap From:', size: 16, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular),
                        _buildStaticBalancePill(isDark, '${_sourceCurrency.symbol}50,000.00'),
                      ],
                    ),
                    SizedBox(height: heightSize(10)),
                    _buildSwapInputCard(
                      isDark: isDark,
                      controller: _fromAmountController,
                      currencyCode: _sourceCurrency.code,
                      currencyFlag: _sourceCurrency.flag,
                      currencySymbol: _sourceCurrency.symbol,
                      bottomHintWidget: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            inherit: false,
                            fontFamily: CFONT.FAMILY,
                            fontSize: fontSize(12),
                            fontWeight: CFONT.wRegular,
                            color: isDark ? Colors.white : sGrey2,
                          ),
                          children: [
                            // Dynamically extracts the limit number safely (handles single or double spaced currency codes like FRw)
                            TextSpan(text: '${_sourceCurrency.maxLimit.replaceAll('MAX', '').trim()} ', style: TextStyle(height: 18.63/12)),
                            TextSpan(
                              text: 'MAX',
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: CFONT.wRegular,
                                height: 18.63/12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onCurrencyTap: () => _showCurrencyPicker(isSource: true),
                    ),
                    SizedBox(height: heightSize(15)),

                    // ── RECEIVE CONFIGURATION BLOCK ──────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(text: 'Receive', size: 16, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wRegular),
                        _buildStaticBalancePill(isDark, '${_targetCurrency.symbol}10,000.00'),
                      ],
                    ),
                    SizedBox(height: heightSize(8)),
                    _buildSwapInputCard(
                      isDark: isDark,
                      controller: _toAmountController,
                      currencyCode: _targetCurrency.code,
                      currencyFlag: _targetCurrency.flag,
                      currencySymbol: _targetCurrency.symbol,
                      readOnly: false,
                      onCurrencyTap: () => _showCurrencyPicker(isSource: true),
                    ),
                    SizedBox(height: heightSize(24)),

                    // ── TRANSACTION LEDGER SUMMARY REVIEW ─────────────────────
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: widthSize(16), vertical: heightSize(15)),
                      decoration: BoxDecoration(
                        color: isDark ? sDarkFill : sLightFill,
                        borderRadius: BorderRadius.circular(11.17),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Review',
                            size: 16,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            color: accentColor,
                            height: 18.63/16,
                          ),
                          SizedBox(height: heightSize(15)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: widthSize(7)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildReviewRow('Current Rate:', '${_targetCurrency.symbol}${(_currentCrossRate * 1.02).toStringAsFixed(2)}', isDark),
                                _buildDivider(isDark),
                                _buildReviewRow('Spreads:', '${_targetCurrency.symbol}${_currentCrossRate.toStringAsFixed(2)}', isDark),
                                _buildDivider(isDark),
                                _buildReviewRow('Conversion Fee:', '${_targetCurrency.symbol}${30}', isDark),
                                _buildDivider(isDark),
                                _buildReviewRow(
                                  'You will receive',
                                  '${_targetCurrency.symbol}${computedReceive.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                  isDark,
                                  valueColor: accentColor,
                                  valueWeight: CFONT.wBold,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(40)),
                  ],
                ),
              ),
            ),

            // ── Continued Footer Dynamic Navigation Call ────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.confirmTransaction);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: heightSize(55),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: accentColor,
                      ),
                      child: Center(
                        child: CText(
                          text: 'Continue',
                          size: 16,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wMedium,
                          color: isDark?sNavContainer:sActionButton,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(34)),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  // ── Layout Components Base Factory Engines ────────────────────────────────

  Widget _buildStaticBalancePill(bool isDark, String balanceText) {
    final textParts = balanceText.split('.');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widthSize(15), vertical: heightSize(4.59)),
      decoration: BoxDecoration(
        color: isDark ? sDarkFill : sButtonFillDark,
        borderRadius: BorderRadius.circular(124.89),
        border: Border.all(color: isDark ? sDarkBorder : const Color(0xFFDDDDDD)),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(inherit: false, color: isDark ? Colors.white : Colors.black),
          children: [
            TextSpan(text: textParts[0], style: TextStyle(fontSize: fontSize(17.48), fontWeight: CFONT.wRegular,)),
            if (textParts.length > 1)
              TextSpan(text: '.${textParts[1]}', style: TextStyle(fontSize: fontSize(11.03), fontWeight: CFONT.wRegular,)),
          ],
        ),
      ),
    );
  }

  Widget _buildSwapInputCard({
    required bool isDark,
    required TextEditingController controller,
    required String currencyCode,
    required String currencyFlag,
    required String currencySymbol,
    Widget? bottomHintWidget,
    bool readOnly = false,
    VoidCallback? onCurrencyTap,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(widthSize(17.76), heightSize(16), widthSize(22.24),heightSize(14)),
      decoration: BoxDecoration(
        color: isDark ? sDarkFill : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(11.17),
        border: Border.all(color: isDark ? sDarkBorder : Colors.black.withOpacity(0.03)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CText(
                  text: '$currencySymbol ',
                  size: 20,
                  //fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: isDark ? Colors.white : Colors.black,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      fontSize: fontSize(22),
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onCurrencyTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: widthSize(6), vertical: heightSize(5)),
                  decoration: BoxDecoration(
                    color: isDark ? sDarkBorder : sGrey2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          currencyFlag,
                          width: widthSize(24),
                          height: heightSize(24),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: widthSize(8)),
                      CText(
                        text: currencyCode,
                        size: 16,
                        height: 18.63/16,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                      ),
                      SizedBox(width: widthSize(8)),
                      SvgPicture.asset(arrowDown, width: widthSize(22.35), height: heightSize(22.35),),
                    ],
                  ),
                ),
              ),
              if (bottomHintWidget != null) ...[
                SizedBox(height: heightSize(8)),
                bottomHintWidget,
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String title, String value, bool isDark, {Color? valueColor, FontWeight? valueWeight}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          text: title,
          size: 14,
          fontWeight: CFONT.wRegular,
          fontFamily: CFONT.FAMILY,
          color: isDark ? sConfirmTextColor : sGrey2,
        ),
        CText(
          text: value,
          size: 14,
          //fontFamily: CFONT.FAMILY,
          fontWeight: valueWeight ?? CFONT.wMedium,
          color: valueColor ?? (isDark ? Colors.white : Colors.black),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: heightSize(10)),
      child: Divider(
        height: 1,
        thickness: 1,
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.04),
      ),
    );
  }
}