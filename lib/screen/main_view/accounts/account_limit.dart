import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

const _accounts = [
  'Main Account ~ ₦100,000',
  'Corporate Account ~ ₦1,000,000',
  'Savings Account ~ ₦100,000',
];

class AccountLimit extends StatefulWidget {
  const AccountLimit({super.key});

  @override
  State<AccountLimit> createState() => _AccountLimitState();
}

class _AccountLimitState extends State<AccountLimit> {
  String _account = 'Main Account ~ ₦100,000';

  final TextEditingController amountController =
  TextEditingController();

  bool _termsAccepted = false;
  String? _openDropdown;

  void _toggle(String key) {
    setState(() {
      _openDropdown =
      _openDropdown == key ? null : key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(25),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize(64)),

                  /// HEADER
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          arrowBackWhite,
                          width: widthSize(42),
                          height: heightSize(42),
                        ),
                      ),

                      const Spacer(),

                      CText(
                        text: 'Account Limit',
                        size: 18,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        height: 20 / 18,
                      ),

                      const Spacer(),
                    ],
                  ),

                  SizedBox(height: heightSize(51)),

                  Center(
                    child: CText(
                      text:
                      'SET ACCOUNT TRANSFER DAILY LIMIT',
                      size: 12,
                      fontWeight: CFONT.wMedium,
                      fontFamily: CFONT.FAMILY,
                      color: sGrey1,
                    ),
                  ),

                  SizedBox(height: heightSize(16)),

                  /// FORM CARD
                  Container(
                    padding: EdgeInsets.only(
                      left: widthSize(16),
                      right: widthSize(16),
                      top: heightSize(22),
                      bottom: heightSize(22),
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: sDarkFill,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        /// ACCOUNT DROPDOWN
                        _DropdownBox(
                          header: 'Account',
                          value: _account,
                          isOpen:
                          _openDropdown == 'account',
                          onTap: () =>
                              _toggle('account'),
                          dropdown:
                          _openDropdown == 'account'
                              ? _FormatDropdown(
                            isDark: isDark,
                            colorScheme: colorScheme,
                            formats: _accounts,
                            selected: _account,
                            onSelect: (f) {
                              setState(() {
                                _account = f;
                                _openDropdown =
                                null;
                              });
                            },
                          )
                              : null,
                        ),

                        SizedBox(height: heightSize(15)),

                        /// AMOUNT FIELD
                        AppTextField(
                          title: CText(
                            text: 'Amount',
                            size: 16,
                            fontFamily: CFONT.FAMILY,
                            fontWeight:
                            CFONT.wRegular,
                          ),

                          controller: amountController,

                          inputType:
                          TextInputType.number,

                          showNairaPrefix: true,

                          hint: '0.00',

                          /// REDUCED LEFT PADDING

                          suffixWidth: 112,

                          suffixWidget: Container(
                            height: heightSize(25.86),
                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              widthSize(10),
                              vertical:
                              heightSize(5),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  124.89),
                              color: sContainerColor,
                            ),
                            child: CText(
                              text: 'Min: N20,000',
                              size: 14,
                              fontWeight:
                              CFONT.wRegular,
                              fontFamily:
                              CFONT.FAMILY,
                            ),
                          ),

                          error: '',
                          validFunction: (v) {
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(16)),

                  /// TERMS CARD
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(16),
                      vertical: heightSize(16),
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: sSentroLightGreen
                          .withOpacity(0.25),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              CText(
                                text:
                                'Terms and conditions',
                                size: 14,
                                fontFamily:
                                CFONT.FAMILY,
                                fontWeight:
                                CFONT.wMedium,
                                height: 18.63 / 14,
                              ),

                              SizedBox(
                                height: heightSize(6),
                              ),

                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily:
                                    CFONT.FAMILY,
                                    fontWeight:
                                    CFONT.wRegular,
                                    color:
                                    Colors.white,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                      'By confirming, I have read and agree to the ',
                                    ),
                                    TextSpan(
                                      text:
                                      'consent / indemnity for limit increase',
                                      style:
                                      TextStyle(
                                        color:
                                        sNavContainer,
                                        fontFamily:
                                        CFONT
                                            .FAMILY,
                                        fontWeight:
                                        CFONT
                                            .wRegular,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: widthSize(12)),

                        /// TOGGLE
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _termsAccepted =
                              !_termsAccepted;
                            });
                          },
                          child: AnimatedContainer(
                            duration:
                            const Duration(
                              milliseconds: 180,
                            ),
                            curve:
                            Curves.easeInOut,
                            width: widthSize(54),
                            height:
                            heightSize(28),
                            padding:
                            EdgeInsets.symmetric(
                              horizontal:
                              widthSize(4),
                              vertical:
                              heightSize(3),
                            ),
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  32),
                              color:
                              _termsAccepted
                                  ? sNavContainer
                                  : sDarkBorder,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              _termsAccepted
                                  ? MainAxisAlignment
                                  .end
                                  : MainAxisAlignment
                                  .start,
                              children: [
                                AnimatedContainer(
                                  duration:
                                  const Duration(
                                    milliseconds:
                                    180,
                                  ),
                                  curve: Curves
                                      .easeInOut,
                                  width:
                                  widthSize(22),
                                  height:
                                  heightSize(
                                      22),
                                  decoration:
                                  const BoxDecoration(
                                    shape:
                                    BoxShape
                                        .circle,
                                    color: Colors
                                        .white,
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

          /// BOTTOM BUTTON
          Padding(
            padding: EdgeInsets.fromLTRB(
              widthSize(25),
              0,
              widthSize(25),
              heightSize(42),
            ),
            child: GestureDetector(
              onTap: _termsAccepted
                  ? () {
                Get.toNamed(
                  Routes.confirmPin,
                );
              }
                  : null,
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                width: double.maxFinite,
                height: heightSize(55),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      11.17),
                  border: Border.all(
                    color: sDarkBorder,
                  ),
                  color: _termsAccepted
                      ? sNavContainer
                      : Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Set Limit',
                    size: 16,
                    fontWeight:
                    CFONT.wMedium,
                    fontFamily:
                    CFONT.FAMILY,
                    color: _termsAccepted
                        ? sActionButton
                        : Colors.white,
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

class _DropdownBox extends StatelessWidget {
  final String header;
  final String value;
  final bool isOpen;
  final VoidCallback onTap;
  final Widget? dropdown;

  const _DropdownBox({
    required this.header,
    required this.value,
    required this.isOpen,
    required this.onTap,
    this.dropdown,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        CText(
          text: header,
          size: 16,
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wRegular,
        ),

        SizedBox(height: heightSize(5)),

        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration:
            const Duration(milliseconds: 200),
            height: heightSize(51),
            padding: EdgeInsets.symmetric(
              horizontal: widthSize(14),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft:
                const Radius.circular(10),
                topRight:
                const Radius.circular(10),
                bottomLeft: Radius.circular(
                    isOpen ? 0 : 10),
                bottomRight: Radius.circular(
                    isOpen ? 0 : 10),
              ),
              color: sDarkFill,
              border: Border.all(
                color: sDarkBorder,
              ),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Expanded(
                  child: CText(
                    text: value,
                    // fontFamily:
                    // CFONT.FAMILY,
                    fontWeight:
                    CFONT.wRegular,
                    size: 13,
                  ),
                ),

                AnimatedRotation(
                  turns: isOpen ? 0.5 : 0,
                  duration:
                  const Duration(
                    milliseconds: 200,
                  ),
                  child: SvgPicture.asset(
                    arrowDown,
                    width: widthSize(20),
                    height: heightSize(20),
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

class _FormatDropdown extends StatelessWidget {
  final List<String> formats;
  final String selected;
  final ValueChanged<String> onSelect;
  final bool isDark;
  final ColorScheme colorScheme;

  const _FormatDropdown({
    required this.formats,
    required this.selected,
    required this.onSelect,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context,) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: sDarkBorder,
        border: Border.all(
          color: sDarkBorder,
        ),
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
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Expanded(
                      child: CText(
                        text: f,
                        size: 13,
                        fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                        color: isSelected ? sNavContainer : null,
                      ),
                    ),

                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width: widthSize(16),
                        height: heightSize(16),
                        colorFilter:
                        ColorFilter.mode(
                          sNavContainer,
                          BlendMode.srcIn,
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