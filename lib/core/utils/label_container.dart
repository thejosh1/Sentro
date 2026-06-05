// lib/core/utils/label_container.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/models/network.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

// ── Shared field height — single source of truth ──────────────────────────────
const double _kFieldHeight = 58;

class LabelContainer extends StatefulWidget {
  final bool isData;
  const LabelContainer({super.key, this.isData = false});

  @override
  State<LabelContainer> createState() => _LabelContainerState();
}

class _LabelContainerState extends State<LabelContainer> {
  late NetworkModel selectedNetwork;
  PlanModel? selectedPlan;

  final List<NetworkModel> networks = [
    NetworkModel(name: 'MTN', logo: mtn),
    NetworkModel(name: 'AIRTEL', logo: airtel),
    NetworkModel(name: 'GLO', logo: glo),
    NetworkModel(name: '9MOBILE', logo: etisalat),
  ];

  final List<PlanModel> plans = [
    PlanModel(name: '110MB Daily Plan', duration: 1, amount: 100),
    PlanModel(name: '230MB Daily Plan', duration: 1, amount: 200),
    PlanModel(name: '500MB Daily Plan', duration: 1, amount: 1000),
    PlanModel(name: '1GB Daily Plan',   duration: 1, amount: 1500),
    PlanModel(name: '2GB Weekly Plan',  duration: 7, amount: 3500),
    PlanModel(name: '5GB Monthly Plan', duration: 30, amount: 4500),
    PlanModel(name: '10GB Monthly Plan',duration: 30, amount: 5500),
  ];

  bool isSheetOpen     = false;
  bool isPlanSheetOpen = false;

  final dataController        = TextEditingController();
  final dataPhoneController   = TextEditingController();
  final airtimeController     = TextEditingController();
  final airtimePhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedNetwork = networks.first;
  }

  @override
  void dispose() {
    dataController.dispose();
    dataPhoneController.dispose();
    airtimeController.dispose();
    airtimePhoneController.dispose();
    super.dispose();
  }

  // ── Network bottom sheet ──────────────────────────────────────────────────

  Future<void> _showNetworkSheet(BuildContext context, bool isDark) async {
    setState(() => isSheetOpen = true);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _NetworkSheet(
        networks: networks,
        selected: selectedNetwork,
        isDark: isDark,
        onSelect: (n) {
          setState(() => selectedNetwork = n);
          Navigator.pop(context);
        },
      ),
    );
    setState(() => isSheetOpen = false);
  }

  // ── Plan bottom sheet ─────────────────────────────────────────────────────

  Future<void> _showPlanSheet(BuildContext context, bool isDark) async {
    setState(() => isPlanSheetOpen = true);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _PlanSheet(
        plans: plans,
        selected: selectedPlan,
        isDark: isDark,
        onSelect: (p) {
          setState(() => selectedPlan = p);
          Navigator.pop(context);
        },
      ),
    );
    setState(() => isPlanSheetOpen = false);
  }

  // ── Network selector box (fixed height = _kFieldHeight) ──────────────────

  Widget _networkBox(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => _showNetworkSheet(context, isDark),
      child: Container(
        width: widthSize(115),
        height: heightSize(_kFieldHeight), // same as AppTextField
        padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Values().buttonRadius10),
          color: isDark ? sDarkFill : Colors.transparent,
          border: Border.all(
            color: isDark ? sDarkBorder : sLightBorder,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: widthSize(24),
              height: heightSize(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(selectedNetwork.logo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: widthSize(5)),
            Expanded(
              child: CText(
                text: selectedNetwork.name,
                size: 12,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
              ),
            ),
            AnimatedRotation(
              turns: isSheetOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: SvgPicture.asset(
                arrowDown,
                width: widthSize(16),
                height: heightSize(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Row: Network + Phone ──────────────────────────────────────────────────

  Widget _networkPhoneRow(
      BuildContext context,
      bool isDark,
      bool useAccent,
      Color accent,
      TextEditingController phoneCtrl,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end, // align bottoms
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              text: 'Network',
              size: 14,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
            ),
            SizedBox(height: heightSize(8)),
            _networkBox(context, isDark),
          ],
        ),
        SizedBox(width: widthSize(12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: 'Phone Number',
                size: 14,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
              ),
              SizedBox(height: heightSize(8)),
              // AppTextField height is driven by contentPadding → matches _kFieldHeight
              AppTextField(
                hint: '09060000000',
                hasBottomMargin: false,
                controller: phoneCtrl,
                inputType: TextInputType.phone,
                error: '',
                validFunction: (v) =>
                (v == null || v.trim().isEmpty)
                    ? 'Please input your phone number.'
                    : null,
                suffixWidget: SvgPicture.asset(
                  addUser,
                  width: widthSize(22),
                  height: heightSize(22),
                  colorFilter: useAccent?ColorFilter.mode(accent, BlendMode.srcIn):isDark?null:ColorFilter.mode(sActionButton, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = AccentController.to.accent.value;
    final useAccent = !_isDefaultAccent(accent);
    if (widget.isData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _networkPhoneRow(context, isDark, useAccent, accent, dataPhoneController),
          SizedBox(height: heightSize(14)),

          // Plan selector
          GestureDetector(
            onTap: () => _showPlanSheet(context, isDark),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(15),
                vertical: heightSize(18),
              ),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(Values().buttonRadius10),
                color: isDark ? sDarkFill : Colors.transparent,
                border: Border.all(
                  color: isDark ? sDarkBorder : sLightBorder,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: CText(
                      key: ValueKey(selectedPlan?.name ?? 'empty'),
                      text: selectedPlan == null
                          ? 'Select a plan'
                          : '${selectedPlan!.name} (${selectedPlan!.duration}d) — ₦${selectedPlan!.amount}',
                      size: 14,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                      color: selectedPlan == null
                          ? (isDark ? Colors.white38 : Colors.black38)
                          : null,
                    ),
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

          SizedBox(height: heightSize(32)),

          ActionButton(
            text: 'Buy Data',
            height: heightSize(55),
            textColor: Colors.white,
            callback: () {
              Get.back();
              Get.toNamed(Routes.confirmation);
            },
          ),
        ],
      );
    }

    // ── Airtime ──────────────────────────────────────────────────────────────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _networkPhoneRow(context, isDark, useAccent, accent, airtimePhoneController),
        SizedBox(height: heightSize(14)),

        // Amount
        AppTextField(
          showNairaPrefix: true,
          hasBottomMargin: false,
          hint: '0.00',
          controller: airtimeController,
          inputType: const TextInputType.numberWithOptions(decimal: true), // Allowed decimals & commas smoothly
          inputFormatters: [NairaInputFormatter()],
          error: '',
          validFunction: (v) =>
          (v == null || v.trim().isEmpty) ? 'Select an amount.' : null,
        ),

        SizedBox(height: heightSize(32)),

        ActionButton(
          text: 'Buy Airtime',
          height: heightSize(55),
          textColor: Colors.white,
          color: useAccent?accent:null,
          callback: () {
            Get.back();
            Get.toNamed(Routes.confirmation);
          },
        ),
      ],
    );
  }
}

// ── Network bottom sheet ───────────────────────────────────────────────────────

class _NetworkSheet extends StatelessWidget {
  final List<NetworkModel> networks;
  final NetworkModel selected;
  final bool isDark;
  final ValueChanged<NetworkModel> onSelect;

  const _NetworkSheet({
    required this.networks,
    required this.selected,
    required this.isDark,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widthSize(20)),
      decoration: BoxDecoration(
        color: isDark ? sModalColor : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _handle(),
          Center(
            child: CText(
              text: 'Select Network',
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
              size: 18,
            ),
          ),
          SizedBox(height: heightSize(24)),
          ...networks.map((n) {
            final isSelected = n.name == selected.name;
            return GestureDetector(
              onTap: () => onSelect(n),
              child: Container(
                margin: EdgeInsets.only(bottom: heightSize(10)),
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(16),
                  vertical: heightSize(14),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Values().buttonRadius10),
                  color: isSelected
                      ? sNavContainer.withOpacity(0.08)
                      : (isDark ? sDarkFill : Colors.transparent),
                  border: Border.all(
                    color: isSelected ? sNavContainer : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: widthSize(38),
                      height: heightSize(38),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(n.logo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: widthSize(14)),
                    Expanded(
                      child: CText(
                        text: n.name,
                        size: 16,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                      ),
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width: widthSize(20),
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
          }),
          SizedBox(height: heightSize(16)),
        ],
      ),
    );
  }
}

// ── Plan bottom sheet ──────────────────────────────────────────────────────────

class _PlanSheet extends StatelessWidget {
  final List<PlanModel> plans;
  final PlanModel? selected;
  final bool isDark;
  final ValueChanged<PlanModel> onSelect;

  const _PlanSheet({
    required this.plans,
    required this.selected,
    required this.isDark,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widthSize(20)),
      decoration: BoxDecoration(
        color: isDark ? sModalColor : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _handle(),
          Center(
            child: CText(
              text: 'Select a plan',
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
              size: 18,
            ),
          ),
          SizedBox(height: heightSize(24)),
          ...plans.map((p) {
            final isSelected = p.name == selected?.name &&
                p.amount == selected?.amount;
            return GestureDetector(
              onTap: () => onSelect(p),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(bottom: heightSize(10)),
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(16),
                  vertical: heightSize(14),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Values().buttonRadius10),
                  color: isSelected
                      ? sNavContainer.withOpacity(0.08)
                      : (isDark ? sDarkFill : Colors.transparent),
                  border: Border.all(
                    color:
                    isSelected ? sNavContainer : Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: p.name,
                          size: 15,
                          fontWeight: CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                        ),
                        SizedBox(height: heightSize(4)),
                        CText(
                          // system font so ₦ renders correctly
                          text: '₦${p.amount}',
                          size: 15,
                          fontWeight: CFONT.wMedium,
                          fontFamily: null,
                          color: sNavContainer,
                        ),
                      ],
                    ),
                    if (isSelected)
                      SvgPicture.asset(
                        tickLight,
                        width: widthSize(20),
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
          }),
          SizedBox(height: heightSize(16)),
        ],
      ),
    );
  }
}

// ── Shared drag handle ────────────────────────────────────────────────────────

Widget _handle() {
  return Container(
    width: 44,
    height: 4,
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}