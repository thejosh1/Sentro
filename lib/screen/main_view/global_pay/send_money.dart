import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';
import 'package:sentro/core/widgets/text_field.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  late String _currencyId;

  // Dynamic state selectors maps
  final Map<String, String?> _dropdownValues = {
    'Bank/Network': null,
    'Account Type': null,
    'Country': null,
  };

  final Map<String, bool> _dropdownToggleStates = {};

  // Form Field Controllers
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _routingNumberController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _bankCodeController = TextEditingController();
  final TextEditingController _bicCodeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Mock Dropdown Options Assets Lists
  final List<String> _ghanaProviders = [
    'MTN Mobile Money',
    'Vodafone Cash',
    'AirtelTigo Money',
    'Sentro Ghana Bank'
  ];
  final List<String> _rwandaProviders = [
    'MTN MoMo Rwanda',
    'Airtel Money Rwanda',
    'Sentro Rwanda Bank'
  ];
  final List<String> _usdBanks = ['American Bank', 'Chase Bank', 'Sentro Bank'];
  final List<String> _gbpBanks = ['Rich Bank', 'Barclays', 'HSBC UK'];
  final List<String> _eurBanks = ['Rich Bank', 'Deutsche Bank', 'BNP Paribas'];
  final List<String> _usdAccountTypes = ['Checking', 'Savings', 'Corporate'];

  @override
  void initState() {
    super.initState();
    // Intercept active route argument safely, fall back to USD default profile context if empty
    _currencyId = Get.arguments as String? ?? 'USD';
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    _routingNumberController.dispose();
    _sortCodeController.dispose();
    _ibanController.dispose();
    _bankCodeController.dispose();
    _bicCodeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  // Helper context schema maps provider
  Map<String, dynamic> _getCurrencyMeta() {
    switch (_currencyId) {
      case 'GBP':
        return {
          'title': 'Send Money (GBP)',
          'desc': 'Send GBP to beneficiaries of the same currency',
          'rate': '£1 ~ ₦1,720',
          'hint': '£0.00',
          'limit': 'Min £50 - N150,000'
        };
      case 'EUR':
        return {
          'title': 'Send Money (Euro)',
          'desc': 'Send EUR to beneficiaries of the same currency',
          'rate': '€1 ~ ₦1,420',
          'hint': '€0.00',
          'limit': 'Min €50 - N150,000'
        };
      case 'GHS':
        return {
          'title': 'Send Money (GHS)',
          'desc': 'Send Ghanaian Cedi to wallets or local bank nodes',
          'rate': '₵1 ~ ₦95',
          'hint': '₵0.00',
          'limit': 'Min ₵50 - ₵50,000'
        };
      case 'RWF':
        return {
          'title': 'Send Money (RWF)',
          'desc': 'Send Rwandan Franc directly to mobile numbers or local banks',
          'rate': 'FRw1 ~ ₦1.15',
          'hint': 'FRw0.00',
          'limit': 'Min FRw1,000 - FRw500,000'
        };
      case 'USD':
      default:
        return {
          'title': 'Send Money (USD)',
          'desc': 'Send USD to beneficiaries of the same currency',
          'rate': '\$1 ~ ₦1,320',
          'hint': '\$0.00',
          'limit': 'Min \$100 - N150,000'
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final limeGreen = const Color(0xFF9BED6E);
    final meta = _getCurrencyMeta();

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);

        final limeGreen = sNavContainer;
        final elementAccentColor = useAccent ? accent : limeGreen;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heightSize(64)),

                    // ── Top Header Bar Navigation Row ─────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            isDark ? arrowBackWhite : arrowBack,
                            width: widthSize(42),
                            height: heightSize(42),
                          ),
                        ),
                        BalancePill(
                          isDark: isDark,
                          showWallet: false,
                          balance: _currencyId == 'USD'
                              ? '\$50,000.00'
                              : _currencyId == 'GBP'
                              ? '£42,100.00'
                              : _currencyId == 'EUR'
                              ? '€39,400.00'
                              : _currencyId == 'GHS'
                              ? '₵85,000.00'
                              : 'FRw1,200,000.00',
                        ),
                      ],
                    ),

                    SizedBox(height: heightSize(30)),

                    // ── Dynamic Form Titles Group Header Block ──────────────────
                    Center(
                      child: Column(
                        children: [
                          CText(text: meta['title'],
                              size: 20,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wBold),
                          SizedBox(height: heightSize(6)),
                          CText(text: meta['desc'],
                              size: 13,
                              fontFamily: CFONT.FAMILY,
                              color: isDark ? sGrey1 : sGrey2,
                              textAlign: TextAlign.center),
                          SizedBox(height: heightSize(12)),
                          CText(text: meta['rate'],
                            size: 14,
                            fontWeight: CFONT.wMedium,
                            color: useAccent?elementAccentColor:isDark?limeGreen:sActionButton,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: heightSize(32)),

                    // ── Dynamic Entry Form Segment Generator Layouts ──────────────
                    ..._buildDynamicFormFields(isDark, useAccent, elementAccentColor),

                    SizedBox(height: heightSize(16)),

                    // ── Global Standard Universal Amount Field ───────────────────
                    _buildLabel('Amount ($_currencyId)', useAccent: useAccent, elementAccentColor, hasInfo: false),
                    AppTextField(
                      hasBottomMargin: false,
                      verticalPadding: 19,
                      hint: meta['hint'],
                      controller: _amountController,
                      inputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        NairaInputFormatter(),
                      ],
                      suffixWidth: 156,
                      suffixWidget: Container(
                        margin: EdgeInsets.only(right: widthSize(12)),
                        padding: EdgeInsets.symmetric(horizontal: widthSize(8),
                            vertical: heightSize(5)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isDark ? sContainerColor : sContainer2,
                        ),
                        child: Center(
                          child: CText(
                            text: meta['limit'],
                            size: 10,
                            fontWeight: CFONT.wRegular,
                            color: isDark ? sGrey1 : sGrey2,
                          ),
                        ),
                      ),
                      error: '',
                      validFunction: (_) => null,
                    ),
                    SizedBox(height: heightSize(40)),
                  ],
                ),
              ),
            ),

            // ── Bottom Continued Action Floating CTA ─────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          Routes.sendSummary,
                          arguments: {
                            'currencyId': _currencyId,
                            'bankNetwork': _dropdownValues['Bank/Network'] ?? 'Sentro Network node',
                            'accountNumber': _accountNumberController.text.isEmpty ? '1234567890' : _accountNumberController.text,
                            'accountName': _accountNameController.text.isEmpty ? 'Richmond Uche' : _accountNameController.text,
                            'amount': _amountController.text.isEmpty ? '100.00' : _amountController.text,
                            'routingNumber': _routingNumberController.text.isEmpty ? '1234567890' : _routingNumberController.text,
                            'accountType': _dropdownValues['Account Type'] ?? 'Checking',
                            'iban': _ibanController.text.isEmpty ? 'IUHH43872GHI3' : _ibanController.text,
                            'bankCode': _bankCodeController.text.isEmpty ? '3RUN' : _bankCodeController.text,
                            'bicCode': _bicCodeController.text.isEmpty ? '3728H2A' : _bicCodeController.text,
                            'sortCode': _sortCodeController.text.isEmpty ? '1234567890' : _sortCodeController.text,
                          }
                      );
                    },
                    child: Container(
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
                          color: sActionButton,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  // Form Router Switch Architecture Context
  List<Widget> _buildDynamicFormFields(bool isDark, bool useAccent, Color accent) {
    switch (_currencyId) {
      case 'GBP':
        return [
          _buildLabel('Bank', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField('Bank/Network', _gbpBanks, 'Select Bank', isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Number', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNumberController, 'Account Number', TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Name', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNameController, 'Account Name', TextInputType.text),
          SizedBox(height: heightSize(16)),
          _buildLabel('Sort Code', hasInfo: true, useAccent: useAccent, accent),
          _buildTextField(
              _sortCodeController, 'Sort Code', TextInputType.number),
          SizedBox(height: heightSize(16)),
        ];

      case 'EUR':
        return [
          _buildLabel('Bank', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField('Bank/Network', _eurBanks, 'Select Bank', isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Number', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNumberController, 'Account Number', TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Name', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNameController, 'Account Name', TextInputType.text),
          SizedBox(height: heightSize(16)),
          _buildLabel('IBAN', hasInfo: true, useAccent: useAccent, accent),
          _buildTextField(_ibanController, 'IBAN', TextInputType.text),
          SizedBox(height: heightSize(16)),
          _buildLabel('Bank Code', hasInfo: true, useAccent: useAccent, accent),
          _buildTextField(_bankCodeController, 'Bank Code', TextInputType.text),
          SizedBox(height: heightSize(16)),
          _buildLabel('BIC Code', hasInfo: true, useAccent: useAccent, accent),
          _buildTextField(_bicCodeController, 'BIC Code', TextInputType.text),
          SizedBox(height: heightSize(16)),
        ];

      case 'GHS': // Ghanaian Cedi Specific Implementation Form
        return [
          _buildLabel('Select Network Provider / Local Bank', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField(
              'Bank/Network', _ghanaProviders, 'Select Network or Bank',
              isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Mobile Money / Account Number', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNumberController, 'Enter Phone Number or Bank Account',
              TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Recipient Account Name', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(_accountNameController, 'Recipient Account Name',
              TextInputType.text),
          SizedBox(height: heightSize(16)),
        ];

      case 'RWF': // Rwandan Franc Specific Implementation Form
        return [
          _buildLabel('Select Mobile Money Network / Bank', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField(
              'Bank/Network', _rwandaProviders, 'Select Mobile Network or Bank',
              isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Mobile Number / Account Number', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNumberController, 'Enter Mobile Number or Bank Account',
              TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Beneficiary Account Name', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(_accountNameController, 'Beneficiary Account Name',
              TextInputType.text),
          SizedBox(height: heightSize(16)),
        ];

      case 'USD':
      default:
        return [
          _buildLabel('Country', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField(
              'Country', ['United States'], 'United States', isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Bank', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField('Bank/Network', _usdBanks, 'Select Bank', isDark),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Number', hasInfo: false, useAccent: useAccent, accent),
          _buildTextField(
              _accountNumberController, 'Account Number', TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Routing Number', hasInfo: true, useAccent: useAccent, accent),
          _buildTextField(
              _routingNumberController, 'Routing Number', TextInputType.number),
          SizedBox(height: heightSize(16)),
          _buildLabel('Account Type', hasInfo: false, useAccent: useAccent, accent),
          _buildDropdownField(
              'Account Type', _usdAccountTypes, 'Select Account Type', isDark),
          SizedBox(height: heightSize(16)),
        ];
    }
  }

  // Custom Form Components Wrappers
  Widget _buildLabel(String text, Color accent, {bool hasInfo = false, bool useAccent = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: heightSize(8), left: widthSize(2)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CText(text: text,
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular),
          if (hasInfo) ...[
            SizedBox(width: widthSize(4)),
            SvgPicture.asset(
              infoCirclePay, width: widthSize(18), height: heightSize(18),
              colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint,
      TextInputType type) {
    return AppTextField(
      hasBottomMargin: false,
      verticalPadding: 19,
      hint: hint,
      controller: ctrl,
      inputType: type,
      error: '',
      validFunction: (_) => null,
    );
  }

  Widget _buildDropdownField(String labelKey, List<String> options, String hint,
      bool isDark) {
    final isOpen = _dropdownToggleStates[labelKey] == true;
    final selectedValue = _dropdownValues[labelKey];

    return _SelectorBox(
      isDark: isDark,
      isOpen: isOpen,
      label: selectedValue ?? hint,
      isEmpty: selectedValue == null,
      onTap: () async {
        FocusScope.of(context).unfocus();
        setState(() => _dropdownToggleStates[labelKey] = true);

        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) =>
              _BottomSheet(
                isDark: isDark,
                title: labelKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((item) {
                    final isSelected = item == selectedValue;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _dropdownValues[labelKey] = item);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: heightSize(10)),
                        padding: EdgeInsets.symmetric(horizontal: widthSize(16),
                            vertical: heightSize(14)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isDark ? sDarkFill : const Color(0xFFF7F7F7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CText(
                              text: item,
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: isSelected ? CFONT.wMedium : CFONT
                                  .wRegular,
                              color: isSelected ? sNavContainer : (isDark
                                  ? Colors.white
                                  : sActionButton),
                            ),
                            if (isSelected)
                              SvgPicture.asset(
                                tickLight,
                                width: widthSize(18),
                                height: heightSize(18),
                                colorFilter: const ColorFilter.mode(
                                    sNavContainer, BlendMode.srcIn),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
        );
        setState(() => _dropdownToggleStates[labelKey] = false);
      },
    );
  }
}

// ── Shared Functional Reusable Subcomponents UI Layout Boxes ─────────────────

class _SelectorBox extends StatelessWidget {
  final bool isDark;
  final bool isOpen;
  final String label;
  final bool isEmpty;
  final VoidCallback onTap;

  const _SelectorBox(
      {required this.isDark, required this.isOpen, required this.label, required this.isEmpty, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: heightSize(55),
        padding: EdgeInsets.symmetric(horizontal: widthSize(16)),
        decoration: BoxDecoration(
          color: isDark ? sDarkFill : sLightFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isOpen ? (isDark ? Colors.white.withOpacity(0.15) : Colors
                  .black.withOpacity(0.15)) : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(
              text: label,
              size: 14,
              fontFamily: CFONT.FAMILY,
              color: isEmpty ? (isDark ? Colors.white.withOpacity(0.24) : Colors
                  .black.withOpacity(0.25)) : (isDark ? Colors.white : Colors
                  .black),
            ),
            Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: isDark ? Colors.white.withOpacity(0.4) : Colors.black
                    .withOpacity(0.4), size: widthSize(20))
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final bool isDark;
  final String title;
  final Widget child;

  const _BottomSheet(
      {required this.isDark, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widthSize(24)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141414) : Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: widthSize(40),
              height: heightSize(4),
              margin: EdgeInsets.only(bottom: heightSize(20)),
              decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          CText(text: title,
              size: 18,
              fontWeight: CFONT.wBold,
              fontFamily: CFONT.FAMILY),
          SizedBox(height: heightSize(20)),
          child,
          SizedBox(height: heightSize(20)),
        ],
      ),
    );
  }
}