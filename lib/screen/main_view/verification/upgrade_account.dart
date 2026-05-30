import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

// ── Tier data model ──────────────────────────────────────────────────────────

class _TierData {
  final String label;
  final String verificationTitle;
  final String medal;
  final bool isVerified;
  final String sentroToSentroSingle;
  final String sentroToSentroDaily;
  final String sentroToOtherSingle;
  final String sentroToOtherDaily;

  const _TierData({
    required this.label,
    required this.verificationTitle,
    required this.medal,
    required this.isVerified,
    required this.sentroToSentroSingle,
    required this.sentroToSentroDaily,
    required this.sentroToOtherSingle,
    required this.sentroToOtherDaily,
  });
}

// ── Page ─────────────────────────────────────────────────────────────────────

class UpgradeAccount extends StatefulWidget {
  const UpgradeAccount({super.key});

  @override
  State<UpgradeAccount> createState() => _UpgradeAccountState();
}

class _UpgradeAccountState extends State<UpgradeAccount> {
  late int _selectedTier;

  @override
  void initState() {
    super.initState();

    final arg = Get.arguments;

    if (arg is int) {
      _selectedTier = arg;
    } else {
      _selectedTier = 0;
    }
  }

  // ── Edit isVerified per tier to reflect real state ───────────────────────
  final List<_TierData> _tiers = [
    _TierData(
      label: 'Tier 1',
      verificationTitle: 'BVN Verification',
      medal: goldMedal,
      isVerified: true,
      sentroToSentroSingle: 'N20,000.00',
      sentroToSentroDaily: 'N50,000.00',
      sentroToOtherSingle: 'N20,000.00',
      sentroToOtherDaily: 'N50,000.00',
    ),
    _TierData(
      label: 'Tier 2',
      verificationTitle: 'NIN Verification',
      medal: ninMedal,
      isVerified: false,
      sentroToSentroSingle: 'N50,000.00',
      sentroToSentroDaily: 'N200,000.00',
      sentroToOtherSingle: 'N20,000.00',
      sentroToOtherDaily: 'N50,000.00',
    ),
    _TierData(
      label: 'Tier 3',
      verificationTitle: 'Address Verification',
      medal: addressMedal,
      isVerified: false,
      sentroToSentroSingle: 'N1,000,000.00',
      sentroToSentroDaily: 'N5,000,000.00',
      sentroToOtherSingle: 'N1,000,000.00',
      sentroToOtherDaily: 'N5,000,000.00',
    ),
    _TierData(
      label: 'Tier 4',
      verificationTitle: 'Next Of Kin Verification',
      medal: kinMedal,
      isVerified: false,
      sentroToSentroSingle: 'N5,000,000.00',
      sentroToSentroDaily: 'N20,000,000.00',
      sentroToOtherSingle: 'N5,000,000.00',
      sentroToOtherDaily: 'N20,000,000.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tier = _tiers[_selectedTier];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ────────────────────────────────────────────
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
                const Spacer(flex: 2),
                CText(
                  text: 'Account Upgrade',
                  size: 19.85,
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                ),
                const Spacer(flex: 2),
              ],
            ),

            SizedBox(height: heightSize(30)),

            // ── Animated tier tab bar ─────────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final hPad = widthSize(10);
                final vPad = heightSize(7);
                final containerHeight = heightSize(62);
                final tabHeight = containerHeight - (vPad * 2);
                final tabWidth =
                    (constraints.maxWidth - (hPad * 2)) / _tiers.length;

                return Container(
                  width: double.maxFinite,
                  height: containerHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44.7),
                    color: sDarkBorder,
                  ),
                  child: Stack(
                    children: [
                      // sliding pill
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        left: hPad + (_selectedTier * tabWidth),
                        top: vPad,
                        width: tabWidth,
                        height: tabHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(44.7),
                            color: sActiveColor,
                          ),
                        ),
                      ),

                      // tab labels
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: hPad,
                          vertical: vPad,
                        ),
                        child: Row(
                          children: List.generate(_tiers.length, (index) {
                            final isActive = _selectedTier == index;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTier = index),
                              behavior: HitTestBehavior.opaque,
                              child: SizedBox(
                                width: tabWidth,
                                height: tabHeight,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: widthSize(4)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          goldMedal,
                                          width: widthSize(14),   // ← smaller fixed icon
                                          height: heightSize(14),
                                        ),
                                        SizedBox(width: widthSize(4)),
                                        AnimatedDefaultTextStyle(
                                          duration: const Duration(milliseconds: 280),
                                          style: TextStyle(
                                            fontSize: isActive ? 13 : 12, // ← smaller base size
                                            fontFamily: CFONT.FAMILY,
                                            fontWeight: isActive ? CFONT.wMedium : CFONT.wRegular,
                                            color: isActive ? sNavContainer : Colors.white,
                                          ),
                                          child: Text(
                                            _tiers[index].label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: heightSize(26)),

            // ── Tier content (switches with tab) ──────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    CText(
                      text: '${tier.label} Account',
                      size: 20,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                    ),

                    SizedBox(height: heightSize(22)),

                    // ── Verification card ──────────────────────
                    Container(
                      width: double.maxFinite,
                      height: heightSize(90),
                      padding: EdgeInsets.symmetric(
                        horizontal: widthSize(25),
                        vertical: heightSize(18),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: sDarkBorder,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                text: tier.verificationTitle,
                                size: 20,
                                fontWeight: CFONT.wMedium,
                                fontFamily: CFONT.FAMILY,
                              ),
                              SizedBox(height: heightSize(2.5)),
                              // verified / not verified inline
                              if (tier.isVerified)
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      verify,
                                      width: widthSize(24),
                                      height: heightSize(24),
                                    ),
                                    SizedBox(width: widthSize(5)),
                                    CText(
                                      text: 'Verified',
                                      size: 16,
                                      fontFamily: CFONT.FAMILY,
                                      fontWeight: CFONT.wRegular,
                                    ),
                                  ],
                                )
                              else
                                CText(
                                  text: 'Not Verified',
                                  size: 16,
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wRegular,
                                  color: sVerification,
                                ),
                            ],
                          ),
                          SvgPicture.asset(
                            tier.medal,
                            width: tier.label=='Tier 4'||tier.label == 'Tier 3'?widthSize(67.19):widthSize(37.94),
                            height: tier.label=='Tier 4'||tier.label == 'Tier 3'?heightSize(36):heightSize(52),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: heightSize(9)),

                    // ── Sentro to Sentro ───────────────────────
                    _LimitCard(
                      title: 'Sentro to Sentro',
                      singleLimit: tier.sentroToSentroSingle,
                      dailyLimit: tier.sentroToSentroDaily,
                    ),

                    SizedBox(height: heightSize(9)),

                    // ── Sentro to Other Bank ───────────────────
                    _LimitCard(
                      title: 'Sentro to Other bank',
                      singleLimit: tier.sentroToOtherSingle,
                      dailyLimit: tier.sentroToOtherDaily,
                    ),

                    SizedBox(height: heightSize(26)),
                  ],
                ),
              ),
            ),

            // ── Bottom verification button ─────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: tier.isVerified
                  ? _VerifiedButton(key: const ValueKey('verified'))
                  : _StartVerificationButton(key: const ValueKey('start')),
            ),

            SizedBox(height: heightSize(42)),
          ],
        ),
      ),
    );
  }
}

// ── Limit card ───────────────────────────────────────────────────────────────

class _LimitCard extends StatelessWidget {
  final String title;
  final String singleLimit;
  final String dailyLimit;

  const _LimitCard({
    required this.title,
    required this.singleLimit,
    required this.dailyLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: heightSize(145),
      padding: EdgeInsets.only(
        left: widthSize(20),
        top: heightSize(22),
        right: widthSize(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: sDarkBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText(
            text: title,
            size: 18,
            fontWeight: CFONT.wMedium,
            fontFamily: CFONT.FAMILY,
            color: sNavContainer,
          ),
          SizedBox(height: heightSize(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                text: 'Single Transfer',
                size: 14,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                color: sConfirmTextColor,
              ),
              CText(
                text: singleLimit,
                size: 16,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
              ),
            ],
          ),
          SizedBox(height: heightSize(10)),
          Divider(color: sDarkFill),
          SizedBox(height: heightSize(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                text: 'Daily Limit',
                size: 14,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                color: sConfirmTextColor,
              ),
              CText(
                text: dailyLimit,
                size: 16,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Verified bottom button ────────────────────────────────────────────────────

class _VerifiedButton extends StatelessWidget {
  const _VerifiedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: heightSize(55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.17),
        border: Border.all(color: sNavContainer),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            verify,
            width: widthSize(24),
            height: heightSize(24),
            colorFilter: ColorFilter.mode(sNavContainer, BlendMode.srcIn),
          ),
          SizedBox(width: widthSize(5)),
          CText(
            text: 'Verified',
            size: 16,
            fontWeight: CFONT.wMedium,
            fontFamily: CFONT.FAMILY,
            color: sNavContainer,
          ),
        ],
      ),
    );
  }
}

// ── Start Verification bottom button ─────────────────────────────────────────

class _StartVerificationButton extends StatelessWidget {
  const _StartVerificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: heightSize(55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.17),
        color: sNavContainer,
      ),
      child: Center(
        child: CText(
          text: 'Start Verification',
          size: 16,
          fontWeight: CFONT.wMedium,
          fontFamily: CFONT.FAMILY,
          color: sActionButton,
        ),
      ),
    );
  }
}