import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/bank.dart';
import 'package:sentro/core/models/transfer.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

final List<BankModel> _dummyBanks = [
  BankModel(image: unionBank,  bankName: 'Union Bank',  accountName: 'John Doe', accountNumber: 2023566581),
  BankModel(image: accessBank, bankName: 'Access Bank', accountName: 'John Doe', accountNumber: 2023566582),
  BankModel(image: gtBank,     bankName: 'Gt Bank',     accountName: 'John Doe', accountNumber: 2023566583),
  BankModel(image: unionBank,  bankName: 'Union Bank',  accountName: 'Jane Doe', accountNumber: 2023566584),
  BankModel(image: accessBank, bankName: 'Access Bank', accountName: 'Jane Doe', accountNumber: 2023566585),
  BankModel(image: gtBank,     bankName: 'Gt Bank',     accountName: 'Jane Doe', accountNumber: 2023566586),
];

class Beneficiaries extends StatefulWidget {
  const Beneficiaries({super.key});

  @override
  State<Beneficiaries> createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  final TextEditingController _searchController = TextEditingController();
  List<BankModel> _filtered = _dummyBanks;

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? _dummyBanks
          : _dummyBanks
          .where((t) =>
      t.bankName.toLowerCase().contains(query.toLowerCase()) ||
          t.accountName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ───────────────────────────────────────────
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
                  text: 'Beneficiaries',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  height: 20 / 18,
                ),
                const Spacer(),
              ],
            ),

            SizedBox(height: heightSize(51)),

            CText(
              text: 'SAVED BENEFICIARIES',
              size: 12,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              color: sGrey1,
            ),

            SizedBox(height: heightSize(16)),

            // ── Beneficiary list ──────────────────────────────────
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: sDarkFill,
              ),
              child: Column(
                children: [
                  SizedBox(height: heightSize(16.96)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(18),
                    ),
                    child: AuthSearchField(
                      height: heightSize(48),
                      borderColor: sDarkBorder,
                      color: sDarkFill,
                      hint: 'Search Beneficiary',
                      inputType: TextInputType.text,
                      error: '',
                      validFunction: (v) => v!,
                      onChanged: _onSearch,
                      controller: _searchController,
                    ),
                  ),

                  SizedBox(height: heightSize(22)),

                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(18),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: heightSize(10),
                      ),
                      child: Container(height: 1, color: sDarkBorder),
                    ),
                    itemBuilder: (context, index) {
                      final t = _filtered[index];
                      return InkWell(
                        onTap: () => Get.toNamed(
                          Routes.transferDetails,
                          arguments: TransferRecipient.bank(
                            image: t.image,
                            name: t.accountName,
                            bankName: t.bankName,
                            accountNumber: t.accountNumber,
                            fromBeneficiary: true, // ← flag set here
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  t.image,
                                  width: widthSize(35),
                                  height: heightSize(35),
                                ),
                                SizedBox(width: widthSize(13)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CText(
                                      text: t.accountName,
                                      fontWeight: CFONT.wMedium,
                                      fontFamily: CFONT.FAMILY,
                                      size: 16,
                                    ),
                                    CText(
                                      text:
                                      '${t.accountNumber} - ${t.bankName}',
                                      fontFamily: CFONT.FAMILY,
                                      fontWeight: CFONT.wRegular,
                                      size: 12,
                                      color: sGrey2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              union,
                              width: widthSize(26),
                              height: heightSize(6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: heightSize(78)),
                ],
              ),
            ),

            SizedBox(height: heightSize(40)),
          ],
        ),
      ),
    );
  }
}