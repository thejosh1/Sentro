import 'dart:ui';

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
import 'package:sentro/screen/main_view/global_pay/send_money.dart';

import '../../../core/constants/enums.dart';

class GlobalPay extends StatefulWidget {
  const GlobalPay({super.key});

  @override
  State<GlobalPay> createState() => _GlobalPayState();
}

class _GlobalPayState extends State<GlobalPay> {
  bool _hasAccount = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['payAccountCreated'] == true) {
      _hasAccount = true;
      args['payAccountCreated'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasAccount) {
      return const _GlobalPayDashBoard(); // your existing GlobalPay with cards/transactions
    }
    return const _GlobalPayLanding(); // the globe screen
  }
}


class _GlobalPayLanding extends StatelessWidget {
  const _GlobalPayLanding({super.key});

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: widthSize(20),),
          child: Column(
            children: [
              SizedBox(height: heightSize(64),),
              Row(
                children: [
                  SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                    colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                  ),
                  SizedBox(width: widthSize(89),),
                  SvgPicture.asset(logoGlobalPay, width: widthSize(127.11), height: heightSize(37.98),),
                ],
              ),
              SizedBox(height: heightSize(53.18),),
              Image.asset(
                globe,
                width: widthSize(375.05),
                height: heightSize(360),
              ),
              SizedBox(height: heightSize(51.5),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize(22)),
                child: Column(
                  children: [
                    CText(
                      text: 'Built with control, security. For your convenience',
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      size: 24,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: heightSize(15),),
                    CText(
                      text: 'Make payments using Sentro virtual card for every global online transactions.',
                      size: 14,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              SizedBox(height: heightSize(47.5),),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.verification, arguments: {'fromPayAccountCreation': true});
                },
                child: SvgPicture.asset(
                  arrowLeft,
                  width: widthSize(70),
                  height: heightSize(70),
                  colorFilter: useAccent
                      ? ColorFilter.mode(accent, BlendMode.srcIn)
                      : null,
                ),
              ),
              SizedBox(height: heightSize(106.5),),
            ],
          ),
        );
      }),
    );
  }
}

class _GlobalPayDashBoard extends StatefulWidget {
  const _GlobalPayDashBoard({super.key});

  @override
  State<_GlobalPayDashBoard> createState() => _GlobalPayDashBoardState();
}

class _GlobalPayDashBoardState extends State<_GlobalPayDashBoard> {
  int _selectedCardIndex = 0;
  // Mock Data for the Account/Card Picker
  final List<Map<String, dynamic>> _accounts = [
    {
      'id': 'USD',
      'title': 'United States of America',
      'balance': '\$275.05',
      'flag': america,
      'bgColor': sActionButton,
    },
    {
      'id': 'GBP',
      'title': 'Great British Pounds',
      'balance': '\$275.05',
      'flag': britain,
      'bgColor': sLightGreen
    },
    {
      'id': 'EUR',
      'title': 'European Union',
      'balance': '€275.05',
      'flag': euro,
      'bgColor': sPayGreen,
    },
    {
      'id': 'GHS',
      'title': 'Ghanaian Cedi',
      'balance': '₵275.05',
      'flag': ghana, // Ensure this constant matches your asset path setup
      'bgColor': sRed, // Premium structural red
    },
    {
      'id': 'RWF',
      'title': 'Rwandan Franc',
      'balance': 'FRw275.05',
      'flag': rwanda, // Ensure this constant matches your asset path setup
      'bgColor': sBlue, // Beautiful structural vivid blue
    },
  ];

  // Mock Data for the Transaction list
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Transfer to bank',
      'time': '12:45.10 · 14 May, 2026',
      'amount': '₦500.50',
      'isIncome': false,
      'icon': send,
      'status': true,
    },
    {
      'title': 'Received - John Lee',
      'time': '12:45.10 · 14 May, 2026',
      'amount': '₦500.50',
      'isIncome': true,
      'icon': receive,
      'status': true,
    },
    {
      'title': 'Fund Account',
      'time': '12:45.10 · 14 May, 2026',
      'amount': '₦500.50',
      'isIncome': true,
      'icon': topUp,
      'status': true,
    },
    {
      'title': 'Swap - USDxNGN',
      'time': '12:45.10 · 14 May, 2026',
      'amount': '₦500.50',
      'isIncome': false,
      'icon': swap,
      'status': true,
    },
    {
      'title': 'Withdraw',
      'time': '12:45.10 · 14 May, 2026',
      'amount': '₦500.50',
      'isIncome': false,
      'icon': withdraw,
      'status': true,
    },
  ];

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  void _showCardDetailsDialog(BuildContext context, Map<String, dynamic> account, bool useAccent, Color accent) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss Details Modal',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              padding: EdgeInsets.all(widthSize(24)),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // Premium deep charcoal gray card container matching mockup
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.06)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center Modal Title Header
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: heightSize(20)),
                        child: CText(
                          text: '${account['id']} Details',
                          size: 16,
                          fontWeight: CFONT.wBold,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Conditionally load details based on the selected wallet node
                    ..._buildDialogFields(account['id'], useAccent, accent,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      // Wraps dynamic display filter stack across current route tree
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12.0 * animation.value,
            sigmaY: 12.0 * animation.value,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    bool hasInfoIcon = false,
    bool hasCopyIcon = false,
    bool isLastItem = false,
    bool useAccent = false,
    required Color accent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CText(
              text: label,
              size: 12,
              color: sGrey2,
              fontWeight: CFONT.wRegular,
            ),
            if (hasInfoIcon) ...[
              SizedBox(width: widthSize(4)),
              SvgPicture.asset(
                infoCirclePay,
                width: widthSize(18),
                height: heightSize(18),
                colorFilter: useAccent?
                ColorFilter.mode(accent, BlendMode.srcIn):null,
              )
            ]
          ],
        ),
        SizedBox(height: heightSize(4)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CText(
                text: value,
                size: 15,
                color: Colors.white,
                fontWeight: CFONT.wMedium,
              ),
            ),
            if (hasCopyIcon)
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  Get.snackbar(
                    'Copied',
                    '$label copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF242424),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 1),
                  );
                },
                child: SvgPicture.asset(
                  copy,
                  width: widthSize(24),
                  height: heightSize(24),
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
          ],
        ),
        if (!isLastItem) ...[
          SizedBox(height: heightSize(12)),
          Divider(color: Colors.white.withOpacity(0.06), height: 1, thickness: 1),
          SizedBox(height: heightSize(12)),
        ],
      ],
    );
  }

  List<Widget> _buildDialogFields(String id, bool useAccent, Color accent) {
    switch (id) {
      case 'USD':
        return [
          _buildDetailRow(label: 'Bank Name', value: 'American Bank', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Name', value: 'James Smith', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Number', value: '1234567890', hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Routing Number', value: '123456789', hasInfoIcon: true, hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Type', value: 'Checking', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Bank Address', value: '60 Park Avenue, New York, NY', hasInfoIcon: true, isLastItem: true, useAccent: useAccent, accent: accent,),
        ];
      case 'GBP':
        return [
          _buildDetailRow(label: 'Bank Name', value: 'Rich Bank', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Name', value: 'James Smith', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Number', value: '1234567890', hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Sort Code', value: '123456789', hasInfoIcon: true, hasCopyIcon: true, isLastItem: true, useAccent: useAccent, accent: accent,),
        ];
      case 'EUR':
        return [
          _buildDetailRow(label: 'Bank Name', value: 'Rich Bank', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Name', value: 'James Smith', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'IBAN', value: 'UUYE7293HEHN2319HJ', hasInfoIcon: true, hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Bank Code', value: '3RUN', hasInfoIcon: true, hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'BIC Code', value: 'BIO02RUN', hasInfoIcon: true, hasCopyIcon: true, isLastItem: true, useAccent: useAccent, accent: accent,),
        ];
      case 'GHS':
        return [
          _buildDetailRow(label: 'Bank Name', value: 'Sentro Ghana Bank', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Name', value: 'James Smith', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Number', value: '9876543210', hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Branch Code', value: '233001', hasInfoIcon: true, hasCopyIcon: true, isLastItem: true, useAccent: useAccent, accent: accent,),
        ];
      case 'RWF':
        return [
          _buildDetailRow(label: 'Bank Name', value: 'Sentro Rwanda Bank', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Name', value: 'James Smith', useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Account Number', value: '5432167890', hasCopyIcon: true, useAccent: useAccent, accent: accent,),
          _buildDetailRow(label: 'Swift Code', value: 'RWF01RUN', hasInfoIcon: true, hasCopyIcon: true, isLastItem: true, useAccent: useAccent, accent: accent,),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);

        final limeGreen = sNavContainer;
        final elementAccentColor = useAccent ? accent : limeGreen;

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: heightSize(64)),

              // ── Top Header Bar ─────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    // GestureDetector(
                    //   onTap: () => Get.back(),
                    //   child: SvgPicture.asset(
                    //     isDark ? arrowBackWhite : arrowBack,
                    //     width: widthSize(42),
                    //     height: heightSize(42),
                    //     colorFilter: useAccent ? ColorFilter.mode(accent, BlendMode.srcIn) : null,
                    //   ),
                    // ),
                    SvgPicture.asset(
                      logoGlobalPay,
                      width: widthSize(127.11),
                      height: heightSize(37.98),
                    ),
                    // "New Card +" Accent Pill Button
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.createPayAccount),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: widthSize(12), vertical: heightSize(8)),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CText(
                              text: 'New Card',
                              size: 13,
                              fontWeight: CFONT.wRegular,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: widthSize(4)),
                            Icon(
                              Icons.add,
                              size: widthSize(14),
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: heightSize(24)),

              // ── Card Slider (Horizontal List View) ─────────────────────────
              SizedBox(
                height: heightSize(210),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                  itemCount: _accounts.length,
                  separatorBuilder: (_, __) => SizedBox(width: widthSize(14)),
                  itemBuilder: (context, index) {
                    final item = _accounts[index];
                    final isSelected = _selectedCardIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCardIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: widthSize(170),
                        padding: EdgeInsets.symmetric(
                            horizontal: widthSize(8), vertical: heightSize(10)),
                        decoration: BoxDecoration(
                          color: item['bgColor'],
                          borderRadius: BorderRadius.circular(13.1),
                          border: Border.all(
                            color: isSelected ? elementAccentColor : Colors.transparent,
                            width: 2.5,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: elementAccentColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ] : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: item['title'],
                              size: 12,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            Center(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CText(
                                      text: 'Balance',
                                      size: 12,
                                      fontWeight: CFONT.wRegular,
                                      fontFamily: CFONT.FAMILY,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: heightSize(2)),
                                    CText(
                                      text: item['balance'],
                                      size: 24.82,
                                      fontWeight: CFONT.wBold,
                                      fontFamily: index==3?null:CFONT.FAMILY,
                                      color: Colors.white,
                                    ),]
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  item['flag'],
                                  width: widthSize(28),
                                  height: heightSize(28),
                                  fit: BoxFit.contain,
                                ),
                                GestureDetector(
                                  onTap: () => _showCardDetailsDialog(context, item, useAccent, elementAccentColor),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: widthSize(10), vertical: heightSize(5.83)),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(83.34),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.more_horiz, size: widthSize(22), color: Colors.white),
                                        SizedBox(width: widthSize(5)),
                                        CText(text: 'Details', size: 14, color: Colors.white, fontWeight: CFONT.wRegular, fontFamily: CFONT.FAMILY, height: 16.67/14,),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: heightSize(16)),

              // ── Quick Actions Grid Row Sheet ───────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: heightSize(17.4), horizontal: widthSize(14.3)),
                  decoration: BoxDecoration(
                    color: isDark ? sDarkBorder : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(topUp, 'Fund', () => Get.toNamed(Routes.transactionAction, arguments: TransactionActionType.topUp)),
                      _buildActionButton(send, 'Send', () {
                        final selectedCurrency = _accounts[_selectedCardIndex]['id'];

                        // Direct routing push containing active state arguments payload
                        Get.toNamed(Routes.sendMoney, arguments: selectedCurrency);
                      }),
                      _buildActionButton(receive, 'Receive', () {}),
                      _buildActionButton(swap, 'Swap', () {
                        Get.toNamed(Routes.swapCurrency);
                      }),
                      _buildActionButton(withdraw, 'Withdraw', () => Get.toNamed(Routes.transactionAction, arguments: TransactionActionType.withdraw)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: heightSize(32)),

              // ── Latest Transactions Section ────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(23),
                    vertical: heightSize(17),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isDark?sDarkFill:sLightFill,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: 'Latest Transaction',
                            size: 16,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.transactionHistory);
                            },
                            child: CText(
                              text: 'See all',
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: elementAccentColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: heightSize(16)),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: heightSize(21)),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _transactions.length,
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: heightSize(10)),
                          child: Divider(
                            color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          final tx = _transactions[index];
                          return Row(
                            children: [
                              // Circular Leading Icon
                              SvgPicture.asset(tx['icon'], width: widthSize(38), height: heightSize(38),),
                              SizedBox(width: widthSize(12)),

                              // Title & Timestamp Labels
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CText(
                                      text: tx['title'],
                                      size: 14,
                                      fontWeight: CFONT.wMedium,
                                      fontFamily: CFONT.FAMILY,
                                    ),
                                    SizedBox(height: heightSize(3)),
                                    CText(
                                      text: tx['time'],
                                      size: 10,
                                      fontWeight: CFONT.wRegular,
                                      fontFamily: CFONT.FAMILY,
                                      color:  sGrey2,
                                    ),
                                  ],
                                ),
                              ),

                              // Amount Status
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CText(
                                    text: tx['amount'],
                                    size: 14,
                                    fontWeight: CFONT.wMedium,
                                    //fontFamily: CFONT.FAMILY,
                                    color: isDark?sGrey1:sGrey2,
                                  ),
                                  SizedBox(height: heightSize(3)),
                                  CText(
                                    text: tx['status']==true?'Successful':'Failed',
                                    size: 10,
                                    fontWeight: CFONT.wRegular,
                                    fontFamily: CFONT.FAMILY,
                                    color: tx['status']==true?useAccent?elementAccentColor:isDark?sNavContainer:sActionButton:sRed, // Green Status Text
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightSize(140)),
            ],
          ),
        );
      }),
    );
  }

  // Quick Action Button Constructor Item
  Widget _buildActionButton(String iconImage, String label, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconImage, width: widthSize(49.45), height: heightSize(49.45),),
          SizedBox(height: heightSize(8)),
          CText(
            text: label,
            size: 12,
            fontWeight: CFONT.wRegular,
            color: isDark ? sGrey1 : sGrey2,
          ),
        ],
      ),
    );
  }
}


