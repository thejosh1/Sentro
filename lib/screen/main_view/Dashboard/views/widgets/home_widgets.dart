import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/appearance_toggle.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/loan_dialog.dart';
import 'package:sentro/core/widgets/top_up.dart';
import 'package:sentro/screen/main_view/controller/main_controller.dart';
import '../../../../../core/router/app_pages.dart';

// ── Recently Used Panel ───────────────────────────────────────────────────────

class RecentlyUsedPanel extends StatefulWidget {
  final bool isDark;
  final ColorScheme colorScheme;
  final ValueChanged<bool> onExpandedChanged;

  const RecentlyUsedPanel({
    super.key,
    required this.isDark,
    required this.colorScheme,
    required this.onExpandedChanged,
  });

  @override
  State<RecentlyUsedPanel> createState() => RecentlyUsedPanelState();
}

class RecentlyUsedPanelState extends State<RecentlyUsedPanel>
    with SingleTickerProviderStateMixin {
  final MainController controller = Get.put(MainController());
  late AnimationController _controller;
  late Animation<double> _heightAnim;
  late Animation<double> _turnAnim;
  late Animation<double> _fadeAnim;

  static const double _collapsedH = 100;
  static const double _expandedH  = 228;

  double _dragStartDy    = 0;
  double _dragStartValue = 0;
  bool _isExpanded       = false;

  void collapse() => _collapse();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _heightAnim = Tween<double>(begin: _collapsedH, end: _expandedH).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _turnAnim = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _expand() {
    _isExpanded = true;
    _controller.forward().whenComplete(() => widget.onExpandedChanged(true));
  }

  void _collapse() {
    _isExpanded = false;
    _controller.reverse().whenComplete(() => widget.onExpandedChanged(false));
  }

  void _toggle() => _isExpanded ? _collapse() : _expand();

  void _onDragStart(DragStartDetails d) {
    _controller.stop();
    _dragStartDy    = d.globalPosition.dy;
    _dragStartValue = _controller.value;
  }

  void _onDragUpdate(DragUpdateDetails d) {
    final delta = _dragStartDy - d.globalPosition.dy;
    final range = heightSize(_expandedH - _collapsedH);
    _controller.value = (_dragStartValue + delta / range).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails d) {
    final v = d.primaryVelocity ?? 0;
    if (v < -500) {
      _expand();
    } else if (v > 500) {
      _collapse();
    } else {
      _controller.value >= 0.5 ? _expand() : _collapse();
    }
  }

  Color get _panelColor => widget.isDark
      ? sContainerColor
      : sLightFill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart:  _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd:    _onDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SizedBox(
            height: heightSize(_heightAnim.value),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ── Panel body ───────────────────────────────
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(Values().buttonRadius11 + 1),
                      topRight: Radius.circular(Values().buttonRadius11 + 1),
                    ),
                    child: Container(
                      color: _panelColor,
                      padding: EdgeInsets.only(
                        top:   heightSize(13.5),
                        left:  widthSize(11),
                        right: widthSize(11),
                      ),
                      child: Stack(
                        children: [
                          // Collapsed row — fades out
                          Opacity(
                            opacity: (1.0 - _fadeAnim.value).clamp(0.0, 1.0),
                            child: IgnorePointer(
                              ignoring: _controller.value > 0.3,
                              child: _CollapsedRow(
                                isDark: widget.isDark,
                                colorScheme: widget.colorScheme,
                              ),
                            ),
                          ),
                          // Expanded content — fades in
                          Opacity(
                            opacity: _fadeAnim.value,
                            child: IgnorePointer(
                              ignoring: _controller.value < 0.7,
                              child: _ExpandedContent(
                                isDark: widget.isDark,
                                colorScheme: widget.colorScheme,
                                controller: controller,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Pill tab ─────────────────────────────────
                Positioned(
                  left: 10,
                  top: -20,
                  child: InkWell(
                    onTap: _toggle,
                    child: Container(
                      width: widthSize(123),
                      height: heightSize(28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:  Radius.circular(Values().buttonRadius11 + 1),
                          topRight: Radius.circular(Values().buttonRadius11 + 1),
                        ),
                        color: _panelColor,
                        boxShadow: widget.isDark
                            ? null
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            turns: _turnAnim,
                            child: SvgPicture.asset(
                              arrowUp,
                              width: widthSize(16),
                              height: heightSize(16),
                              colorFilter: ColorFilter.mode(
                                widget.colorScheme.onSurface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize(8)),
                          CText(
                            text: 'Recently used',
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            size: 12,
                            color: widget.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Profile sheet ─────────────────────────────────────────────────────────────

class ProfileSheet extends StatelessWidget {
  final MainController controller;
  final bool isDark;
  final ColorScheme colorScheme;
  final BuildContext context;

  const ProfileSheet({
    required this.isDark,
    required this.colorScheme,
    required this.context,
    required this.controller,
  });

  // ── Derived colors ──────────────────────────────────────────────────────────

  Color get _panelColor =>
      isDark ? sServicesColor : colorScheme.surface;

  Color get _cardBg =>
      isDark ? sDarkFill : const Color(0xFFF5F5F5);

  Color get _accountPillBg =>
      isDark ? sBeneficiaryColor : const Color(0xFFEEEEEE);

  // ── Helpers ─────────────────────────────────────────────────────────────────

  Widget _row(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children
          .map((child) => Expanded(child: Center(child: child)))
          .toList(),
    );
  }

  Widget _item({
    required String assetName,
    required String title,
    required Function callback,
    bool isNew = false,
    Color? tintColor,
  }) {
    return investmentItem(
      assetName: assetName,
      iconContainerHeight: heightSize(50),
      iconContainerWidth:  widthSize(50),
      title: title,
      isDark: isDark,
      colorScheme: colorScheme,
      callback: () => callback(),
      isNew: isNew,
      tintColor: tintColor,
    );
  }

  void _goTo(String route) {
    Get.back();
    Future.delayed(
      const Duration(milliseconds: 150),
          () => Get.toNamed(route),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: widthSize(5)),
        decoration: BoxDecoration(
          color: _panelColor,
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(Values().buttonRadius20),
            topRight: Radius.circular(Values().buttonRadius20),
          ),
          boxShadow: isDark
              ? null
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top:    heightSize(16),
                left:   widthSize(20),
                right:  widthSize(20),
                bottom: heightSize(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Avatar + name + account row ────────────
                  Row(
                    children: [
                      Container(
                        width:  widthSize(50),
                        height: heightSize(50),
                        margin: EdgeInsets.only(left: widthSize(3)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(avatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: widthSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Richmond Uche',
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            size: 14,
                            color: colorScheme.onSurface,
                          ),
                          SizedBox(height: heightSize(4)),
                          Container(
                            height: heightSize(28.67),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(83.34),
                              color: _accountPillBg,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: widthSize(10)),
                                Container(
                                  width:  widthSize(14.67),
                                  height: heightSize(14.67),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(nigeria),
                                ),
                                SizedBox(width: widthSize(3)),
                                SvgPicture.asset(
                                  arrowDown,
                                  width:  widthSize(20),
                                  height: heightSize(20),
                                  colorFilter: ColorFilter.mode(
                                    colorScheme.onSurface,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: widthSize(10)),
                                CText(
                                  text: 'Kuda MFB - 9060007015',
                                  size: 11.67,
                                  fontWeight: CFONT.wRegular,
                                  fontFamily: CFONT.FAMILY,
                                  color: colorScheme.onSurface
                                      .withOpacity(0.65),
                                ),
                                SizedBox(width: widthSize(17.83)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: heightSize(22)),

                  // ── Upgrade card ───────────────────────────
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widthSize(22),
                      vertical:   heightSize(14),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _cardBg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CText(
                                text: 'Complete verification to access more',
                                size: 13,
                                fontWeight: CFONT.wRegular,
                                fontFamily: CFONT.FAMILY,
                                color: colorScheme.onSurface.withOpacity(0.8),
                                height: 16.67 / 13,
                              ),
                            ),
                            SizedBox(width: widthSize(8)),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  goldMedal,
                                  width:  widthSize(14.3),
                                  height: heightSize(20),
                                ),
                                SizedBox(width: widthSize(4)),
                                CText(
                                  text: 'Tier 2',
                                  size: 16,
                                  fontWeight: CFONT.wMedium,
                                  fontFamily: CFONT.FAMILY,
                                  color: colorScheme.onSurface,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10)),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 0.65),
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: heightSize(8),
                                backgroundColor:
                                isDark?sNavContainer.withOpacity(0.2):sActionButton.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation(
                                  isDark?sNavContainer:sActionButton,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: heightSize(12)),
                        Center(
                          child: GestureDetector(
                            onTap: () => _goTo(Routes.upgradeAccount),
                            child: CText(
                              text: 'Upgrade Account',
                              size: 14,
                              fontFamily: CFONT.FAMILY,
                              fontWeight: CFONT.wRegular,
                              color: isDark?sNavContainer:sActionButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(28)),

                  // ── Options row 1 ──────────────────────────
                  _row([
                    _item(
                      assetName: profile,
                      title: 'Profile',
                      callback: () => _goTo(Routes.profilePage),
                    ),
                    _item(
                      assetName: security,
                      title: 'Security',
                      callback: () => _goTo(Routes.security),
                    ),
                    _item(
                      assetName: verification,
                      title: 'Verification',
                      callback: () => _goTo(Routes.verification),
                    ),
                    _item(
                      assetName: transactions,
                      title: 'Transactions',
                      callback: () => _goTo(Routes.transactionHistory),
                    ),
                    _item(
                      assetName: beneficiary,
                      title: 'Beneficiaries',
                      callback: () => _goTo(Routes.beneficiaries),
                    ),
                  ]),

                  SizedBox(height: heightSize(15)),

                  // ── Options row 2 ──────────────────────────
                  _row([
                    _item(
                      assetName: statement,
                      title: 'Account Statements',
                      callback: () => _goTo(Routes.accountStatements),
                    ),
                    _item(
                      assetName: limits,
                      title: 'Account Limits',
                      callback: () => _goTo(Routes.accountLimit),
                    ),
                    _item(
                      assetName: support,
                      title: 'Customer Service',
                      callback: () {},
                    ),
                    _item(
                      assetName: terms,
                      title: 'Terms & Conditions',
                      callback: () => _goTo(Routes.terms),
                    ),
                    _item(
                      assetName: notificationSettings,
                      title: 'Notification Settings',
                      callback: () => _goTo(Routes.notification),
                    ),
                  ]),

                  SizedBox(height: heightSize(26)),

                  // ── Appearance toggle ──────────────────────
                  const AppearanceToggle(),

                  SizedBox(height: heightSize(26)),

                  // ── Log out ────────────────────────────────
                  GestureDetector(
                    onTap: () => Get.offAllNamed(Routes.continuosLogin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          logout,
                          width:  widthSize(24),
                          height: heightSize(24),
                          colorFilter: const ColorFilter.mode(
                            sLogout,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: widthSize(6)),
                        CText(
                          text: 'Log Out',
                          size: 18,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wRegular,
                          color: sLogout,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(29)),
                ],
              ),
            ),

            // ── Header pill ────────────────────────────────
            Positioned(
              top: -23,
              left: 20,
              child: Container(
                width:  widthSize(141),
                height: heightSize(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(Values().buttonRadius10 + 2),
                    topRight: Radius.circular(Values().buttonRadius10 + 2),
                  ),
                  color: _panelColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      setting,
                      width:  widthSize(24),
                      height: heightSize(24),
                      colorFilter: ColorFilter.mode(
                        colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: widthSize(8)),
                    CText(
                      text: 'Profile & Settings',
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
      ),
    );
  }
}

// ── Collapsed row ─────────────────────────────────────────────────────────────

class _CollapsedRow extends StatelessWidget {
  final bool isDark;
  final ColorScheme colorScheme;

  const _CollapsedRow({required this.isDark, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        investmentItem(
          assetName: mobileWhite,
          iconContainerWidth:  widthSize(46),
          iconContainerHeight: heightSize(46),
          title: 'Airtime',
          isDark: isDark,
          colorScheme: colorScheme,

          callback: () =>
              showMobileTopupDialog(context: context, isDark: isDark),
        ),
        investmentItem(
          assetName: data,
          iconContainerHeight: heightSize(46),
          iconContainerWidth:  widthSize(46),
          tintColor: isDark?Colors.white:sActionButton,
          title: 'Data',
          isDark: isDark,

          colorScheme: colorScheme,
          callback: () => showMobileTopupDialog(
            context: context,
            isDark: isDark,
            initialDataSelected: true,
          ),
        ),
        investmentItem(
          assetName: electricity,
          iconContainerHeight: heightSize(46),
          iconContainerWidth:  widthSize(46),

          title: 'Electricity',
          isDark: isDark,
          colorScheme: colorScheme,
          tintColor: isDark?Colors.white:sActionButton,
          callback: () => Get.toNamed(Routes.electricity),
        ),
        investmentItem(
          assetName: gift,
          iconContainerHeight: heightSize(46),
          iconContainerWidth:  widthSize(46),

          title: 'Gift Cards',
          isDark: isDark,
          colorScheme: colorScheme,
          callback: () {},
        ),
        investmentItem(
          assetName: savingsWhite,
          iconContainerHeight: heightSize(46),
          iconContainerWidth:  widthSize(46),

          title: 'Save Money',
          isDark: isDark,
          colorScheme: colorScheme,
          callback: () => Get.toNamed(Routes.startSaving),
        ),
        investmentItem(
          assetName: loansService,
          iconContainerHeight: heightSize(46),
          iconContainerWidth:  widthSize(46),
          tintColor: isDark?Colors.white:sActionButton,
          title: 'Loans',
          isDark: isDark,
          colorScheme: colorScheme,

          callback: () =>
              showLoanDialog(context: context, isDark: isDark),
        ),
      ],
    );
  }
}

// ── Expanded content ──────────────────────────────────────────────────────────

class _ExpandedContent extends StatelessWidget {
  final bool isDark;
  final ColorScheme colorScheme;
  final MainController controller;

  const _ExpandedContent({
    required this.isDark,
    required this.colorScheme,
    required this.controller,
  });

  Widget _item({
    required String assetName,
    required String title,
    double? iconW,
    double? iconH,
    Color? tintColor,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: widthSize(68),
      child: investmentItem(
        assetName: assetName,
        title: title,
        isDark: isDark,
        colorScheme: colorScheme,
        callback: onTap ?? () {},
        iconContainerWidth:  iconW ?? heightSize(46),
        iconContainerHeight: iconH ?? heightSize(46),
        tintColor: tintColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CText(
          text: 'Recently Used',
          fontFamily: CFONT.FAMILY,
          fontWeight: CFONT.wBold,
          size: 16,
          color: colorScheme.onSurface,
        ),
        SizedBox(height: heightSize(17)),

        // Row 1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(
              assetName: mobileWhite,
              title: 'Airtime',

              onTap: () =>
                  showMobileTopupDialog(context: context, isDark: isDark),
            ),
            _item(
              assetName: data,

              title: 'Data',
              onTap: () => showMobileTopupDialog(
                context: context,
                isDark: isDark,
                initialDataSelected: true,
              ),
            ),
            _item(
              assetName: electricity,
              title: 'Electricity',
              tintColor: isDark?Colors.white:sActionButton,
              onTap: () => Get.toNamed(Routes.electricity),
            ),
            _item(assetName: gift, title: 'Gift Cards', ),
            _item(
              assetName: loansService,
              title: 'Loans',
              tintColor: isDark?Colors.white:sActionButton,
              onTap: () =>
                  showLoanDialog(context: context, isDark: isDark),
            ),
          ],
        ),

        SizedBox(height: heightSize(15)),

        // Row 2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(
              assetName: savingsWhite,

              title: 'Savings',
              onTap: () => Get.toNamed(Routes.activeGoals),
            ),
            _item(
              assetName: invest,
              title: 'Save & Invest',

              onTap: () => Get.toNamed(Routes.activeGoals),
            ),
            _item(assetName: cardWhite, title: 'Cards'),
            _item(
              assetName: qrPayWhite,

              title: 'QR Pay',
              onTap: () => Get.toNamed(Routes.qrPay),
            ),
            _item(assetName: transfer, title: 'Transfer'),
          ],
        ),
      ],
    );
  }
}

// ── investmentItem ────────────────────────────────────────────────────────────

Widget investmentItem({
  required String assetName,
  required String title,
  required bool isDark,
  required ColorScheme colorScheme,
  required VoidCallback callback,
  double? iconContainerHeight,
  double? iconContainerWidth,
  bool isNew = false,
  Color? tintColor,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    isDark: isDark,
    colorScheme: colorScheme,
    onTap: callback,
    iconContainerHeight: iconContainerHeight,
    iconContainerWidth:  iconContainerWidth,
    isNew: isNew,
    tintColor: tintColor,
  );
}

// ── Animated category item ────────────────────────────────────────────────────

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final bool isDark;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final double? iconContainerHeight;
  final double? iconContainerWidth;
  final bool isNew;
  final Color? tintColor;

  const _AnimatedCategoryItem({
    super.key,
    required this.assetName,
    required this.title,
    required this.isDark,
    required this.colorScheme,
    required this.onTap,
    this.iconContainerHeight,
    this.iconContainerWidth,
    this.isNew = false,
    this.tintColor,
  });

  @override
  State<_AnimatedCategoryItem> createState() => _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<_AnimatedCategoryItem> {
  bool _pressed = false;

  void _onTapDown(_)  => setState(() => _pressed = true);
  void _onTapUp(_)    => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final h = widget.iconContainerHeight ?? heightSize(46);
    final w = widget.iconContainerWidth  ?? widthSize(46);

    // In light mode, tint icons with the primary color when no explicit tint
    final tint = widget.tintColor ??
        (widget.isDark ? null : widget.colorScheme.primary);

    return AnimatedScale(
      scale:    _pressed ? 0.92 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve:    Curves.easeOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity:  _pressed ? 0.7 : 1.0,
        child: GestureDetector(
          onTap:       widget.onTap,
          onTapDown:   _onTapDown,
          onTapUp:     _onTapUp,
          onTapCancel: _onTapCancel,
          child: Column(
            mainAxisSize:      MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale:    _pressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      widget.assetName,
                      height: h,
                      width:  w,
                      fit:    BoxFit.contain,
                      colorFilter: tint != null
                          ? ColorFilter.mode(tint, BlendMode.srcIn)
                          : null,
                    ),
                    if (widget.isNew)
                      Positioned(
                        top:   -6,
                        left:  5,
                        right: 5,
                        child: SvgPicture.asset(
                          newText,
                          width:  widthSize(31.79),
                          height: heightSize(12.5),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text:       widget.title,
                size:       11.2,
                fontWeight: FontWeight.w400,
                fontFamily: CFONT.FAMILY,
                textAlign:  TextAlign.center,
                color:      widget.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}