import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class SendSummary extends StatefulWidget {
  const SendSummary({super.key});

  @override
  State<SendSummary> createState() => _SendSummaryState();
}

class _SendSummaryState extends State<SendSummary> {
  late Map<String, dynamic> _txData;
  late String _currencyId;

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  void initState() {
    super.initState();
    // Intercept active route data map or fallback safely to a baseline mock model schema context
    _txData = Get.arguments as Map<String, dynamic>? ?? {
      'currencyId': 'USD',
      'bankNetwork': 'Richmond Bank',
      'accountNumber': '1234567890',
      'accountName': 'Richmond Uche',
      'amount': '100.00',
      'routingNumber': '1234567890',
      'accountType': 'Checking',
    };
    _currencyId = _txData['currencyId'] ?? 'USD';
  }

  // Generate currency formatting specifications matching reference designs
  Map<String, dynamic> _getCurrencyMeta() {
    final String amt = _txData['amount'];
    switch (_currencyId) {
      case 'GBP':
        return {
          'sym': '£',
          'displayAmt': '£$amt',
          'nairaEst': '~ ₦172,000.00',
          'total': '£115.45',
          'totalNaira': '₦198,574.00',
          'flag': britain
        };
      case 'EUR':
        return {
          'sym': '€',
          'displayAmt': '€$amt',
          'nairaEst': '~ ₦150,000.00',
          'total': '€115.45',
          'totalNaira': '₦173,000.45',
          'flag': euro
        };
      case 'GHS':
        return {
          'sym': '₵',
          'displayAmt': '₵$amt',
          'nairaEst': '~ ₦9,500.00',
          'total': '₵115.45',
          'totalNaira': '₦10,967.75',
          'flag': ghana
        }; // Custom GHS metadata schema mapping
      case 'RWF':
        return {
          'sym': 'FRw',
          'displayAmt': 'FRw $amt',
          'nairaEst': '~ ₦115.00',
          'total': 'FRw 101,500.00',
          'totalNaira': '₦116,725.00',
          'flag': rwanda
        }; // Custom RWF metadata schema mapping
      case 'USD':
      default:
        return {
          'sym': '\$',
          'displayAmt': '\$$amt',
          'nairaEst': '~ ₦150,000.00',
          'total': '\$115.45',
          'totalNaira': '₦175,000.45',
          'flag': america
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final meta = _getCurrencyMeta();

    return Scaffold(
      backgroundColor: isDark?Colors.black:Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize(64)),

                  // ── Action Bar Navigation Header Row ─────────────────────
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          isDark ? arrowBackWhite : arrowBack,
                          width: widthSize(42),
                          height: heightSize(42),
                        ),
                      ),
                      SizedBox(width: widthSize(80)),
                      CText(
                        text: 'Confirmation',
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(12)),
                  Center(
                    child: CText(
                      text: '10 Apr, 2026',
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      size: 14,
                      color: isDark ? sConfirmTextColor : sGrey2,
                    ),
                  ),

                  SizedBox(height: heightSize(24)),

                  // ── Main Receipt Base Summary Platform Box ───────────────────
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(widthSize(20)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDark ? sContainerColor : sContainer2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dynamic Hero Display Card Component Block
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: widthSize(
                              20), vertical: heightSize(22)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDark ? sDarkBorder : sLightFill,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText(
                                    text: meta['displayAmt'],
                                    size: 26,
                                    fontFamily: CFONT.FAMILY,
                                    fontWeight: CFONT.wBold,
                                  ),
                                  SizedBox(height: heightSize(2)),
                                  CText(
                                    text: meta['nairaEst'],
                                    size: 12,
                                    //fontFamily: CFONT.FAMILY,
                                    color: isDark ? sDarkHintText : sLightHintText,
                                  ),
                                ],
                              ),
                              // Renders standard custom circular vector flag formats cleanly
                              ClipOval(
                                child: Image.asset(
                                  meta['flag'],
                                  width: widthSize(40),
                                  height: heightSize(40),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: heightSize(24)),

                        // Dynamic Itemized Specifications Matrix Rows List
                        ..._buildContextualReceiptRows(isDark, meta['sym']),

                        // Shared Universal Fee Breakdowns Group
                        _receiptRow(title: 'Fee (VAT & Stamp Duty)',
                            value: '${meta['sym']}15.45',
                            isDark: isDark),
                        SizedBox(height: heightSize(16)),
                        _receiptRow(title: 'Fee (Transaction Fee)',
                            value: '${meta['sym']}15.45',
                            isDark: isDark),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: heightSize(
                              16)),
                          child: Divider(color: isDark ? Colors.white
                              .withOpacity(0.08) : Colors.black.withOpacity(
                              0.06)),
                        ),

                        // Combined Multi-Currency Grand Accounting Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(text: 'Total',
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wRegular,
                                size: 14,
                                color: isDark ? sConfirmTextColor : sGrey2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CText(text: meta['total'],
                                    fontWeight: CFONT.wBold,
                                    size: 18,
                                    fontFamily: CFONT.FAMILY),
                                SizedBox(height: heightSize(2)),
                                CText(text: meta['totalNaira'],
                                    fontWeight: CFONT.wRegular,
                                    size: 12,
                                    color: isDark ? Colors.white.withOpacity(
                                        0.4) : sGrey2),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(40)),
                ],
              ),
            ),
          ),

          // ── Bottom Continued Call to Action Confirmation Trigger ──────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.confirmTransaction);
                  },
                  child: Obx(() {
                    final accent = AccentController.to.accent.value;
                    final useAccent = !_isDefaultAccent(accent);

                    final limeGreen = sNavContainer;
                    final elementAccentColor = useAccent ? accent : limeGreen;
                    return Container(
                      width: double.maxFinite,
                      height: heightSize(55),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: useAccent?elementAccentColor:isDark?limeGreen:sActionButton,
                      ),
                      child: Center(
                        child: CText(
                          text: 'Continue',
                          size: 16,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wMedium,
                          color: isDark?sActionButton:sNavContainer,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: heightSize(34)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Receipts Key-Value Data Dynamic Factory Routing
  List<Widget> _buildContextualReceiptRows(bool isDark, String symbol) {
    switch (_currencyId) {
      case 'GBP': // Displays row configuration based on iPhone 16 Pro Max - 249.png layout schema
        return [
          _receiptRow(
              title: 'Receiver', value: _txData['accountName'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Receiver Bank',
              value: _txData['bankNetwork'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Account Number',
              value: _txData['accountNumber'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(
              title: 'Sort Code', value: _txData['sortCode'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Amount (GBP)',
              value: '$symbol${_txData['amount']}',
              isDark: isDark),
          SizedBox(height: heightSize(16)),
        ];

      case 'EUR': // Displays row configuration based on iPhone 16 Pro Max - 246.png layout schema
        return [
          _receiptRow(
              title: 'Receiver', value: _txData['accountName'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Receiver Bank',
              value: _txData['bankNetwork'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'IBAN', value: _txData['iban'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(
              title: 'Bank Code', value: _txData['bankCode'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(
              title: 'BIC Code', value: _txData['bicCode'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Amount (EUR)',
              value: '$symbol${_txData['amount']}',
              isDark: isDark),
          SizedBox(height: heightSize(16)),
        ];

      case 'GHS': // Specialized dynamic mapping workflow setup optimized for Cedi Nodes
        return [
          _receiptRow(
              title: 'Receiver', value: _txData['accountName'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Network / Bank',
              value: _txData['bankNetwork'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Mobile Wallet / MoMo ID',
              value: _txData['accountNumber'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Amount (GHS)',
              value: '$symbol${_txData['amount']}',
              isDark: isDark),
          SizedBox(height: heightSize(16)),
        ];

      case 'RWF': // Specialized dynamic mapping workflow setup optimized for Mobile Franc Networks
        return [
          _receiptRow(title: 'Receiver Name',
              value: _txData['accountName'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Mobile Network / Bank',
              value: _txData['bankNetwork'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Mobile Number',
              value: _txData['accountNumber'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Amount (RWF)',
              value: '$symbol ${_txData['amount']}',
              isDark: isDark),
          SizedBox(height: heightSize(16)),
        ];

      case 'USD': // Displays row configuration based on iPhone 16 Pro Max - 242.png layout schema
      default:
        return [
          _receiptRow(
              title: 'Receiver', value: _txData['accountName'], isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Receiver Bank',
              value: _txData['bankNetwork'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Country', value: 'United States', isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Routing Number',
              value: _txData['routingNumber'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Account Type',
              value: _txData['accountType'],
              isDark: isDark),
          SizedBox(height: heightSize(16)),
          _receiptRow(title: 'Amount (USD)',
              value: '$symbol${_txData['amount']}',
              isDark: isDark),
          SizedBox(height: heightSize(16)),
        ];
    }
  }

  Widget _receiptRow(
      {required String title, required String value, required bool isDark}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CText(
          text: title,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
          size: 14,
          color: isDark ? Colors.white.withOpacity(0.4) : sGrey2,
        ),
        CText(
          text: value,
          fontWeight: CFONT.wMedium,
          size: 15,
          fontFamily: CFONT.FAMILY,
          color: isDark ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}