import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map;

    option = args["selected"];
    allOptions = List<SavingsOption>.from(args["all"]);
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
            child: CText(text: type.title),
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
                fontFamily: CFONT.REGULAR,
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

  Widget _buildField(SavingsField field) {
    switch (field.type) {
      case SavingsFieldType.text:
        return AppTextField(
          hasBottomMargin: false,
          height: heightSize(55),
          hint: field.hint ?? field.label,
          controller: TextEditingController(),
          inputType: TextInputType.text,
          error: '',
          validFunction: (_) => null,
        );

      case SavingsFieldType.amount:
        return AppTextField(
          showNairaPrefix: true,
          hasBottomMargin: false,
          height: heightSize(55),
          hint: field.hint ?? '₦0.00',
          controller: TextEditingController(),
          suffixWidth: 102,
          suffixWidget: Container(
            height: heightSize(25.86),
            padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(124.89), color: sContainerColor),
            child: Center(child: CText(text: 'Min: N10,000', size: 14, fontWeight: FontWeight.w400, fontFamily: CFONT.REGULAR)),
          ),
          inputType: TextInputType.number,
          error: '',
          validFunction: (_) => null,
        );

      case SavingsFieldType.dropdown:
        return GestureDetector(
          onTap: () async {
            // setState(() {
            //   isPlanSheetOpen = true;
            // });
            // await showModalBottomSheet(
            //   context: context,
            //   backgroundColor: Colors.transparent,
            //   isScrollControlled: true,
            //   constraints: BoxConstraints(
            //     minHeight: MediaQuery.of(context).size.height*0.75,
            //   ),
            //   builder: (_) {
            //     return TweenAnimationBuilder(
            //       duration: const Duration(milliseconds: 300),
            //       tween: Tween(begin: 0.0, end: 1.0),
            //       curve: Curves.easeOut,
            //       builder: (context, value, child) {
            //         return Transform.translate(
            //           offset: Offset(0, 100 * (1 - value)),
            //           child: Opacity(
            //             opacity: value,
            //             child: child,
            //           ),
            //         );
            //       },
            //       child: Container(
            //         padding: EdgeInsets.all(widthSize(20)),
            //         decoration: BoxDecoration(
            //           color: sModalColor,
            //           borderRadius: const BorderRadius.vertical(
            //             top: Radius.circular(24),
            //           ),
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Container(
            //               width: widthSize(44),
            //               height: heightSize(4),
            //               margin: EdgeInsets.only(bottom: heightSize(16)),
            //               decoration: BoxDecoration(
            //                 color: Colors.black,
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );

            // setState(() {
            //   isPlanSheetOpen = false;
            // });
          },
          child: Container(
            padding: EdgeInsets.only(left: widthSize(15), top: heightSize(20.5), right: widthSize(19), bottom: heightSize(20.5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Values().buttonRadius10,),
              color: sDarkFill,
              border: Border.all(color:sDarkBorder,),
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
                    text: field.hint??'',
                    size: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                  ),
                ),

                AnimatedRotation(
                  turns: 0,
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
        );

      case SavingsFieldType.info:
        final isEnabled = _getToggleValue(field);
        return Container(
          width: double.maxFinite,
          height: heightSize(93),
          padding: EdgeInsets.only(left: widthSize(10), top: heightSize(15),),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.17),
            color: sDarkFill,
            border: Border.all(color: sDarkBorder),
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
                    fontWeight: FontWeight.w500,
                    fontFamily: CFONT.MEDIUM,
                  ),
                  SizedBox(height: 6,),
                  SizedBox(
                    width: widthSize(263),
                    child: CText(
                      text: field.description??'',
                      size: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: CFONT.REGULAR,
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
                  duration: const Duration(milliseconds: 250),
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
                        duration: const Duration(milliseconds: 250),
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
          validFunction: (_) => null,
        );
      case SavingsFieldType.card:
        return Column(
          children: [
            SizedBox(height: heightSize(12.5)),

            Divider(color: sDarkBorder),

            SizedBox(height: heightSize(12.5)),

            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(15),
                vertical: heightSize(18),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.17),
                color: sDarkFill,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Card Title ─────────────────────────────
                  CText(
                    text: field.label,
                    size: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: CFONT.MEDIUM,
                    color: sNavContainer,
                  ),
                  SizedBox(height: heightSize(15),),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: item.label,
                            size: 13,
                            fontFamily: CFONT.REGULAR,
                            fontWeight: FontWeight.w400,
                            color: sGrey1,
                          ),

                          CText(
                            text: item.value,
                            size: 14,
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                            color: item.isColored==true?sNavContainer:Theme.of(context).colorScheme.onSurface,
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
                SvgPicture.asset(tickLight, width: widthSize(24), height: heightSize(24),),
                SizedBox(width: widthSize(2.5),),
                CText(text: 'Interest will be reinvested automatically at maturity', size: 14, fontFamily: CFONT.REGULAR, fontWeight: FontWeight.w400, color: sNavContainer,)
              ],
            )
          ],
        );
    }
  }

  Widget _content() {
    return Column(
      children: [
        SizedBox(height: heightSize(64)),

        Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(arrowBackWhite, width: widthSize(42), height: heightSize(42)),
            ),
            const Spacer(),
            _typeSelector(),
          ],
        ),

        SizedBox(height: heightSize(23.46)),

        CText(text: option.title, size: 20, fontFamily: CFONT.MEDIUM, fontWeight: FontWeight.w500),
        SizedBox(height: heightSize(2.76)),
        CText(text: option.description, size: 13, fontFamily: CFONT.REGULAR, color: sGrey1),

        SizedBox(height: heightSize(16)),

        // ── Interest rate chip ──────────────────────────────────
        if (option.interest != null)
          CText(
            text: '${option.interest}%',
            size: 12,
            fontFamily: CFONT.MEDIUM,
            fontWeight: FontWeight.w500,
            color: option.interestColor ?? sNavContainer,
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
                        padding: EdgeInsets.only(bottom: heightSize(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // setState(() {
                                //   isPlanSheetOpen = true;
                                // });
                                // await showModalBottomSheet(
                                //   context: context,
                                //   backgroundColor: Colors.transparent,
                                //   isScrollControlled: true,
                                //   constraints: BoxConstraints(
                                //     minHeight: MediaQuery.of(context).size.height*0.75,
                                //   ),
                                //   builder: (_) {
                                //     return TweenAnimationBuilder(
                                //       duration: const Duration(milliseconds: 300),
                                //       tween: Tween(begin: 0.0, end: 1.0),
                                //       curve: Curves.easeOut,
                                //       builder: (context, value, child) {
                                //         return Transform.translate(
                                //           offset: Offset(0, 100 * (1 - value)),
                                //           child: Opacity(
                                //             opacity: value,
                                //             child: child,
                                //           ),
                                //         );
                                //       },
                                //       child: Container(
                                //         padding: EdgeInsets.all(widthSize(20)),
                                //         decoration: BoxDecoration(
                                //           color: sModalColor,
                                //           borderRadius: const BorderRadius.vertical(
                                //             top: Radius.circular(24),
                                //           ),
                                //         ),
                                //         child: Column(
                                //           mainAxisSize: MainAxisSize.min,
                                //           children: [
                                //             Container(
                                //               width: widthSize(44),
                                //               height: heightSize(4),
                                //               margin: EdgeInsets.only(bottom: heightSize(16)),
                                //               decoration: BoxDecoration(
                                //                 color: Colors.black,
                                //                 borderRadius: BorderRadius.circular(8),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );

                                // setState(() {
                                //   isPlanSheetOpen = false;
                                // });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: widthSize(15), top: heightSize(20.5), right: widthSize(19), bottom: heightSize(20.5)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Values().buttonRadius10,),
                                  color: sDarkFill,
                                  border: Border.all(color:sDarkBorder,),
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
                                        text: 'Monthly (on the 1st)',
                                        size: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: CFONT.REGULAR,
                                      ),
                                    ),

                                    AnimatedRotation(
                                      turns: 0,
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
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              title: CText(
                                text: 'Amount per circle (N)',
                                size: 14,
                                fontFamily: CFONT.REGULAR,
                                fontWeight: FontWeight.w400,
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
                padding: EdgeInsets.only(bottom: heightSize(15)),
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
                          fontFamily: CFONT.REGULAR,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                    _buildField(field),
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: _content(),
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
                        fontFamily: CFONT.MEDIUM,
                        fontWeight: FontWeight.w500,
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