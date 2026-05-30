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
import 'package:sentro/core/widgets/balance_pill.dart';
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
  bool _obscured = false;

  final List<DiscoModel> discos = [
    DiscoModel(name: "EEkDC", duration: 1, amount: 100),
    DiscoModel(name: "EEkDC", duration: 1, amount: 200),
    DiscoModel(name: "EEkDC", duration: 1, amount: 1000),
  ];

  TextEditingController metreController = TextEditingController();
  TextEditingController amountController = TextEditingController();

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

            // HEADER
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

                BalancePill(
                  isDark: isDark,
                ),
              ],
            ),

            SizedBox(height: heightSize(26)),

            // TITLE
            CText(
              text: 'Electricity',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 19.85,
            ),

            SizedBox(height: heightSize(2.7)),

            CText(
              text: 'Keep your lights on, buy light token',
              size: 16,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 16,
              color: sConfirmTextColor,
            ),

            SizedBox(height: heightSize(20)),

            // PREPAID / POSTPAID SWITCH
            StatefulBuilder(
              builder: (context, setDialogState) {
                return Container(
                  width: widthSize(239),
                  height: heightSize(61.46),
                  padding: EdgeInsets.symmetric(horizontal: widthSize(9.57), vertical: heightSize(6.53)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: isDark
                        ? sDescriptionColor
                        : Colors.grey.shade200,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setDialogState(() => isPostpaidSelected = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              color: !isPostpaidSelected ? sActiveColor : Colors.transparent,
                            ),
                            child: Center(
                              child: CText(
                                text: 'Prepaid',
                                size: 15.64,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: !isPostpaidSelected
                                    ? sNavContainer : (
                                    isDark ? Colors.white
                                    : Colors.black87)
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () => setDialogState(() => isPostpaidSelected = true),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(44),
                              color: isPostpaidSelected ? sActiveColor : Colors.transparent,
                            ),
                            child: Center(
                              child: CText(
                                text: 'Postpaid',
                                size: 14,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: isPostpaidSelected
                                    ? sNavContainer: (
                                    isDark? Colors.white: Colors.black87
                                ),
                            ),
                          ),
                        ),
                      ),
                      )
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: heightSize(40)),

            // SELECT PROVIDER
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
                  height: heightSize(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(124),
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

            SizedBox(height: heightSize(15)),

            // SELECT DROPDOWN
            GestureDetector(
              onTap: () async {
                setState(() => isPlanSheetOpen = true);

                await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) {
                    return Container(
                      padding: EdgeInsets.all(widthSize(20)),
                      decoration: BoxDecoration(
                        color: isDark ? sModalColor : Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                  vertical: heightSize(16),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                    );
                  },
                );

                setState(() => isPlanSheetOpen = false);
              },

              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(15),
                  vertical: heightSize(20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDark ? sDarkFill : Colors.transparent,
                  border: Border.all(color: isDark ? sDarkBorder : sLightBorder),
                ),
                child: CText(
                  text: selectedDisco == null
                      ? 'Select Provider'
                      : '${selectedDisco!.name} - N${selectedDisco!.amount}',
                  size: 14,
                  fontWeight: CFONT.wRegular,
                  fontFamily: CFONT.FAMILY,
                ),
              ),
            ),

            SizedBox(height: heightSize(15)),

            // METRE INPUT
            AppTextField(
              hasBottomMargin: false,
              height: heightSize(55),
              hint: 'Meter Number',
              controller: metreController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input your meter number.";
                }
                return null;
              },
            ),

            SizedBox(height: heightSize(15)),

            // NAME DISPLAY
            Row(
              children: [
                SvgPicture.asset(tick, width: widthSize(24), height: heightSize(24)),
                SizedBox(width: widthSize(8)),
                CText(
                  text: 'John Doe\nLekki...',
                  size: 15.64,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                ),
              ],
            ),

            SizedBox(height: heightSize(15)),

            // AMOUNT
            AppTextField(
              showNairaPrefix: true,
              hasBottomMargin: false,
              height: heightSize(55),
              hint: '0.00',
              controller: amountController,
              inputType: TextInputType.number,
              error: '',
              validFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input amount.";
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

            Spacer(),

            ActionButton(
              text: 'Buy Electricity',
              color: sNavContainer,
              textColor: sActionButton,
              borderColor: sNavContainer,
              callback: () {
                Get.toNamed(Routes.confirmation);
              },
            ),

            SizedBox(height: heightSize(20)),
          ],
        ),
      ),
    );
  }
}
