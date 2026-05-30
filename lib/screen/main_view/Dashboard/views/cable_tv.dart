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
import 'package:sentro/core/utils/balance_visibility_wrapper.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';
import 'package:sentro/core/widgets/text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

// ── Nigerian cable TV providers ───────────────────────────────────────────────

class _CableProvider {
  final String name;
  final String logo;      // asset path — swap with your real assets
  final List<_CablePlan> plans;

  const _CableProvider({
    required this.name,
    required this.logo,
    required this.plans,
  });
}

class _CablePlan {
  final String name;
  final int amount;
  const _CablePlan({required this.name, required this.amount});
}

final _providers = [
  _CableProvider(
    name: 'DSTV',
    logo: etisalat,
    plans: [
      _CablePlan(name: 'Padi', amount: 2_500),
      _CablePlan(name: 'Yanga', amount: 3_500),
      _CablePlan(name: 'Confam', amount: 6_200),
      _CablePlan(name: 'Compact', amount: 15_700),
      _CablePlan(name: 'Compact Plus', amount: 24_900),
      _CablePlan(name: 'Premium', amount: 37_000),
    ],
  ),
  _CableProvider(
    name: 'GOTV',
    logo: mtn,   // add: static const gotv = 'assets/logos/gotv.png';
    plans: [
      _CablePlan(name: 'Smallie', amount: 1_575),
      _CablePlan(name: 'Jinja', amount: 2_715),
      _CablePlan(name: 'Jolli', amount: 4_085),
      _CablePlan(name: 'Max', amount: 7_600),
      _CablePlan(name: 'Supa', amount: 10_370),
    ],
  ),
  _CableProvider(
    name: 'Startimes',
    logo: glo,  // add: static const startimes = 'assets/logos/startimes.png';
    plans: [
      _CablePlan(name: 'Nova', amount: 900),
      _CablePlan(name: 'Basic', amount: 2_200),
      _CablePlan(name: 'Smart', amount: 3_000),
      _CablePlan(name: 'Classic', amount: 2_500),
      _CablePlan(name: 'Super', amount: 4_900),
    ],
  ),
  _CableProvider(
    name: 'ShowMax',
    logo: airtel,  // add: static const showmax = 'assets/logos/showmax.png';
    plans: [
      _CablePlan(name: 'Mobile', amount: 1_200),
      _CablePlan(name: 'Standard', amount: 4_500),
      _CablePlan(name: 'Standard with Sport', amount: 6_200),
    ],
  ),
];

// ── Page ──────────────────────────────────────────────────────────────────────

class CableTv extends StatefulWidget {
  const CableTv({super.key});

  @override
  State<CableTv> createState() => _CableTvState();
}

class _CableTvState extends State<CableTv> {
  bool _obscured         = false;
  bool _isProviderOpen   = false;
  bool _isPlanOpen       = false;

  _CableProvider? _selectedProvider;
  _CablePlan?     _selectedPlan;

  final _smartcardCtrl = TextEditingController();
  final _amountCtrl    = TextEditingController();

  @override
  void dispose() {
    _smartcardCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  // ── Provider sheet ──────────────────────────────────────────────────────────

  Future<void> _showProviderSheet(bool isDark) async {
    setState(() => _isProviderOpen = true);

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _BottomSheet(
        isDark: isDark,
        title: 'Select Provider',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _providers.map((p) {
            final isSelected = _selectedProvider?.name == p.name;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedProvider = p;
                  _selectedPlan     = null; // reset plan on provider change
                });
                Navigator.pop(context);
              },
              child: _SheetItem(
                isDark: isDark,
                isSelected: isSelected,
                child: Row(
                  children: [
                    // Provider logo — use Image.asset if PNG, SvgPicture if SVG
                    Container(
                      width:  widthSize(38),
                      height: heightSize(38),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey.shade100,
                      ),
                      child: Center(
                        child: Image.asset(
                          p.logo,
                          width:  widthSize(28),
                          height: heightSize(28),
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => CText(
                            text: p.name[0],
                            size: 16,
                            fontWeight: CFONT.wBold,
                            fontFamily: CFONT.FAMILY,
                            color: sNavContainer,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widthSize(12)),
                    Expanded(
                      child: CText(
                        text: p.name,
                        size: 16,
                        fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                        color: isSelected
                            ? sNavContainer
                            : (isDark ? Colors.white : sActionButton),
                      ),
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width:  widthSize(20),
                        height: heightSize(20),
                        colorFilter: const ColorFilter.mode(
                          sNavContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    setState(() => _isProviderOpen = false);
  }

  // ── Plan sheet ──────────────────────────────────────────────────────────────

  Future<void> _showPlanSheet(bool isDark) async {
    if (_selectedProvider == null) return;
    setState(() => _isPlanOpen = true);

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _BottomSheet(
        isDark: isDark,
        title: '${_selectedProvider!.name} Plans',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _selectedProvider!.plans.map((p) {
            final isSelected = _selectedPlan?.name == p.name;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedPlan = p);
                Navigator.pop(context);
              },
              child: _SheetItem(
                isDark: isDark,
                isSelected: isSelected,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: p.name,
                          size: 15,
                          fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                          color: isSelected
                              ? sNavContainer
                              : (isDark ? Colors.white : sActionButton),
                        ),
                        SizedBox(height: heightSize(3)),
                        Text(
                          '₦${_fmt(p.amount)}',
                          style: TextStyle(
                            inherit: false, // system font → ₦ renders
                            fontSize: fontSize(14),
                            fontWeight: FontWeight.w600,
                            color: sNavContainer,
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width:  widthSize(20),
                        height: heightSize(20),
                        colorFilter: const ColorFilter.mode(
                          sNavContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    setState(() => _isPlanOpen = false);
  }

  String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightSize(64)),

            // ── Header ──────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark ? arrowBackWhite : arrowBack,
                    width:  widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                BalancePill(
                  isDark: isDark,
                ),
              ],
            ),

            SizedBox(height: heightSize(26)),

            CText(
              text: 'Cable TV',
              size: 19.85,
              fontWeight: CFONT.wMedium,
              fontFamily: CFONT.FAMILY,
              color: colorScheme.onSurface,
            ),

            SizedBox(height: heightSize(3)),

            CText(
              text: 'Subscribe for DSTV, GOTV, Startimes and more',
              size: 16,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              color: isDark ? sConfirmTextColor : sLightModeMutedText,
            ),

            SizedBox(height: heightSize(30)),

            // ── Select Provider ──────────────────────────────
            CText(
              text: 'Select Provider',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: colorScheme.onSurface,
            ),
            SizedBox(height: heightSize(8)),
            _SelectorBox(
              isDark: isDark,
              isOpen: _isProviderOpen,
              label: _selectedProvider?.name ?? 'Choose provider',
              isEmpty: _selectedProvider == null,
              onTap: () => _showProviderSheet(isDark),
            ),

            SizedBox(height: heightSize(15)),

            // ── Select Plan ──────────────────────────────────
            CText(
              text: 'Select Plan',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: colorScheme.onSurface,
            ),
            SizedBox(height: heightSize(8)),
            _SelectorBox(
              isDark: isDark,
              isOpen: _isPlanOpen,
              label: _selectedPlan == null
                  ? (_selectedProvider == null
                  ? 'Select a provider first'
                  : 'Choose plan')
                  : '${_selectedPlan!.name} — ₦${_fmt(_selectedPlan!.amount)}',
              isEmpty: _selectedPlan == null,
              onTap: _selectedProvider != null
                  ? () => _showPlanSheet(isDark)
                  : null,
            ),

            SizedBox(height: heightSize(15)),

            // ── Smartcard number ─────────────────────────────
            CText(
              text: 'Smartcard / IUC Number',
              size: 14,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
              color: colorScheme.onSurface,
            ),
            SizedBox(height: heightSize(8)),
            AppTextField(
              hasBottomMargin: false,
              hint: 'e.g. 1234567890',
              controller: _smartcardCtrl,
              inputType: TextInputType.number,
              error: '',
              validFunction: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter your smartcard number.'
                  : null,
            ),

            SizedBox(height: heightSize(10)),

            // ── Verified name ────────────────────────────────
            Row(
              children: [
                SvgPicture.asset(
                  tick,
                  width:  widthSize(24),
                  height: heightSize(24),
                  colorFilter: const ColorFilter.mode(
                    sNavContainer,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: widthSize(8)),
                CText(
                  text: 'John Doe — Lekki, Lagos',
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: isDark ? Colors.white70 : sLightModeMutedText,
                ),
              ],
            ),

            const Spacer(),

            ActionButton(
              text: 'Continue',
              color: sNavContainer,
              textColor: sActionButton,
              callback: () => Get.toNamed(Routes.confirmation),
            ),

            SizedBox(height: heightSize(20)),
          ],
        ),
      ),
    );
  }
}

// ── Selector box (dropdown trigger) ──────────────────────────────────────────

class _SelectorBox extends StatelessWidget {
  final bool isDark;
  final bool isOpen;
  final String label;
  final bool isEmpty;
  final VoidCallback? onTap;

  const _SelectorBox({
    required this.isDark,
    required this.isOpen,
    required this.label,
    required this.isEmpty,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widthSize(15),
          vertical:   heightSize(18),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Values().buttonRadius10),
          color: isDark
              ? sDarkFill
              : (disabled ? const Color(0xFFF5F5F5) : Colors.transparent),
          border: Border.all(
            color: isOpen
                ? sNavContainer
                : (isDark ? sDarkBorder : sLightBorder),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CText(
                text: label,
                size: 14,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: isEmpty || disabled
                    ? (isDark ? Colors.white38 : Colors.black38)
                    : (isDark ? Colors.white : sActionButton),
              ),
            ),
            AnimatedRotation(
              turns:    isOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 180),
              child: SvgPicture.asset(
                arrowDown,
                width:  widthSize(20),
                height: heightSize(20),
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white54 : Colors.black45,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable bottom sheet wrapper ─────────────────────────────────────────────

class _BottomSheet extends StatelessWidget {
  final bool isDark;
  final String title;
  final Widget child;

  const _BottomSheet({
    required this.isDark,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? sModalColor : Colors.white;

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(
        widthSize(20),
        heightSize(16),
        widthSize(20),
        heightSize(32),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width:  widthSize(44),
              height: heightSize(4),
              margin: EdgeInsets.only(bottom: heightSize(16)),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white24
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // Title
          Center(
            child: CText(
              text: title,
              size: 18,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
              color: isDark ? Colors.white : sActionButton,
            ),
          ),

          SizedBox(height: heightSize(20)),

          child,
        ],
      ),
    );
  }
}

// ── Individual sheet item ─────────────────────────────────────────────────────

class _SheetItem extends StatelessWidget {
  final bool isDark;
  final bool isSelected;
  final Widget child;

  const _SheetItem({
    required this.isDark,
    required this.isSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: heightSize(10)),
      padding: EdgeInsets.symmetric(
        horizontal: widthSize(16),
        vertical:   heightSize(14),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values().buttonRadius10),
        color: isSelected
            ? sNavContainer.withOpacity(0.10)
            : (isDark ? sDarkFill : const Color(0xFFF7F7F7)),
        border: Border.all(
          color: isSelected
              ? sNavContainer.withOpacity(0.4)
              : Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}
