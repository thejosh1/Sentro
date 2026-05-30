import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/models/bank.dart';
import 'package:sentro/core/models/transfer.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

final List<BankModel> _dummyBanks = [
  BankModel(image: unionBank, bankName: 'Union Bank', accountName: 'John Doe', accountNumber: 2023566581),
  BankModel(image: accessBank, bankName: 'Access Bank', accountName: 'John Doe', accountNumber: 2023566581),
  BankModel(image: gtBank, bankName: 'Gt Bank', accountName: 'John Doe', accountNumber: 2023566581),
];

final List<TransferRecipient> _dummySentroUsers = [
  TransferRecipient.sentro(image: user1, name: 'John Doe', tag: '@johndoe2026'),
  TransferRecipient.sentro(image: user2, name: 'Elizabeth Johnson', tag: '@elizabetjohnson'),
  TransferRecipient.sentro(image: user3, name: 'Tony Stark', tag: '@tonystark'),
];

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController narrationController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  bool _tagResolved = false;

  bool _obscured = false;

  bool isRecentSelected = false;
  bool isSheetOpen = false;
  BankModel? selectedBank;
  bool isRecent = true;

  List<BankModel> _filtered = _dummyBanks;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;

    if (args != null && args['isSentroTag'] == true) {
      isRecentSelected = true;
    }

    tagController.addListener(() {
      setState(() {
        _tagResolved = tagController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    tagController.dispose();
    amountController.dispose();
    narrationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _filtered = query.isEmpty
          ? _dummyBanks
          : _dummyBanks
          .where((t) => t.bankName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _recentBeneficiaryToggle() {
    return Container(
      width: widthSize(207),
      height: heightSize(41),
      padding: EdgeInsets.symmetric(horizontal: widthSize(5), vertical: heightSize(4)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5),
        color: sButtonFillDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isRecent = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isRecent ? sDarkFill : Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Recently',
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    size: 15.64,
                    height: 15.04 / 15.64,
                    color: isRecent ? sNavContainer : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isRecent = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: !isRecent ? sDarkFill : Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Beneficiary',
                    fontWeight: CFONT.wRegular,
                    size: 14,
                    color: !isRecent ? sNavContainer : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seeMoreButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widthSize(116.75),
          height: heightSize(38.86),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(124.89),
            color: sContainerColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CText(
                text: 'See More',
                size: 14,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
              ),
              SizedBox(width: widthSize(3.75)),
              SvgPicture.asset(arrowRight, width: widthSize(24), height: heightSize(24)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _saveBeneficiaryButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widthSize(167.01),
          height: heightSize(33.86),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(124.89),
            color: sBeneficiaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(tickSquare, width: widthSize(24), height: heightSize(24)),
              SizedBox(width: widthSize(3.75)),
              CText(
                text: 'Save Beneficiary',
                size: 17.48,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _resolvedUserChip(String name) {
    return _tagResolved ? Container(
      width: widthSize(205.78),
      height: heightSize(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(110.65),
        color: sTierColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(tick, width: widthSize(21.26), height: heightSize(21.26)),
          SizedBox(width: widthSize(3.32)),
          CText(
            text: name,
            fontWeight: CFONT.wRegular,
            fontFamily: CFONT.FAMILY,
            size: 15.49,
          ),
        ],
      ),
    ) : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ──────────────────────────────────────────
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
                        width: widthSize(18),
                        height: heightSize(18),
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
            CText(
              text: 'Transfer',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              height: 22.05 / 19.85,
            ),
            SizedBox(height: heightSize(10)),

            // ── Other Banks / Sentro Tag toggle ─────────────────
            Container(
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isRecentSelected = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: heightSize(48.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44.7),
                          color: !isRecentSelected ? sActiveColor : Colors.transparent,
                        ),
                        child: Center(
                          child: CText(
                            text: 'Other Banks',
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            size: 15.64,
                            height: 15.04 / 15.64,
                            color: !isRecentSelected ? sNavContainer : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isRecentSelected = true),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: heightSize(48.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(44.7),
                          color: isRecentSelected ? sActiveColor : Colors.transparent,
                        ),
                        child: Center(
                          child: CText(
                            text: 'Sentro Tag',
                            fontWeight: CFONT.wRegular,
                            size: 14,
                            color: isRecentSelected ? sNavContainer : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: heightSize(40)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── OTHER BANKS ──────────────────────────────────
                if (!isRecentSelected) ...[
                  AppTextField(
                    hasBottomMargin: false,
                    height: heightSize(55),
                    hint: 'Account Number',
                    hintColor: isDark?null:sGrey2,
                    controller: amountController,
                    inputType: TextInputType.number,
                    error: '',
                    validFunction: (value) {
                      if (value == null || value.trim().isEmpty) return "Input the account number.";
                      return null;
                    },
                  ),
                  SizedBox(height: heightSize(15)),

                  // ── Select Bank dropdown ────────────────────────
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      setState(() => isSheetOpen = true);
                      await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        enableDrag: true,
                        isDismissible: true,
                        isScrollControlled: true,
                        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.75),
                          builder: (_) {
                            return StatefulBuilder(
                              builder: (context, setSheetState) {
                                final TextEditingController sheetSearchController = TextEditingController();
                                List<BankModel> filteredSheetBanks = _dummyBanks;

                                return Stack(
                                  children: [
                                    BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                      child: Container(color: Colors.black.withOpacity(0.45)),
                                    ),
                                    TweenAnimationBuilder(
                                      duration: const Duration(milliseconds: 200),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      curve: Curves.easeOut,
                                      builder: (context, value, child) => Transform.translate(
                                        offset: Offset(0, 100 * (1 - value)),
                                        child: Opacity(opacity: value, child: child),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
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
                                                  child: CText(
                                                    text: 'Select Bank',
                                                    fontFamily: CFONT.FAMILY,
                                                    fontWeight: CFONT.wMedium,
                                                    size: 18,
                                                  ),
                                                ),
                                                SizedBox(height: heightSize(16)),

                                                // ── Search bar ──────────────────────────────
                                                AuthSearchField(
                                                  height: 56,
                                                  color: sBeneficiaryColor,
                                                  borderRadius: 124.89,
                                                  hint: 'Search bank',
                                                  inputType: TextInputType.text,
                                                  error: '',
                                                  validFunction: (v) => v!,
                                                  controller: sheetSearchController,
                                                  onChanged: (query) {
                                                    setSheetState(() {
                                                      filteredSheetBanks = query.isEmpty
                                                          ? _dummyBanks
                                                          : _dummyBanks
                                                          .where((b) => b.bankName
                                                          .toLowerCase()
                                                          .contains(query.toLowerCase()))
                                                          .toList();
                                                    });
                                                  },
                                                  onSubmitFunction: (q) {},
                                                ),

                                                SizedBox(height: heightSize(16)),

                                                // ── Bank list ───────────────────────────────
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: filteredSheetBanks.length,
                                                  itemBuilder: (context, index) {
                                                    final bank = filteredSheetBanks[index];
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() => selectedBank = bank);
                                                        Navigator.pop(context);
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 180),
                                                        margin: EdgeInsets.only(bottom: heightSize(13)),
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: widthSize(24),
                                                          vertical: heightSize(16.5),
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(Values().buttonRadius10),
                                                          color: isDark ? sDarkFill : Colors.transparent,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: widthSize(42),
                                                              height: heightSize(42),
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(
                                                                  image: AssetImage(bank.image),
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: widthSize(15)),
                                                            Expanded(
                                                              child: CText(
                                                                text: bank.bankName,
                                                                size: 16,
                                                                fontWeight: CFONT.wRegular,
                                                                fontFamily: CFONT.FAMILY,
                                                                height: 16.67 / 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),

                                                // ── Empty state ─────────────────────────────
                                                if (filteredSheetBanks.isEmpty)
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: heightSize(24)),
                                                    child: CText(
                                                      text: 'No bank found',
                                                      size: 14,
                                                      fontFamily: CFONT.FAMILY,
                                                      fontWeight: CFONT.wRegular,
                                                      color: sGrey2,
                                                    ),
                                                  ),

                                                SizedBox(height: heightSize(16)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                      );
                      setState(() => isSheetOpen = false);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: widthSize(15), top: heightSize(20.5), right: widthSize(19), bottom: heightSize(20.5)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Values().buttonRadius10),
                        color: isDark ? sDarkFill : sLightFill,
                        border: Border.all(color: isDark ? sDarkBorder : sLightBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            transitionBuilder: (child, animation) => FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(animation),
                                child: child,
                              ),
                            ),
                            child: CText(
                              key: ValueKey(selectedBank?.bankName ?? "empty"),
                              text: selectedBank == null ? 'Select Bank' : selectedBank!.bankName,
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                            ),
                          ),
                          AnimatedRotation(
                            turns: isSheetOpen ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: SvgPicture.asset(arrowDown, width: widthSize(20), height: heightSize(20)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (selectedBank != null) ...[
                    SizedBox(height: heightSize(10)),
                    _resolvedUserChip('Richmond Nnamdi Uche'),
                    SizedBox(height: heightSize(15)),
                    AppTextField(
                      showNairaPrefix: true,
                      hasBottomMargin: false,
                      height: heightSize(55),
                      hint: '0.00',
                      suffixWidth: 87,
                      suffixWidget: Container(
                        height: heightSize(25.86),
                        padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(124.89), color: sContainerColor),
                        child: Center(
                          child: CText(
                            text: 'Min: N500',
                            size: 14,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                          ),
                        ),
                      ),
                      controller: amountController,
                      inputType: TextInputType.number,
                      error: '',
                      validFunction: (value) {
                        if (value == null || value.trim().isEmpty) return "Input an amount.";
                        return null;
                      },
                    ),
                    SizedBox(height: heightSize(15)),
                    AppTextField(
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Note',
                              style: TextStyle(
                                fontSize: fontSize(17.88),
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            TextSpan(
                              text: ' (Optional)',
                              style: TextStyle(
                                fontSize: fontSize(17.88),
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: heightSize(75),
                      maxLines: 3,
                      hint: 'Type your note here (Optional)',
                      controller: narrationController,
                      inputType: TextInputType.multiline,
                      hasBottomMargin: false,
                      error: '',
                      validFunction: (value) => null,
                    ),
                    SizedBox(height: heightSize(10)),
                    _saveBeneficiaryButton(),
                    SizedBox(height: heightSize(30)),
                  ] else ...[
                    SizedBox(height: heightSize(15)),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left: widthSize(17), top: heightSize(17), right: widthSize(18)),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: sDarkFill),
                      child: Column(
                        children: [
                          _recentBeneficiaryToggle(),
                          SizedBox(height: 10),
                          AuthSearchField(
                            hint: 'Search recent',
                            inputType: TextInputType.text,
                            error: '',
                            validFunction: (v) => v!,
                            onChanged: _onSearch,
                            onSubmitFunction: (q) {},
                            controller: _searchController,
                          ),
                          SizedBox(height: heightSize(19)),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _filtered.length,
                            separatorBuilder: (_, __) => Padding(
                              padding: EdgeInsets.symmetric(vertical: heightSize(10)),
                              child: Container(height: 1, color: sDarkBorder),
                            ),
                            itemBuilder: (context, index) {
                              final t = _filtered[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                      Routes.transferDetails,
                                      arguments: TransferRecipient.bank(
                                        image: t.image,
                                        name: t.accountName,
                                        bankName: t.bankName,
                                        accountNumber: t.accountNumber,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(t.image, width: widthSize(35), height: heightSize(35)),
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
                                              text: '${t.accountNumber} - ${t.bankName}',
                                              fontFamily: CFONT.FAMILY,
                                              fontWeight: CFONT.wRegular,
                                              size: 12,
                                              color: sGrey2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(union, width: widthSize(26), height: heightSize(6)),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: heightSize(25.25)),
                          _seeMoreButton(),
                          SizedBox(height: heightSize(18.39)),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(86.04)),
                  ],
                ],

                // ── SENTRO TAG ───────────────────────────────────
                if (isRecentSelected) ...[
                  AppTextField(
                    hasBottomMargin: false,
                    height: heightSize(55),
                    hint: '@',
                    hintColor: sNavContainer,
                    controller: tagController,
                    inputType: TextInputType.text,
                    error: '',
                    validFunction: (value) {
                      if (value == null || value.trim().isEmpty) return "Input a Sentro tag.";
                      return null;
                    },
                  ),
                  SizedBox(height: heightSize(15)),
                  _resolvedUserChip('Richmond Nnamdi Uche'),
                  SizedBox(height: heightSize(15)),

                  // ── Shows recent list OR amount field based on tag input ──
                  if (!_tagResolved) ...[
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(left: widthSize(17), top: heightSize(17), right: widthSize(18)),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: sDarkFill),
                      child: Column(
                        children: [
                          _recentBeneficiaryToggle(),
                          SizedBox(height: 10),
                          AuthSearchField(
                            hint: 'Search Sentro users',
                            inputType: TextInputType.text,
                            error: '',
                            validFunction: (v) => v!,
                            onChanged: (q) {},
                            onSubmitFunction: (q) {},
                            controller: _searchController,
                          ),
                          SizedBox(height: heightSize(19)),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _dummySentroUsers.length,
                            separatorBuilder: (_, __) => Padding(
                              padding: EdgeInsets.symmetric(vertical: heightSize(10)),
                              child: Container(height: 0.5, color: Colors.white.withOpacity(0.1)),
                            ),
                            itemBuilder: (context, index) {
                              final u = _dummySentroUsers[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(Routes.transferDetails, arguments: u),
                                    child: Row(
                                      children: [
                                        Image.asset(u.image, width: widthSize(35), height: heightSize(35)),
                                        SizedBox(width: widthSize(13)),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CText(
                                              text: u.name,
                                              fontWeight: CFONT.wMedium,
                                              fontFamily: CFONT.FAMILY,
                                              size: 16,
                                            ),
                                            CText(
                                              text: u.tag!,
                                              fontFamily: CFONT.FAMILY,
                                              fontWeight: CFONT.wRegular,
                                              size: 12,
                                              color: sGrey2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(union, width: widthSize(26), height: heightSize(6)),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: heightSize(25.25)),
                          _seeMoreButton(),
                          SizedBox(height: heightSize(18.39)),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(86.04)),
                  ],

                  if (_tagResolved) ...[
                    AppTextField(
                      showNairaPrefix: true,
                      hasBottomMargin: false,
                      height: heightSize(55),
                      hint: '0.00',
                      suffixWidth: 87,
                      suffixWidget: Container(
                        height: heightSize(25.86),
                        padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(124.89), color: sContainerColor),
                        child: Center(
                          child: CText(
                            text: 'Fee: N500',
                            size: 14,
                            fontWeight: CFONT.wRegular,
                            fontFamily: CFONT.FAMILY,
                          ),
                        ),
                      ),
                      controller: amountController,
                      inputType: TextInputType.number,
                      error: '',
                      validFunction: (value) {
                        if (value == null || value.trim().isEmpty) return "Input an amount.";
                        return null;
                      },
                    ),
                    SizedBox(height: heightSize(15)),
                    _saveBeneficiaryButton(),
                    SizedBox(height: heightSize(30)),
                  ],
                ],

                ActionButton(
                  text: 'Send Money',
                  color: sNavContainer,
                  textColor: sActionButton,
                  callback: () => Get.toNamed(
                    Routes.confirmTransfer,
                    arguments: {
                      'isSentroTag': isRecentSelected,
                      'isRequest': false,
                    },
                  ),
                ),
                SizedBox(height: heightSize(42)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}