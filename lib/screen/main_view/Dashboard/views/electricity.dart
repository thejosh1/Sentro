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

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  bool isPostpaidSelected = false;
  bool isPlanSheetOpen = false;
  DiscoModel? selectedDisco;

  final List<DiscoModel> discos = [
    DiscoModel(
      name: "EEkDC",
      duration: 1,
      amount: 100,
    ),
    DiscoModel(
      name: "EEkDC",
      duration: 1,
      amount: 200,
    ),
    DiscoModel(
      name: "EEkDC",
      duration: 1,
      amount: 1000,
    ),
  ];

  TextEditingController metreController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),
            // ── Header ───────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    arrowBackWhite,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      wallet,
                      width: widthSize(24),
                      height: heightSize(24),
                    ),
                    SizedBox(width: widthSize(3.4),),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '₦50,000',
                            style: TextStyle(
                              fontSize: 15.86,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                              height: 22.65 / 15.86,
                            ),
                          ),

                          TextSpan(
                            text: '.00',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                              height: 22.65 / 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      visibilityOff,
                      width: widthSize(24),
                      height: heightSize(24),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: heightSize(26.46),),
            // ── Description ───────────────────────────────────────────
            CText(
              text: 'Electricity',
              size: 19.85,
              fontWeight: FontWeight.w500,
              fontFamily: CFONT.MEDIUM,
              height: 22.05/19.85,
            ),
            SizedBox(height: heightSize(2.76)),
            CText(
              text: 'Keep your lights on, buy light token',
              size: 16,
              fontWeight: FontWeight.w400,
              fontFamily: CFONT.REGULAR,
              height: 22.05/16,
              color: sConfirmTextColor,
            ),
            SizedBox(height: heightSize(20),),
            StatefulBuilder(
              builder: (context, setDialogState) {
                return Container(
                  width: widthSize(239.14),
                  height: heightSize(61.46),
                  padding: EdgeInsets.symmetric(horizontal: widthSize(9.57)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44.7),
                    color: sDescriptionColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // prepaid
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              isPostpaidSelected = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                              width: widthSize(117.75),
                              height: heightSize(48.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(44.7),
                              color: !isPostpaidSelected
                                  ? sActiveColor
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: CText(
                                text: 'Prepaid',
                                fontFamily: CFONT.REGULAR,
                                fontWeight: FontWeight.w400,
                                size: 15.64,
                                height: 15.04/15.64,
                                color: !isPostpaidSelected
                                    ? sNavContainer
                                    : Colors.white,
                              ),
                            )
                          ),
                        ),
                      ),

                      // postpaid
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setDialogState(() { // ← use setDialogState, not setState
                              isPostpaidSelected = true;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: widthSize(117.75),
                            height: heightSize(48.05),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44.7),
                              color: isPostpaidSelected
                                  ? sActiveColor
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: CText(
                                text: 'Postpaid',
                                fontWeight: FontWeight.w400,
                                size: 14,
                                color: isPostpaidSelected
                                    ? sNavContainer
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
            ),
            SizedBox(height: heightSize(40),),
            //select provider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  text: 'Select Provider',
                  size: 17.88,
                  fontFamily: CFONT.REGULAR,
                  fontWeight: FontWeight.w400,
                ),
                Container(
                  width: widthSize(126),
                  height: heightSize(30.86),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124.89),
                    color: sBeneficiaryColor,
                  ),
                  child: Center(
                    child: CText(
                      text: 'Beneficiaries',
                      fontWeight: FontWeight.w400,
                      size: 17.84,
                      fontFamily: CFONT.REGULAR,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: heightSize(10),),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isPlanSheetOpen = true;
                });
                await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height*0.75,
                  ),
                  builder: (_) {
                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 100 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(widthSize(20)),
                        decoration: BoxDecoration(
                          color: isDark ? sModalColor : Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
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
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.3),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  );
                                },
                                child: CText(
                                  key: ValueKey(selectedDisco?.name ?? "empty"),
                                  text: selectedDisco == null
                                      ? 'Select Disco'
                                      : '${selectedDisco!.name} (${selectedDisco!.duration} Day)',
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: CFONT.REGULAR,
                                ),
                              ),
                            ),
                            SizedBox(height: heightSize(33),),

                            ...discos.map((disco) {

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDisco = disco;
                                  });

                                  Navigator.pop(context);
                                },
                                child: AnimatedContainer(
                                  width: double.maxFinite,
                                  duration: const Duration(milliseconds: 250),
                                  margin: EdgeInsets.only(
                                    bottom: heightSize(13),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widthSize(24),
                                    vertical: heightSize(16.5),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Values().buttonRadius10),
                                    color: isDark?sDarkFill:Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CText(
                                        text: disco.name,
                                        size: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: CFONT.REGULAR,
                                        height: 16.67 / 16,
                                      ),
                                      SizedBox(height: heightSize(10),),
                                      CText(
                                        text: 'N${disco.amount}',
                                        fontFamily: CFONT.MEDIUM,
                                        fontWeight: FontWeight.w500,
                                        size: 16,
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

                setState(() {
                  isPlanSheetOpen = false;
                });
              },
              child: Container(
                padding: EdgeInsets.only(left: widthSize(15), top: heightSize(20.5), right: widthSize(19), bottom: heightSize(20.5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Values().buttonRadius10,),
                  color: isDark?sDarkFill:Colors.transparent,
                  border: Border.all(color: isDark?sDarkBorder:sLightBorder,),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: CText(
                        key: ValueKey(selectedDisco?.name ?? "empty"),
                        text: selectedDisco == null
                            ? 'Select Disco'
                            : '${selectedDisco!.name} (${selectedDisco!.duration} Day) - N${selectedDisco!.amount}',
                        size: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: CFONT.REGULAR,
                      ),
                    ),

                    AnimatedRotation(
                      turns: isPlanSheetOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
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
            SizedBox(height: heightSize(15),),
            AppTextField(
              hasBottomMargin: false,
              height: heightSize(55),
              hint: 'Metre Number',
              controller: metreController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "Input your meter number.";
                }
                return null;
              },
            ),
            SizedBox(height: heightSize(15),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  tick,
                  width: widthSize(24),
                  height: heightSize(24),
                ),
                SizedBox(width: widthSize(8),),
                CText(
                  text: 'John Doe\nLekki...',
                  size: 15.64,
                  fontFamily: CFONT.REGULAR,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: heightSize(15),),
            AppTextField(
              showNairaPrefix: true,
              hasBottomMargin: false,
              height: heightSize(55),
              hint: '₦0.00',
              suffixWidth: 84,
              suffixWidget: Container(
                padding: EdgeInsets.only(
                  left: widthSize(10),
                  top: heightSize(1.86),
                  right: widthSize(10),
                  bottom: heightSize(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(124.89),
                  color: sContainerColor,
                ),
                child: CText(
                  text: 'Min N500',
                  size: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                ),
              ),
              controller: amountController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "Input your meter number.";
                }
                return null;
              },
            ),
            SizedBox(height: heightSize(10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: widthSize(113.75),
                  height: heightSize(33.86),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124.89),
                    color: sBeneficiaryColor,
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
                        fontFamily: CFONT.REGULAR,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            ActionButton(
              text: 'Buy Electricity',
              color: sNavContainer,
              textColor: sActionButton,
              callback: () {
                Get.toNamed(Routes.confirmation);
              },
            ),
            SizedBox(height: heightSize(20),)
          ],
        ),
      ),
    );
  }
}
