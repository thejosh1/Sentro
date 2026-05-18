import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/models/network.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

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
    NetworkModel(name: '9MOBILE', logo: etisalat,
    ),
  ];

  final List<PlanModel> plans = [
    PlanModel(
      name: "110MB Daily Plan",
      duration: 1,
      amount: 100,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 200,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 1000,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 1500,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 3500,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 4500,
    ),
    PlanModel(
      name: "230MB Daily Plan",
      duration: 1,
      amount: 5500,
    ),
  ];

  bool isSheetOpen = false;
  bool isPlanSheetOpen = false;
  TextEditingController dataController = TextEditingController();
  late TextEditingController dataPhoneController;
  TextEditingController airtimeController = TextEditingController();
  late TextEditingController airtimePhoneController;

  @override
  void initState() {
    super.initState();

    dataPhoneController = TextEditingController();
    airtimePhoneController = TextEditingController();

    selectedNetwork = networks.first;
    selectedPlan = null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return widget.isData?Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: 'Network',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                ),
                SizedBox(height: heightSize(10),),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isSheetOpen = true;
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
                                  child: CText(
                                    text: 'Select Network',
                                    fontFamily: CFONT.MEDIUM,
                                    fontWeight: FontWeight.w500,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(height: heightSize(33),),

                                ...networks.map((network) {
                                  final isSelected =
                                      selectedNetwork.name == network.name;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedNetwork = network;
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: AnimatedContainer(
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
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthSize(42),
                                            height: heightSize(42),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(network.logo),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: widthSize(15)),

                                          Expanded(
                                            child: CText(
                                              text: network.name,
                                              size: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: CFONT.REGULAR,
                                              height: 16.67/16,
                                            ),
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
                      isSheetOpen = false;
                    });
                  },
                  child: Container(
                    width: widthSize(115),
                    height: heightSize(58),
                    padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sDarkFill,
                      border: Border.all(color: sDarkBorder),
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

                        CText(
                          text: selectedNetwork.name,
                          size: 14,
                          fontFamily: CFONT.REGULAR,
                          fontWeight: FontWeight.w400,
                        ),

                        SizedBox(width: widthSize(3)),

                        AnimatedRotation(
                          turns: isSheetOpen ? 0.5 : 0,
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
            SizedBox(width: widthSize(14),),
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: 'Phone Number',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                  ),
                  SizedBox(height: heightSize(10),),
                  AppTextField(
                    height: heightSize(68),
                    hint: '09060000000',
                    hasBottomMargin: false,
                    controller: dataPhoneController,
                    inputType: TextInputType.phone,
                    error: '',
                    validFunction: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "Please input your phone number.";
                      }
                      return null;
                    },
                    suffixWidget: SvgPicture.asset(
                      addUser,
                      width: widthSize(24),
                      height: heightSize(24),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: heightSize(14),),
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
                              key: ValueKey(selectedPlan?.name ?? "empty"),
                              text: selectedPlan == null
                                  ? 'Select a plan'
                                  : '${selectedPlan!.name} (${selectedPlan!.duration} Day)',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                            ),
                          ),
                        ),
                        SizedBox(height: heightSize(33),),

                        ...plans.map((plan) {

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPlan = plan;
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
                                    text: plan.name,
                                    size: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: CFONT.REGULAR,
                                    height: 16.67 / 16,
                                  ),
                                  SizedBox(height: heightSize(10),),
                                  CText(
                                    text: 'N${plan.amount}',
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
                    key: ValueKey(selectedPlan?.name ?? "empty"),
                    text: selectedPlan == null
                        ? 'Select a plan'
                        : '${selectedPlan!.name} (${selectedPlan!.duration} Day) - N${selectedPlan!.amount}',
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
        SizedBox(height: heightSize(42),),
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
    ):
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: 'Network',
                  size: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: CFONT.REGULAR,
                ),
                SizedBox(height: heightSize(10),),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isSheetOpen = true;
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
                                  child: CText(
                                    text: 'Select Network',
                                    fontFamily: CFONT.MEDIUM,
                                    fontWeight: FontWeight.w500,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(height: heightSize(33),),

                                ...networks.map((network) {
                                  final isSelected =
                                      selectedNetwork.name == network.name;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedNetwork = network;
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: AnimatedContainer(
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
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthSize(42),
                                            height: heightSize(42),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(network.logo),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: widthSize(15)),

                                          Expanded(
                                            child: CText(
                                              text: network.name,
                                              size: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: CFONT.REGULAR,
                                              height: 16.67/16,
                                            ),
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
                      isSheetOpen = false;
                    });
                  },
                  child: Container(
                    width: widthSize(115),
                    height: heightSize(58),
                    padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: sDarkFill,
                      border: Border.all(color: sDarkBorder),
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

                        CText(
                          text: selectedNetwork.name,
                          size: 14,
                          fontFamily: CFONT.REGULAR,
                          fontWeight: FontWeight.w400,
                        ),

                        SizedBox(width: widthSize(3)),

                        AnimatedRotation(
                          turns: isSheetOpen ? 0.5 : 0,
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
            SizedBox(width: widthSize(14),),
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    text: 'Phone Number',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: CFONT.REGULAR,
                  ),
                  SizedBox(height: heightSize(10),),
                  AppTextField(
                    height: heightSize(68),
                    hint: '09060000000',
                    hasBottomMargin: false,
                    controller: airtimePhoneController,
                    inputType: TextInputType.phone,
                    error: '',
                    validFunction: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "Please input your phone number.";
                      }
                      return null;
                    },
                    suffixWidget: SvgPicture.asset(
                      addUser,
                      width: widthSize(24),
                      height: heightSize(24),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: heightSize(14),),
        AppTextField(
          showNairaPrefix: true,
          height: heightSize(68),
          hasBottomMargin: false,
          hint: '₦0.00',
          controller: airtimeController,
          inputType: TextInputType.number,
          error: '',
          validFunction: (value) {
            if (value == null || value
                .trim()
                .isEmpty) {
              return "Select an amount.";
            }
            return null;
          },
        ),
        SizedBox(height: heightSize(42),),
        ActionButton(
          text: 'Buy Airtime',
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
}
