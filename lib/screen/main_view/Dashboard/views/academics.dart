import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/disco.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';

class Academics extends StatefulWidget {
  const Academics({super.key});

  @override
  State<Academics> createState() => _AcademicsState();
}

class _AcademicsState extends State<Academics> {
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
    final colorScheme = Theme.of(context).colorScheme;
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
                    arrowBackWhite,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),

                BalancePill(isDark: isDark),
              ],
            ),

            SizedBox(height: heightSize(26.46)),

            // ── TITLE ─────────────────────────────
            CText(
              text: 'Academics',
              size: 19.85,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
            ),

            SizedBox(height: heightSize(2.76)),

            CText(
              text: 'Pay academics bills such as JAMB, WAEC, NECO',
              size: 16,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: sConfirmTextColor,
            ),

            SizedBox(height: heightSize(40)),

            // ── SELECT PROVIDER ───────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  text: 'Select Provider',
                  size: 17.88,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
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
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                      size: 17.84,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: heightSize(10)),
          ],
        ),
      ),
    );
  }
}