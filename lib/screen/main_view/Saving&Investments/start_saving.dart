import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/models/savings_field.dart';
import 'package:sentro/core/models/savings_type.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class StartSaving extends StatefulWidget {
  const StartSaving({super.key});

  @override
  State<StartSaving> createState() => _StartSavingState();
}

class _StartSavingState extends State<StartSaving> {
  @override
  void initState() {
    super.initState();
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  // ── Shared card sections ───────────────────────────────────────────────

  Widget _cardHeader({
    required String type,
    required String interest,
    required Color interestColor,
    required Color accent,
    bool useAccent = false,
    bool showInterest = true,
  }) {
    return Row(
      children: [
        SvgPicture.asset(barChat,
            width: widthSize(38), height: heightSize(38), colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,),
        SizedBox(width: widthSize(10)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              text: type,
              size: 16,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
            ),
          ],
        ),

        const Expanded(child: SizedBox.shrink()),

        if (showInterest)
          CText(
            text: '$interest% p.a',
            size: 14,
            fontWeight: CFONT.wBold,
            fontFamily: CFONT.FAMILY,
            color: interestColor,
          ),
      ],
    );
  }

  Widget _cardFooter(SavingsOption option, bool useAccent, Color? accent) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(
            Routes.savingsType,
            arguments: {
              "selected": option,
              "all": savingsOptions,
            },
          ),
      child: Container(
        width: double.maxFinite,
        height: heightSize(38),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: useAccent?accent:sSentroLightGreen,
        ),
        child: Center(
          child: CText(
            text: option.buttonLabel,
            size: 14,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wMedium,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  final List<SavingsOption> savingsOptions = [
    SavingsOption(
      title: 'Target Savings',
      description: 'Save towards a specific goal, until you reach target',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N10,000',
        ),
        SavingsInfoItem(
          label: 'Early Withdrawal',
          value: '5% penalty',
        ),
        SavingsInfoItem(
          label: 'Reinvest Option',
          value: 'Yes',
          showIcon: true,
        ),
      ],
      interest: '10',
      interestColor: sNavContainer,
      buttonLabel: 'Start Saving',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(label: 'Target Goal Amount (N)',
            type: SavingsFieldType.amount,
            hint: '0.00'),
        SavingsField(label: 'Target Date',
          type: SavingsFieldType.date,
          hint: 'dd/mm/yyyy',),
        SavingsField(label: 'Interest Payout Frequency',
            type: SavingsFieldType.dropdown,
            hint: 'Monthly / 0.833%',
            dropdownItems: [
              'Monthly / 0.833%',
              'Quarterly / 2.5%',
              'Annually / 10%',
            ]),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: true,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(label: 'Enable Auto-Save contribution',
            type: SavingsFieldType.info,
            description: 'Automatically fund this goal on a schedule from your Business Capital.'),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: '12 Months',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),

    SavingsOption(
      title: 'FGN Treasury Bills',
      description: 'CBN-issued government securities.',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N1,000,000',
        ),
        SavingsInfoItem(
          label: 'Tenor',
          value: '91 / 182 / 364 days',
        ),
        SavingsInfoItem(
          label: 'Reinvest Option',
          value: 'Yes',
          showIcon: true,
        ),
      ],
      interest: '18.5',
      interestColor: sPurple,
      buttonLabel: 'Invest in T-Bills',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(label: 'Investment Amount (N)',
            type: SavingsFieldType.amount,
            hint: '0.00'),
        SavingsField(label: 'Interest Payout Frequency',
            type: SavingsFieldType.dropdown,
            hint: 'Monthly / 0.833%',
            dropdownItems: [
              'Monthly / 0.833%',
              'Quarterly / 2.5%',
              'Annually / 10%',
            ]),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: false,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: 'N150',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),

    SavingsOption(
      title: 'Mutual Funds',
      description: 'SEC-regulated money market and bond funds.',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N50,000',
        ),
        SavingsInfoItem(
          label: 'Withdrawal',
          value: 'T+1 days',
        ),
        SavingsInfoItem(
          label: 'Reinvest Option',
          value: 'Yes',
          showIcon: true,
        ),
      ],
      interest: '13-18',
      interestColor: sLightPink,
      buttonLabel: 'Invest in Funds',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(label: 'Investment Amount',
            type: SavingsFieldType.amount,
            hint: '0.00'),
        SavingsField(label: 'Interest Payout Frequency',
            type: SavingsFieldType.dropdown,
            hint: 'Monthly / 0.833%',
            dropdownItems: [
              'Monthly / 0.833%',
              'Quarterly / 2.5%',
              'Annually / 10%',
            ]),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: false,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(label: 'Enable Auto-Save contribution',
            type: SavingsFieldType.info,
            description: 'Automatically fund this goal on a schedule from your Business Capital.'),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: 'N150',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),

    SavingsOption(
      title: 'Dollar Savings',
      description: 'Save in USD to hedge against Naira devaluation.',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N50,000',
        ),
        SavingsInfoItem(
          label: 'FX Rate',
          value: 'Live I&E rate',
        ),
        SavingsInfoItem(
          label: 'Reinvest Option',
          value: 'Yes',
          showIcon: true,
        ),
      ],
      interest: '5.5',
      interestColor: sNavContainer,
      buttonLabel: 'Open Dollar Vault',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(
            label: 'Amount (USD)', type: SavingsFieldType.amount, hint: '0.00'),
        SavingsField(label: 'Duration',
            type: SavingsFieldType.dropdown,
            hint: '3 Months',
            dropdownItems: [
              '6 Months',
              '12 Months',
              '24 Months',
            ]),
        SavingsField(label: 'Interest Payout Frequency',
            type: SavingsFieldType.dropdown,
            hint: 'Monthly / 0.833%',
            dropdownItems: [
              'Monthly / 0.833%',
              'Quarterly / 2.5%',
              'Annually / 10%',
            ]),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: false,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(label: 'Enable Auto-Save contribution',
            type: SavingsFieldType.info,
            description: 'Automatically fund this goal on a schedule from your Business Capital.'),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: 'N150',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: true,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),

    SavingsOption(
      title: 'Fixed Deposit',
      description: 'Lock money for a fixed period and earn a great rate',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N500,000',
        ),
        SavingsInfoItem(
          label: 'Tenor',
          value: '30-365 days',
        ),
        SavingsInfoItem(
          label: 'Reinvest Option',
          value: 'Yes',
          showIcon: true,
        ),
      ],
      interest: '15-17',
      interestColor: sLightBlue,
      buttonLabel: 'Open Dollar Vault',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(label: 'Tenor',
            type: SavingsFieldType.dropdown,
            hint: '180 days - 16.5% p.a',
            dropdownItems: [
              '30 days',
              '60 days',
              '90 days',
              '180 days',
              '365 days'
            ]),
        SavingsField(label: 'Target Goal Amount(N)',
            type: SavingsFieldType.amount,
            hint: '0.00'),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: true,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(label: 'Enable Auto-Save contribution',
            type: SavingsFieldType.info,
            description: 'Automatically fund this goal on a schedule from your Business Capital.'),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: '12 Months',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),

    SavingsOption(
      title: 'Flexible Savings',
      description: 'Save towards a specific goal, until you reach target',
      bottomItems: [
        SavingsInfoItem(
          label: 'Min. Amount',
          value: 'N1,000',
        ),
        SavingsInfoItem(
          label: 'Withdrawal',
          value: 'Instant',
        ),
        SavingsInfoItem(
          label: 'Penalty',
          value: 'None',
        ),
      ],
      interest: '10',
      interestColor: sAmber,
      buttonLabel: 'Open Flexible Vault',
      fields: [
        SavingsField(label: 'Goal Name',
            type: SavingsFieldType.text,
            hint: 'e.g. New Car Money'),
        SavingsField(label: 'Target Goal Amount (N)',
            type: SavingsFieldType.amount,
            hint: '0.00'),
        SavingsField(label: 'Target Date',
          type: SavingsFieldType.date,
          hint: 'dd/mm/yyyy',),
        SavingsField(label: 'Interest Payout Frequency',
            type: SavingsFieldType.dropdown,
            hint: 'Monthly / 0.833%',
            dropdownItems: [
              'Monthly / 0.833%',
              'Quarterly / 2.5%',
              'Annually / 10%',
            ]),
        SavingsField(
          label: 'Rollover',
          type: SavingsFieldType.info,
          toggleState: true,
          description:
          'Earnings will be paid into your main balance but capital will automatically roll into the next savings cycle.',
        ),
        SavingsField(label: 'Enable Auto-Save contribution',
            type: SavingsFieldType.info,
            description: 'Automatically fund this goal on a schedule from your Business Capital.'),
        SavingsField(
          type: SavingsFieldType.card,
          label: 'Interest Preview',
          cardItems: [
            SavingsCardItem(
              label: 'Principal',
              value: '₦10,000',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Annual Rate',
              value: '5.5% p.a',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Per Payout(monthly)',
              value: '12 Months',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total Interest (1 year)',
              value: '₦10',
              isColored: false,
            ),
            SavingsCardItem(
              label: 'Total at Maturity',
              value: '₦1,000',
              isColored: true,
            ),
          ],
        ),
      ],
    ),
  ];


  Widget _cardShell({required SavingsOption option, required bool isDark, required bool useAccent, required Color accent }) {
    final hasInterest =
        option.interest != null && option.interest!.trim().isNotEmpty;

    final items = option.bottomItems ?? [];

    return Container(
      padding: EdgeInsets.only(
        left: widthSize(15),
        top: heightSize(18),
        right: widthSize(15),
        bottom: heightSize(17),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.72),
        color: isDark ? sSavingsColor : sLightFill,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            type: option.title,
            interest: option.interest ?? "",
            interestColor: option.interestColor ?? sNavContainer,
            showInterest: hasInterest,
            useAccent: useAccent,
            accent: accent,

          ),
          SizedBox(height: heightSize(18)),
          CText(
            text: option.description,
            size: 12,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wRegular,
            color: isDark ? sGrey1 : sGrey2,
          ),
          SizedBox(height: heightSize(18)),
          // ✅ SAFE RENDER
          if (items.isNotEmpty)
            Container(
              width: widthSize(double.maxFinite),
              padding: EdgeInsets.only(bottom: heightSize(10),
                top: heightSize(9),
                left: widthSize(12),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                border: Border.all(color: isDark ? sDarkBorder : sGrey1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: widthSize(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: item.label,
                            size: 10,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: sGrey2,
                          ),
                          SizedBox(height: heightSize(0.5)),
                          Row(
                            children: [
                              Flexible(
                                child: CText(
                                  text: item.value,
                                  size: 12,
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wMedium,
                                ),
                              ),
                              if (item.showIcon)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: widthSize(2.5)),
                                  child: SvgPicture.asset(
                                    tick,
                                    width: widthSize(12),
                                    height: heightSize(12),
                                    colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: heightSize(22)),
          _cardFooter(option, useAccent??false, accent),
        ],
      ),
    );
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
          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
          child: Column(
            children: [
              SizedBox(height: heightSize(64)),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42), height: heightSize(42),
                      colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):null,
                    ),
                  ),
                  Expanded(child: SizedBox.shrink(),),
                  CText(
                    text: 'Start Saving',
                    size: 18,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    height: 20 / 18,
                  ),
                  Expanded(child: SizedBox.shrink(),),
                ],
              ),

              SizedBox(height: heightSize(37)),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widthSize(11), vertical: heightSize(11)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.63),
                    color: isDark ? sDarkFill : Colors.black.withOpacity(0.1)),
                child: Column(
                  children: [
                    // ── 1. Target Savings ──────────────────────────
                    _cardShell(option: savingsOptions[0], isDark: isDark, useAccent: useAccent, accent: accent),
                    SizedBox(height: heightSize(13)),
                    // ── 2. FGN Treasury Bills ──────────────────────
                    _cardShell(option: savingsOptions[1], isDark: isDark, useAccent: useAccent, accent: accent),
                    SizedBox(height: heightSize(13)),
                    // ── 3. Mutual Funds ──────────────────────────
                    _cardShell(option: savingsOptions[2], isDark: isDark, useAccent: useAccent, accent: accent),
                    SizedBox(height: heightSize(13)),
                    // ── 4. Dollar Savings ───────────────────────────
                    _cardShell(option: savingsOptions[3], isDark: isDark, useAccent: useAccent, accent: accent),
                    SizedBox(height: heightSize(13)),
                    // ── 5. Fixed Deposit ────────────────
                    _cardShell(option: savingsOptions[4], isDark: isDark, useAccent: useAccent, accent: accent),
                    SizedBox(height: heightSize(13)),
                    // ── 6. Flexible Savings ─────────────────────────────
                    _cardShell(option: savingsOptions[5], isDark: isDark, useAccent: useAccent, accent: accent),
                  ],
                ),
              ),
              SizedBox(height: heightSize(67)),
            ],
          ),
        );
      }),
    );
  }
}