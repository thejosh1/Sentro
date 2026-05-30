import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/models/savings_field.dart';
import 'package:sentro/core/models/savings_type.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/drop_down.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class SavingsType extends StatefulWidget {
  const SavingsType({super.key});

  @override
  State<SavingsType> createState() => _SavingsTypeState();
}

class _SavingsTypeState extends State<SavingsType> {
  final Map<String, String> _dropdownValues = {};
  late SavingsOption option;
  late List<SavingsOption> allOptions;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _toggleStates = {};

  bool _getToggleValue(SavingsField field) {
    return _toggleStates.putIfAbsent(
      field.label,
          () => field.toggleState ?? false,
    );
  }

  bool _isFrequencyOpen = false;
  String _selectedFrequency = 'Monthly (on the 1st)';

  final List<String> _frequencies = [
    'Daily',
    'Weekly (every Monday)',
    'Monthly (on the 1st)',
    'Monthly (on the 15th)',
    'Quarterly',
  ];

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map;

    option = args["selected"];
    allOptions = List<SavingsOption>.from(args["all"]);
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _getController(String key) {
    return _controllers.putIfAbsent(
      key,
          () => TextEditingController(),
    );
  }

  String _formatDate(DateTime date, String format) {
    switch (format.toLowerCase()) {
      case 'dd/mm/yyyy':
        return "${date.day.toString().padLeft(2, '0')}/"
            "${date.month.toString().padLeft(2, '0')}/"
            "${date.year}";

      case 'mm/dd/yyyy':
        return "${date.month.toString().padLeft(2, '0')}/"
            "${date.day.toString().padLeft(2, '0')}/"
            "${date.year}";

      case 'yyyy-mm-dd':
        return "${date.year}-"
            "${date.month.toString().padLeft(2, '0')}-"
            "${date.day.toString().padLeft(2, '0')}";

      default:
        return "${date.day.toString().padLeft(2, '0')}/"
            "${date.month.toString().padLeft(2, '0')}/"
            "${date.year}";
    }
  }

  Widget _typeSelector() {
    return PopupMenuButton<SavingsOption>(
      color: sDarkFill,
      onSelected: (value) {
        setState(() {
          option = value;
        });
      },
      itemBuilder: (context) {
        return allOptions.map((type) {
          return PopupMenuItem<SavingsOption>(
            value: type,
            padding: EdgeInsets.symmetric(
              horizontal: widthSize(12),
              vertical: heightSize(4),
            ),
            height: heightSize(36),
            child: CText(
              text: type.title,
              color: Colors.white,
            ),
          );
        }).toList();
      },
      child: Container(
        width: widthSize(187.35),
        height: heightSize(48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(44.7),
          color: sActiveColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: CText(
                text: option.title,
                size: 15,
                fontFamily: CFONT.FAMILY,
                color: sNavContainer,
              ),
            ),
            SizedBox(width: widthSize(10)),
            SvgPicture.asset(
              arrowDown,
              width: widthSize(22),
              height: heightSize(22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(SavingsField field, bool isDark) {
    switch (field.type) {
      case SavingsFieldType.text:
        return AppTextField(
          hasBottomMargin: false,
          verticalPadding: 19,
          hint: field.hint ?? field.label,
          controller: TextEditingController(),
          inputType: TextInputType.text,
          error: '',
          validFunction: (_) => null,
        );

      case SavingsFieldType.amount:
        final controller = _getController(field.label);
        return AppTextField(
          showNairaPrefix: true,
          hasBottomMargin: false,
          verticalPadding: 19,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NairaInputFormatter(),
          ],
          hint: field.hint ?? '0.00',
          controller: controller,
          suffixWidth: 112,
          suffixWidget: Container(
            height: heightSize(25.86),
            padding: EdgeInsets.symmetric(
              horizontal: widthSize(10),
              vertical: heightSize(5),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(124.89),
                color: isDark?sContainerColor:sLightFill,
            ),
            child: CText(
              text: 'Min: N10,000',
              size: 14,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
            ),
          ),
          inputType: TextInputType.number,
          error: '',
          validFunction: (_) => null,
        );

      case SavingsFieldType.dropdown:
        final isOpen = _toggleStates['__dropdown_${field.label}__'] == true;
        final selectedValue = _dropdownValues[field.label];
        return _SelectorBox(
          isDark: isDark,
          isOpen: isOpen,
          label: selectedValue ?? field.hint ?? field.label,
          isEmpty: selectedValue == null,
          onTap: () async {
            FocusScope.of(context).unfocus();
            setState(() => _toggleStates['__dropdown_${field.label}__'] = true);
            await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) => StatefulBuilder(
                builder: (context, setSheetState) {
                  return _BottomSheet(
                    isDark: isDark,
                    title: field.label,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: (field.dropdownItems ?? []).map((item) {
                        final isSelected = item == (_dropdownValues[field.label] ?? field.hint);
                        return GestureDetector(
                          onTap: () {
                            setState(() => _dropdownValues[field.label] = item);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: heightSize(10)),
                            padding: EdgeInsets.symmetric(
                              horizontal: widthSize(16),
                              vertical: heightSize(14),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (isDark ? sDarkFill : const Color(0xFFF7F7F7)),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CText(
                                  text: item,
                                  size: 14,
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                                  color: isSelected
                                      ? sNavContainer
                                      : (isDark ? Colors.white : sActionButton),
                                ),
                                if (isSelected)
                                  SvgPicture.asset(
                                    tickLight,
                                    width: widthSize(18),
                                    height: heightSize(18),
                                    colorFilter: const ColorFilter.mode(
                                      sNavContainer, BlendMode.srcIn,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            );
            setState(() => _toggleStates['__dropdown_${field.label}__'] = false);
          },
        );

      case SavingsFieldType.info:
        final isEnabled = _getToggleValue(field);
        return Container(
          width: double.maxFinite,
          height: heightSize(93),
          padding: EdgeInsets.only(left: widthSize(10), top: heightSize(15),),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.17),
            color: isDark?sDarkFill:sLightFill,
            border: Border.all(color: isDark?sDarkBorder:sLightBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: field.label,
                    size: 18,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                  ),
                  SizedBox(height: 6,),
                  SizedBox(
                    width: widthSize(263),
                    child: CText(
                      text: field.description??'',
                      size: 12,
                      fontWeight: CFONT.wRegular,
                      fontFamily: CFONT.FAMILY,
                    ),
                  ),
                ],
              ),
              SizedBox(width: widthSize(6),),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _toggleStates[field.label] = !isEnabled;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  width: widthSize(54),
                  height: heightSize(28),
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(4),
                    vertical: heightSize(3),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: isEnabled ? sNavContainer : sDarkBorder,
                  ),
                  child: Row(
                    mainAxisAlignment: isEnabled
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeInOut,
                        width: widthSize(22),
                        height: heightSize(22),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      case SavingsFieldType.date:
        final controller = _getController(field.label);

        return AppTextField(
          showNairaPrefix: false,
          hasBottomMargin: false,
          height: heightSize(55),
          hint: field.hint ?? 'dd/mm/yyyy',
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DateInputFormatter(),
          ],
          suffixWidth: 24,
          suffixWidget: GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                controller.text = _formatDate(
                  pickedDate,
                  field.hint ?? 'dd/mm/yyyy',
                );
              }
            },
            child: SvgPicture.asset(
              calendar,
              width: widthSize(22),
              height: heightSize(22),
            ),
          ),
          inputType: TextInputType.datetime,
          error: '',
          validFunction: (_) =>null,
        );

      case SavingsFieldType.card:
        return Column(
          children: [
            SizedBox(height: heightSize(2)),
            Divider(color: isDark?sDarkBorder:sLightBorder),
            SizedBox(height: heightSize(12.5)),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(15),
                vertical: heightSize(10),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                color: isDark?sDarkFill:sLightFill,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Card Title ─────────────────────────────
                  CText(
                    text: field.label,
                    size: 16,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    color: isDark?sNavContainer:sActionButton,
                  ),
                  SizedBox(height: heightSize(5),),
                  // ── Items ──────────────────────────────────
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(7),
                    ),
                    itemCount: field.cardItems?.length ?? 0,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: heightSize(10),
                        ),
                        child: Divider(
                          color: sDarkBorder,
                          height: 1,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      final item = field.cardItems![index];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: item.label,
                            size: 13,
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            color: isDark?sGrey1:sGrey2,
                          ),
                          CText(
                            text: item.value,
                            size: 14,
                            //fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            color: item.isColored==true ? (isDark?sNavContainer:sActionButton) : Theme.of(context).colorScheme.onSurface,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: heightSize(8)),
            Row(
              children: [
                SvgPicture.asset(
                  tickLight,
                  width: widthSize(24),
                  height: heightSize(24),
                  colorFilter: isDark?null:ColorFilter.mode(sTextGreen, BlendMode.srcIn),
                ),
                SizedBox(width: widthSize(2.5),),
                CText(
                  text: 'Interest will be reinvested automatically at maturity',
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: isDark?sNavContainer:sTextGreen,
                )
              ],
            )
          ],
        );
    }
  }

  Widget _content(bool isDark) {
    return Column(
      children: [
        SizedBox(height: heightSize(64)),

        Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(isDark?arrowBackWhite:arrowBack, width: widthSize(42), height: heightSize(42)),
            ),
            const Spacer(),
            _typeSelector(),
          ],
        ),

        SizedBox(height: heightSize(23.46)),

        CText(text: option.title, size: 19.85, height: 22.05/19.85, fontFamily: CFONT.FAMILY, fontWeight: CFONT.wMedium),
        SizedBox(height: heightSize(2.76)),
        CText(text: option.description, size: 14, fontFamily: CFONT.FAMILY, color: isDark?sConfirmTextColor:sGrey2),

        SizedBox(height: heightSize(16)),

        // ── Interest rate chip ──────────────────────────────────
        if (option.interest != null)
          CText(
            text: '${option.interest}%',
            size: 12,
            fontFamily: CFONT.FAMILY,
            fontWeight: CFONT.wMedium,
            color: option.interestColor ??
                (isDark ? sNavContainer : sActionButton),
          ),
        SizedBox(height: heightSize(33.46)),

        // ── Fields ──────────────────────────────────────────────
        Column(
          children: (option.fields ?? []).expand((field) {
            final widgets = <Widget>[];

            // ── Insert extra fields BEFORE card ─────────────────────
            if (
            field.type == SavingsFieldType.card &&
                _toggleStates["Enable Auto-Save contribution"] == true
            ) {
              widgets.add(
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, anim) {
                    return SizeTransition(
                      sizeFactor: anim,
                      child: FadeTransition(
                        opacity: anim,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    key: const ValueKey("extra_fields"),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SelectorBox(
                              isDark: isDark,
                              isOpen: _isFrequencyOpen,
                              label: _dropdownValues[field.label] ?? field.hint ?? field.label,
                              isEmpty: !_dropdownValues.containsKey(field.label),
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                setState(() => _isFrequencyOpen = true);
                                await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (_) => _BottomSheet(
                                    isDark: isDark,
                                    title: 'Frequency',
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: _frequencies.map((f) {
                                        final isSelected = f == _selectedFrequency;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() => _selectedFrequency = f);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: double.maxFinite,
                                            margin: EdgeInsets.only(bottom: heightSize(10)),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: widthSize(16),
                                              vertical: heightSize(14),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: isSelected
                                                  ? sNavContainer.withOpacity(0.10)
                                                  : (isDark ? sDarkFill : const Color(0xFFF7F7F7)),
                                              border: Border.all(
                                                color: isSelected
                                                    ? sNavContainer.withOpacity(0.4)
                                                    : Colors.transparent,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CText(
                                                  text: f,
                                                  size: 14,
                                                  fontFamily: CFONT.FAMILY,
                                                  fontWeight: isSelected ? CFONT.wMedium : CFONT.wRegular,
                                                  color: isSelected
                                                      ? sNavContainer
                                                      : (isDark ? Colors.white : sActionButton),
                                                ),
                                                if (isSelected)
                                                  SvgPicture.asset(
                                                    tickLight,
                                                    width: widthSize(18),
                                                    height: heightSize(18),
                                                    colorFilter: const ColorFilter.mode(
                                                      sNavContainer, BlendMode.srcIn,
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
                                setState(() => _isFrequencyOpen = false);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              title: CText(
                                text: 'Amount per circle (N)',
                                size: 14,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wRegular,
                              ),
                              showNairaPrefix: true,
                              hasBottomMargin: false,
                              height: heightSize(55),
                              hint: '0.00',
                              controller: TextEditingController(),
                              inputType: TextInputType.number,
                              error: '',
                              validFunction: (_) => null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ── Original field ───────────────────────────────────────
            widgets.add(
              Padding(
                padding: EdgeInsets.only(bottom: heightSize(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (field.type != SavingsFieldType.info)
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize(6)),
                        child: CText(
                          text: field.type == SavingsFieldType.card
                              ? ''
                              : field.label,
                          size: 14,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wRegular,
                        ),
                      ),
                    _buildField(field, isDark),
                  ],
                ),
              ),
            );

            return widgets;
          }).toList(),
        ),

        SizedBox(height: heightSize(20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: _content(isDark),
            ),
          ),
          // ── Bottom CTA ─────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.savingsSummary);
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: heightSize(55),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sActionButton,
                    ),
                    child: Center(
                      child: CText(
                        text: 'Continue',
                        size: 16,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize(30)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Add these two classes at the bottom of savings_type.dart
// (after the closing brace of _SavingsTypeState)

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
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Drag handle ──────────────────────────────
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

          // ── Title ────────────────────────────────────
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