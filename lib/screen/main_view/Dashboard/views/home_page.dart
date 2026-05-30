import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/available_balance.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/biller_categories.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/home_widgets.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/investment_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _recentlyUsedExpanded = false;
  final _panelKey = GlobalKey<RecentlyUsedPanelState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // ── MAIN CONTENT ────────────────────────────────────
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
            child: Column(
              children: [
                SizedBox(height: heightSize(62)),

                // ── Header ──────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Avatar — opens profile sheet
                        GestureDetector(
                          onTap: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Profile',
                              barrierColor: Colors.transparent,
                              transitionDuration:
                              const Duration(milliseconds: 350),
                              pageBuilder: (ctx, anim1, anim2) {
                                return Stack(
                                  children: [
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 8,
                                        sigmaY: 8,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(ctx),
                                        child: Container(
                                          color: Colors.black.withOpacity(
                                            isDark ? 0.45 : 0.25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: anim1,
                                          curve: Curves.easeOutCubic,
                                        )),
                                        child: SafeArea(
                                          top: false,
                                          child: ProfileSheet(
                                            isDark: isDark,
                                            colorScheme: colorScheme,
                                            controller: controller,
                                            context: context,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: widthSize(50),
                            height: heightSize(50),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(avatar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: widthSize(10)),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Hi, Richmond',
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: colorScheme.onSurface,
                            ),
                            SizedBox(height: heightSize(2)),
                            GestureDetector(
                              onTap: () =>
                                  Get.toNamed(Routes.upgradeAccount),
                              child: Container(
                                width: widthSize(72),
                                height: heightSize(30),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(113),
                                  color: isDark
                                      ? sTierColor
                                      : colorScheme.surface,
                                  boxShadow: isDark
                                      ? null
                                      : [
                                    BoxShadow(
                                      color: colorScheme.primary
                                          .withOpacity(0.08),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(goldMedal),
                                    SizedBox(width: widthSize(3)),
                                    CText(
                                      text: 'Tier 3',
                                      size: 12,
                                      fontWeight: CFONT.wRegular,
                                      fontFamily: CFONT.FAMILY,
                                      color: colorScheme.onSurface,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Right icons — tinted for light mode
                    Row(
                      children: [
                        SvgPicture.asset(
                          isDark?headPhoneWhite:headPhone,
                        ),
                        SizedBox(width: widthSize(12)),
                        SvgPicture.asset(
                          notif,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: heightSize(30)),

                const AvailableBalance(),
                const BillerCategories(),
                const InvestmentCategories(),

                SizedBox(height: heightSize(140)),
              ],
            ),
          ),

          // ── Blur overlay when panel expanded ────────────────
          if (_recentlyUsedExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => _panelKey.currentState?.collapse(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withOpacity(
                      isDark ? 0.15 : 0.06,
                    ),
                  ),
                ),
              ),
            ),

          // ── Recently used panel ──────────────────────────────
          Positioned(
            bottom: 0,
            left: widthSize(5),
            right: widthSize(5),
            child: RecentlyUsedPanel(
              key: _panelKey,
              isDark: isDark,
              colorScheme: colorScheme,
              onExpandedChanged: (val) =>
                  setState(() => _recentlyUsedExpanded = val),
            ),
          ),
        ],
      ),
    );
  }
}