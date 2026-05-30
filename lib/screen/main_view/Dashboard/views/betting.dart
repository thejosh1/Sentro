import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/models/disco.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class Betting extends StatefulWidget {
  const Betting({super.key});

  @override
  State<Betting> createState() => _BettingState();
}

class _BettingState extends State<Betting> {
  bool isPostpaidSelected = false;
  bool isPlanSheetOpen = false;
  DiscoModel? selectedDisco;

  final List<DiscoModel> discos = [
    DiscoModel(name: "EEkDC", duration: 1, amount: 100),
    DiscoModel(name: "EEkDC", duration: 1, amount: 200),
    DiscoModel(name: "EEkDC", duration: 1, amount: 1000),
  ];

  TextEditingController metreController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _obscured = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            // ── HEADER ─────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                Container(
                  height: heightSize(34.18),
                  padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(113.27),
                    color: isDark ? sButtonFillDark
                        : sLightFill,
                    border: Border.all(color: isDark ? sDarkBorder
                        : sLightFill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        wallet,
                        width:  widthSize(18),
                        height: heightSize(18),
                        colorFilter: ColorFilter.mode(
                          isDark ? sNavContainer : sActionButton,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: widthSize(4)),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _obscured
                            ? Text(
                          '••••••',
                          key: const ValueKey('hidden'),
                          style: TextStyle(
                            fontSize: fontSize(13),
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: isDark? Colors.white
                                : sActionButton,
                            letterSpacing: 2,
                          ),
                        )
                            : RichText(
                          key: const ValueKey('shown'),
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₦50,000',
                                style: TextStyle(
                                  inherit: false, // break font inheritance → ₦ renders
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isDark? Colors.white
                                      : sActionButton,
                                ),
                              ),
                              TextSpan(
                                text: '.00',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: CFONT.wRegular,
                                  fontFamily: CFONT.FAMILY,
                                  color: isDark? Colors.white
                                      : sActionButton,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: widthSize(4)),
                      GestureDetector(
                        onTap: () => setState(() => _obscured = !_obscured),
                        child: SvgPicture.asset(
                          _obscured ? visibilityOff : hide,
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
                )
              ],
            ),

            SizedBox(height: heightSize(26.46)),

            // ── TITLE ─────────────────────────────
            CText(
              text: 'Betting',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 19.85,
            ),

            SizedBox(height: heightSize(2.76)),

            CText(
              text: 'Bet your best, fund your betting wallet',
              size: 16,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 16,
              color: sConfirmTextColor,
            ),

            SizedBox(height: heightSize(40)),

            // ── PROVIDER HEADER ─────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  text: 'Select Provider',
                  size: 17.88,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                ),
                Container(
                  width: widthSize(126),
                  height: heightSize(30.86),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124.89),
                    color: isDark?sBeneficiaryColor:sLightFill,
                  ),
                  child: Center(
                    child: CText(
                      text: 'Beneficiaries',
                      size: 17.84,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: heightSize(10)),

            // ── SELECT FIELD ─────────────────────────────
            GestureDetector(
              onTap: () async {
                setState(() => isPlanSheetOpen = true);

                await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  builder: (_) {
                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 200),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 100 * (1 - value)),
                          child: Opacity(opacity: value, child: child),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(widthSize(20)),
                        decoration: BoxDecoration(
                          color: isDark ? sModalColor : Colors.white,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: widthSize(44),
                              height: heightSize(4),
                              margin: EdgeInsets.only(bottom: heightSize(16)),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: CText(
                                  key: ValueKey(selectedDisco?.name ?? "empty"),
                                  text: selectedDisco == null
                                      ? 'Select Disco'
                                      : '${selectedDisco!.name} (${selectedDisco!.duration} Day)',
                                  size: 14,
                                  fontWeight: CFONT.wRegular,
                                  fontFamily: CFONT.FAMILY,
                                ),
                              ),
                            ),

                            SizedBox(height: heightSize(33)),

                            ...discos.map((disco) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() => selectedDisco = disco);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(bottom: heightSize(13)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widthSize(24),
                                    vertical: heightSize(16.5),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Values().buttonRadius10),
                                    color: isDark ? sDarkFill : Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CText(
                                        text: disco.name,
                                        size: 16,
                                        fontWeight: CFONT.wRegular,
                                        fontFamily: CFONT.FAMILY,
                                      ),
                                      SizedBox(height: heightSize(10)),
                                      CText(
                                        text: 'N${disco.amount}',
                                        size: 16,
                                        fontWeight: CFONT.wMedium,
                                        fontFamily: CFONT.FAMILY,
                                        color: sNavContainer,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                );

                setState(() => isPlanSheetOpen = false);
              },

              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(15),
                  vertical: heightSize(20.5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius10),
                  color: isDark ? sDarkFill : Colors.transparent,
                  border: Border.all(color: isDark ? sDarkBorder : sLightBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText(
                      text: selectedDisco == null
                          ? 'Select Disco'
                          : '${selectedDisco!.name} (${selectedDisco!.duration} Day) - N${selectedDisco!.amount}',
                      size: 14,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                    ),
                    AnimatedRotation(
                      turns: isPlanSheetOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
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

            SizedBox(height: heightSize(15)),

            AppTextField(
              hasBottomMargin: false,
              hint: 'Enter User ID/Account ID',
              controller: metreController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input your ID.";
                }
                return null;
              },
            ),

            SizedBox(height: heightSize(15)),

            Row(
              children: [
                SvgPicture.asset(tick, width: widthSize(24), height: heightSize(24)),
                SizedBox(width: widthSize(8)),
                CText(
                  text: 'John Doe\nLekki...',
                  size: 15.64,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                ),
              ],
            ),

            SizedBox(height: heightSize(15)),

            AppTextField(
              showNairaPrefix: true,
              hasBottomMargin: false,
              height: heightSize(55),
              hint: '0.00',
              controller: amountController,
              inputType: TextInputType.number,
              error: '',
              suffixWidth: 102,
              suffixWidget: Container(
                padding: EdgeInsets.all(widthSize(10)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(124.89),
                  color: isDark?sContainerColor:sLightFill,
                ),
                child: CText(
                  text: 'Min N500',
                  size: 14,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                ),
              ),
              validFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input your amount.";
                }
                return null;
              },
            ),

            SizedBox(height: heightSize(13.86),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  //width: widthSize(113.75),
                  height: heightSize(33.86),
                  padding: EdgeInsets.only(left: widthSize(8), right: widthSize(8),),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124.89),
                    color: isDark?sBeneficiaryColor:sLightFill,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        addSquare,
                        width: widthSize(24),
                        height: heightSize(24),
                      ),
                      SizedBox(width: widthSize(3.75),),
                      CText(
                        text: 'Save Info',
                        size: 17.48,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                      ),
                    ],
                  ),
                )
              ],
            ),

            const Spacer(),

            ActionButton(
              text: 'Continue',
              color: sNavContainer,
              textColor: sActionButton,
              borderColor: sNavContainer,
              callback: () => Get.toNamed(Routes.confirmation),
            ),

            SizedBox(height: heightSize(20)),
          ],
        ),
      ),
    );
  }
}