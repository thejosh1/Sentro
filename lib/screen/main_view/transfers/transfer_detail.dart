import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/transfer.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';

class TransferDetail extends StatelessWidget {
  const TransferDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final TransferRecipient recipient =
    Get.arguments as TransferRecipient;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ─────────────────────────────────────────
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
                SvgPicture.asset(
                  logo1x,
                  width: widthSize(52),
                  height: heightSize(50),
                ),
              ],
            ),

            SizedBox(height: heightSize(10.46)),

            // ── Avatar ─────────────────────────────────────────
            recipient.isSentroTag
                ? Container(
              width: widthSize(80),
              height: heightSize(80),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(recipient.image),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            )
                : SvgPicture.asset(
              avatarTransfer,
              width: widthSize(80),
              height: heightSize(80),
            ),

            SizedBox(height: heightSize(8)),

            CText(
              text: recipient.name,
              size: 18,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 18,
            ),

            SizedBox(height: heightSize(2.5)),

            CText(
              text: recipient.isSentroTag
                  ? recipient.tag!
                  : '${recipient.accountNumber} - ${recipient.bankName}',
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              size: 12,
              color: sConfirmTextColor,
            ),

            // ── Sentro tag badge ───────────────────────────────
            if (recipient.isSentroTag) ...[
              SizedBox(height: heightSize(6)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(10),
                  vertical: heightSize(4),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: sNavContainer.withOpacity(0.15),
                ),
                child: CText(
                  text: 'Sentro User',
                  size: 11,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  color: sNavContainer,
                ),
              ),
            ],

            SizedBox(height: heightSize(14.5)),

            CText(
              text: '₦50,000.00',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              //fontFamily: CFONT.FAMILY,
              color: sNavContainer,
            ),

            SizedBox(height: heightSize(2.76)),

            CText(
              text: 'Lifetime Transaction',
              size: 12,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
            ),

            SizedBox(height: heightSize(50.82)),

            // ── Transaction history list ───────────────────────
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(18),
                vertical: heightSize(25),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: sDarkFill,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (_, __) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: heightSize(10),
                  ),
                  child: Container(
                    height: 0.5,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: 'N30,000',
                        size: 16,
                        fontWeight: CFONT.wMedium,
                        fontFamily: CFONT.FAMILY,
                        color: sGrey1,
                      ),
                      SizedBox(height: heightSize(2.5)),
                      CText(
                        text: '12:45.10 · 14 May, 2026',
                        size: 12,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        color: sGrey2,
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: heightSize(30)),

            // ── Action button — only when from beneficiary ─────
            if (recipient.fromBeneficiary) ...[
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.maxFinite,
                  height: heightSize(55),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.17),
                    color: Colors.transparent,
                    border: Border.all(color: sRed),
                  ),
                  child: Center(
                    child: CText(
                      text: 'Delete Beneficiary',
                      size: 16,
                      fontFamily:
                      CFONT.FAMILY,
                      fontWeight: CFONT.wMedium,
                      color: sRed,
                    ),
                  ),
                ),
              ),
              SizedBox(height: heightSize(42)),
            ],
          ],
        ),
      ),
    );
  }
}