import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/label_container.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/available_balance.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/biller_categories.dart';
import 'package:sentro/screen/main_view/Dashboard/views/widgets/investment_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _recentlyUsedExpanded = false;
  final _panelKey = GlobalKey<_RecentlyUsedPanelState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // ── Main scrollable content ──────────────────────────────
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: Column(
              children: [
                SizedBox(height: heightSize(62)),

                // ── Header row ─────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Avatar + greeting
                    Row(
                      children: [
                        Container(
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
                        SizedBox(width: widthSize(10)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: 'Hi, Richmond',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                              color: colorScheme.onSurface,
                            ),
                            Container(
                              width: widthSize(72.69),
                              height: heightSize(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(113.27),
                                // Light: warm surface tint; Dark: custom tier tint
                                color: isDark
                                    ? sTierColor
                                    : colorScheme.surface,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(goldMedal),
                                  SizedBox(width: widthSize(3)),
                                  CText(
                                    text: 'Tier 3',
                                    fontFamily: CFONT.REGULAR,
                                    fontWeight: FontWeight.w400,
                                    size: 15.88,
                                    color: colorScheme.onSurface,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Help + Notification
                    Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: widthSize(43.52),
                              height: heightSize(43.52),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surface,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  headPhone,
                                  width: widthSize(25.93),
                                  height: heightSize(25.93),
                                  colorFilter: ColorFilter.mode(
                                    colorScheme.onSurface,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: widthSize(36.11),
                                height: heightSize(13.89),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.93),
                                  // Light: primary green chip; Dark: white chip
                                  color: isDark
                                      ? Colors.white
                                      : colorScheme.primary,
                                ),
                                child: Center(
                                  child: CText(
                                    text: 'Help?',
                                    fontFamily: CFONT.BOLD,
                                    size: 7.41,
                                    fontWeight: FontWeight.w700,
                                    // Light: onPrimary lime; Dark: dark text
                                    color: isDark
                                        ? sCancel
                                        : colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: widthSize(8)),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: widthSize(39.17),
                              height: heightSize(39.17),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surface,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  notification,
                                  width: widthSize(23.33),
                                  height: heightSize(23.33),
                                  colorFilter: ColorFilter.mode(
                                    colorScheme.onSurface,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              left: 0,
                              right: -5,
                              child: Container(
                                width: widthSize(12.5),
                                height: heightSize(12.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: sBvnButton,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: heightSize(30)),
                const AvailableBalance(),
                const BillerCategories(),
                const InvestmentCategories(),
                // Space so content isn't hidden behind the panel
                SizedBox(height: heightSize(140)),
              ],
            ),
          ),

          // ── Blur overlay (tap to collapse) ───────────────────────
          if (_recentlyUsedExpanded)
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) =>
                    Opacity(opacity: value, child: child),
                child: GestureDetector(
                  onTap: () => _panelKey.currentState?.collapse(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black.withOpacity(
                        isDark ? 0.15 : 0.08,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // ── Floating Recently Used panel ─────────────────────────
          Positioned(
            bottom: 0,
            left: widthSize(5),
            right: widthSize(5),
            child: _RecentlyUsedPanel(
              key: _panelKey,
              isDark: isDark,
              colorScheme: colorScheme,
              onExpandedChanged: (val) {
                setState(() => _recentlyUsedExpanded = val);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recently Used Panel ────────────────────────────────────────────────────

class _RecentlyUsedPanel extends StatefulWidget {
  final bool isDark;
  final ColorScheme colorScheme;
  final ValueChanged<bool> onExpandedChanged;

  const _RecentlyUsedPanel({
    super.key,
    required this.isDark,
    required this.colorScheme,
    required this.onExpandedChanged,
  });

  @override
  State<_RecentlyUsedPanel> createState() => _RecentlyUsedPanelState();
}

class _RecentlyUsedPanelState extends State<_RecentlyUsedPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnim;
  late Animation<double> _turnAnim;
  late Animation<double> _fadeAnim;

  static const double _collapsedH = 100;
  static const double _expandedH = 228;

  void collapse() => _collapse();

  double _dragStartDy = 0;
  double _dragStartValue = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
    _dragStartDy = d.globalPosition.dy;
    _dragStartValue = _controller.value;
  }

  void _onDragUpdate(DragUpdateDetails d) {
    final delta = _dragStartDy - d.globalPosition.dy;
    final range = heightSize(_expandedH - _collapsedH);
    _controller.value =
        (_dragStartValue + delta / range).clamp(0.0, 1.0);
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

  // Panel background: surface in light, dark container in dark
  Color get _panelColor => widget.isDark
      ? sContainerColor
      : widget.colorScheme.surface;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return SizedBox(
            height: heightSize(_heightAnim.value),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ── Panel body ─────────────────────────────────────
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Values().buttonRadius11 + 1),
                      topRight: Radius.circular(Values().buttonRadius11 + 1),
                    ),
                    child: Container(
                      color: _panelColor,
                      padding: EdgeInsets.only(
                        top: heightSize(13.5),
                        left: widthSize(11),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Pill tab ───────────────────────────────────────
                Positioned(
                  left: 10,
                  top: -20,
                  child: GestureDetector(
                    onTap: _toggle,
                    onVerticalDragStart: _onDragStart,
                    onVerticalDragUpdate: _onDragUpdate,
                    onVerticalDragEnd: _onDragEnd,
                    child: Container(
                      width: widthSize(123),
                      height: heightSize(28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Values().buttonRadius11 + 1),
                          topRight:
                          Radius.circular(Values().buttonRadius11 + 1),
                        ),
                        color: _panelColor,
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
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
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

// ── Collapsed row ──────────────────────────────────────────────────────────

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
          iconWidth: widthSize(22.92),
          iconHeight: heightSize(22.92),
          iconContainerWidth: widthSize(46),
          iconContainerHeight: heightSize(46),
          title: 'Airtime',
          isDark: isDark,
          colorScheme: colorScheme,
          callback: () {
            showDialog(
              context: context,
              barrierDismissible: true,

              barrierColor: Colors.black.withOpacity(0.45),
              builder: (context) {
                bool isDataSelected = false;

                return StatefulBuilder(
                  builder: (context, setDialogState) {
                    return Dialog(
                      backgroundColor: isDark
                          ? sContainerColor
                          : Theme.of(context).scaffoldBackgroundColor,
                      insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                      child: Container(
                        height: heightSize(499),
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                        decoration: BoxDecoration(
                          color: isDark
                              ? sContainerColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: heightSize(15),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: widthSize(156.8),
                                  height: heightSize(31),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(113.27),
                                      color: sButtonFillDark,
                                      border: Border.all(color: sDarkBorder)
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        wallet,
                                        width: widthSize(24),
                                        height: heightSize(24),
                                      ),
                                      SizedBox(width: widthSize(3.4),),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '₦50,000',
                                              style: TextStyle(
                                                fontSize: 15.86,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: CFONT.REGULAR,
                                                height: 22.65 / 15.86,
                                              ),
                                            ),

                                            TextSpan(
                                              text: '.00',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: CFONT.REGULAR,
                                                height: 22.65 / 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        visibilityOff,
                                        width: widthSize(24),
                                        height: heightSize(24),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: widthSize(33.33),
                                  height: heightSize(33.33),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(cancelWhite),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: heightSize(13)),
                            CText(
                              text: 'Mobile Top up',
                              size: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: CFONT.MEDIUM,
                            ),
                            SizedBox(height: heightSize(13)),
                            CText(
                              text: 'Top up your Airtime and Data',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                            ),
                            SizedBox(height: heightSize(20)),
                            Container(
                              width: widthSize(214),
                              height: heightSize(55),
                              padding: EdgeInsets.symmetric(horizontal: widthSize(6)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: sDescriptionColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Airtime
                                  GestureDetector(
                                    onTap: () {
                                      setDialogState(() {
                                        isDataSelected = false;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      width: widthSize(100),
                                      height: heightSize(43),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: !isDataSelected
                                            ? sActiveColor
                                            : Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            mobileWhite,
                                            width: widthSize(16),
                                            height: heightSize(20),
                                            colorFilter: !isDataSelected
                                                ? null
                                                : ColorFilter.mode(
                                              Colors.white.withOpacity(0.7),
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          SizedBox(width: widthSize(8)),
                                          CText(
                                            text: 'Airtime',
                                            fontFamily: CFONT.REGULAR,
                                            fontWeight: FontWeight.w400,
                                            size: 14,
                                            color: !isDataSelected
                                                ? sNavContainer
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Data
                                  GestureDetector(
                                    onTap: () {
                                      setDialogState(() { // ← use setDialogState, not setState
                                        isDataSelected = true;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      width: widthSize(100),
                                      height: heightSize(43),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: isDataSelected
                                            ? sActiveColor
                                            : Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            data,
                                            width: widthSize(24),
                                            height: heightSize(24),
                                            colorFilter: ColorFilter.mode(
                                              isDataSelected
                                                  ? sNavContainer
                                                  : Colors.white.withOpacity(0.7),
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          SizedBox(width: widthSize(5)),
                                          CText(
                                            text: 'Data',
                                            fontWeight: FontWeight.w400,
                                            size: 14,
                                            color: isDataSelected
                                                ? sNavContainer
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: heightSize(40)),
                            LabelContainer(isData: isDataSelected,),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        investmentItem(
            assetName: data,
            iconContainerHeight: heightSize(46),
            iconContainerWidth: widthSize(46),
            iconHeight: heightSize(27.6),
            iconWidth: widthSize(21.58),
            title: 'Data',
            isDark: isDark,
            colorScheme: colorScheme,
            callback: () {
              showDialog(
                context: context,
                barrierDismissible: true,

                barrierColor: Colors.black.withOpacity(0.45),
                builder: (context) {
                  bool isDataSelected = true;

                  return StatefulBuilder(
                    builder: (context, setDialogState) {
                      return Dialog(
                        backgroundColor: isDark
                            ? sContainerColor
                            : Theme.of(context).scaffoldBackgroundColor,
                        insetPadding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                        child: Container(
                          height: heightSize(499),
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: widthSize(15)),
                          decoration: BoxDecoration(
                            color: isDark
                                ? sContainerColor
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: heightSize(15),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: widthSize(156.8),
                                    height: heightSize(31),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(113.27),
                                        color: sButtonFillDark,
                                        border: Border.all(color: sDarkBorder)
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          wallet,
                                          width: widthSize(24),
                                          height: heightSize(24),
                                        ),
                                        SizedBox(width: widthSize(3.4),),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₦50,000',
                                                style: TextStyle(
                                                  fontSize: 15.86,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: CFONT.REGULAR,
                                                  height: 22.65 / 15.86,
                                                ),
                                              ),

                                              TextSpan(
                                                text: '.00',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: CFONT.REGULAR,
                                                  height: 22.65 / 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          visibilityOff,
                                          width: widthSize(24),
                                          height: heightSize(24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: widthSize(33.33),
                                    height: heightSize(33.33),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(cancelWhite),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: heightSize(13)),
                              CText(
                                text: 'Mobile Top up',
                                size: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: CFONT.MEDIUM,
                              ),
                              SizedBox(height: heightSize(13)),
                              CText(
                                text: 'Top up your Airtime and Data',
                                size: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: CFONT.REGULAR,
                              ),
                              SizedBox(height: heightSize(20)),
                              Container(
                                width: widthSize(214),
                                height: heightSize(55),
                                padding: EdgeInsets.symmetric(horizontal: widthSize(6)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: sDescriptionColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Airtime
                                    GestureDetector(
                                      onTap: () {
                                        setDialogState(() {
                                          isDataSelected = false;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        width: widthSize(100),
                                        height: heightSize(43),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: !isDataSelected
                                              ? sActiveColor
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              mobileWhite,
                                              width: widthSize(16),
                                              height: heightSize(20),
                                              colorFilter: !isDataSelected
                                                  ? null
                                                  : ColorFilter.mode(
                                                Colors.white.withOpacity(0.7),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: widthSize(8)),
                                            CText(
                                              text: 'Airtime',
                                              fontFamily: CFONT.REGULAR,
                                              fontWeight: FontWeight.w400,
                                              size: 14,
                                              color: !isDataSelected
                                                  ? sNavContainer
                                                  : Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Data
                                    GestureDetector(
                                      onTap: () {
                                        setDialogState(() { // ← use setDialogState, not setState
                                          isDataSelected = true;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        width: widthSize(100),
                                        height: heightSize(43),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: isDataSelected
                                              ? sActiveColor
                                              : Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              data,
                                              width: widthSize(24),
                                              height: heightSize(24),
                                              colorFilter: ColorFilter.mode(
                                                isDataSelected
                                                    ? sNavContainer
                                                    : Colors.white.withOpacity(0.7),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: widthSize(5)),
                                            CText(
                                              text: 'Data',
                                              fontWeight: FontWeight.w400,
                                              size: 14,
                                              color: isDataSelected
                                                  ? sNavContainer
                                                  : Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: heightSize(40)),
                              LabelContainer(isData: isDataSelected,),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
        investmentItem(
            assetName: electricity,
            tintColor: Colors.white,
            iconContainerHeight: heightSize(46),
            iconContainerWidth: widthSize(46),
            iconHeight: heightSize(31.63),
            iconWidth: widthSize(31.63),
            title: 'Electricity',
            isDark: isDark,
            colorScheme: colorScheme,
            callback: () {}),
        investmentItem(
            assetName: gift,
            iconContainerHeight: heightSize(46),
            iconContainerWidth: widthSize(46),
            iconHeight: heightSize(27.6),
            iconWidth: widthSize(19.62),
            title: 'Gift Cards',
            isDark: isDark,
            colorScheme: colorScheme,
            callback: () {}),
        investmentItem(
            assetName: savings,
            iconContainerHeight: heightSize(46),
            iconContainerWidth: widthSize(46),
            iconHeight: heightSize(31.28),
            iconWidth: widthSize(31.28),
            tintColor: Colors.white,
            title: 'Save Money',
            isDark: isDark,
            colorScheme: colorScheme,
            callback: () {}),
        investmentItem(
            assetName: loansService,
            iconContainerHeight: heightSize(46),
            iconContainerWidth: widthSize(46),
            iconHeight: heightSize(31.28),
            iconWidth: widthSize(31.28),
            tintColor: Colors.white,
            title: 'Loans',
            isDark: isDark,
            colorScheme: colorScheme,
            callback: () {}),
      ],
    );
  }
}

// ── Expanded content ───────────────────────────────────────────────────────

class _ExpandedContent extends StatelessWidget {
  final bool isDark;
  final ColorScheme colorScheme;

  const _ExpandedContent({required this.isDark, required this.colorScheme});

  static const double _itemWidth = 68;

  Widget _item({
    required String assetName,
    required String title,
    required bool isDark,
    required ColorScheme colorScheme,
    double? iconWidth,
    double? iconHeight,
    double? iconContainerWidth,
    double? iconContainerHeight,
    Color? tintColor,

  }) {
    return SizedBox(
      width: widthSize(_itemWidth),
      child: investmentItem(
        assetName: assetName,
        title: title,
        isDark: isDark,
        colorScheme: colorScheme,
        callback: () {},
        iconWidth: iconWidth,
        iconHeight: iconHeight,
        iconContainerWidth: iconContainerWidth,
        iconContainerHeight: iconContainerHeight,
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
          fontFamily: CFONT.BOLD,
          fontWeight: FontWeight.w700,
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
                isDark: isDark,
                colorScheme: colorScheme,
              iconHeight: heightSize(22.92),
              iconWidth: widthSize(22.92),
              iconContainerHeight: heightSize(46),
              iconContainerWidth: heightSize(46)
            ),
            _item(
              assetName: data,
              title: 'Data',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(23.46),
              iconWidth: widthSize(30),
            ),
            _item(
              assetName: electricity,
              title: 'Electricity',
              isDark: isDark,
              tintColor: Colors.white,
              colorScheme: colorScheme,
              iconHeight: heightSize(34.38),
              iconWidth: widthSize(34.38),
            ),
            _item(
              assetName:
              gift,
              title: 'Gift Cards',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(30),
              iconWidth: widthSize(21.32),
            ),
            _item(
              assetName: loansService,
              title: 'Loans',
              isDark: isDark,
              iconHeight: heightSize(34),
              iconWidth: widthSize(34),
              tintColor: Colors.white,
              colorScheme: colorScheme,
            ),
          ],
        ),

        SizedBox(height: heightSize(15.01)),

        // Row 2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(
              assetName: savings,
              title: 'Savings',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(34),
              iconWidth: widthSize(34),
              tintColor: Colors.white,
            ),
            _item(
              assetName: invest,
              title: 'Save & Invest',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(20.7),
              iconWidth: widthSize(17.61),
            ),
            _item(
              assetName: card,
              title: 'Cards',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(36),
              iconWidth: widthSize(36),
            ),
            _item(
              assetName: qrPay,
              title: 'QR Pay',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(36),
              iconWidth: widthSize(36),
            ),
            _item(
              assetName: transfer,
              title: 'Transfer',
              isDark: isDark,
              colorScheme: colorScheme,
              iconHeight: heightSize(36),
              iconWidth: widthSize(36),
            ),
          ],
        ),
      ],
    );
  }
}

// ── investmentItem helper ──────────────────────────────────────────────────

Widget investmentItem({
  required String assetName,
  required String title,
  required bool isDark,
  required ColorScheme colorScheme,
  required VoidCallback callback,

  // OPTIONAL SIZES
  double? iconContainerHeight,
  double? iconContainerWidth,
  double? iconHeight,
  double? iconWidth,
  bool isNew = false,
  Color? tintColor,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    isDark: isDark,
    colorScheme: colorScheme,
    onTap: callback,

    // pass sizes
    iconContainerHeight: iconContainerHeight,
    iconContainerWidth: iconContainerWidth,
    iconHeight: iconHeight,
    iconWidth: iconWidth,
    isNew: isNew,
    tintColor: tintColor,
  );
}

// ── Animated item ──────────────────────────────────────────

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final bool isDark;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  // OPTIONAL SIZES
  final double? iconContainerHeight;
  final double? iconContainerWidth;
  final double? iconHeight;
  final double? iconWidth;
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
    this.iconHeight,
    this.iconWidth,
    this.isNew = false,
    this.tintColor,
  });

  @override
  State<_AnimatedCategoryItem> createState() =>
      _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<_AnimatedCategoryItem> {
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final iconBg = widget.isDark
        ? Colors.white.withOpacity(0.10)
        : widget.colorScheme.primary.withOpacity(0.12);

    final iconColor = widget.isDark
        ? Colors.white
        : widget.colorScheme.primary;

    final containerHeight = widget.iconContainerHeight ?? 46;
    final containerWidth  = widget.iconContainerWidth  ?? 46;
    final svgHeight       = widget.iconHeight          ?? 33.12;
    final svgWidth        = widget.iconWidth           ?? 33.12;

    return AnimatedScale(
      scale: _pressed ? 0.92 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _pressed ? 0.7 : 1.0,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _pressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ── icon container ─────────────────────────
                    Container(
                      height: heightSize(containerHeight),
                      width: widthSize(containerWidth),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(
                          Values().buttonRadius10 + 3,
                        ),
                      ),
                      child: SvgPicture.asset(
                        widget.assetName,
                        height: heightSize(svgHeight),
                        width: widthSize(svgWidth),
                        fit: BoxFit.contain,
                        colorFilter: widget.tintColor != null
                            ? ColorFilter.mode(widget.tintColor!, BlendMode.srcIn)
                            : null,
                      ),
                    ),

                    // ── "New!" badge ────────────────────────────
                    if (widget.isNew)
                      Positioned(
                        top: -6,
                        left: 5,
                        right: 5,
                        child: SvgPicture.asset(
                          newText,
                          width: widthSize(31.79),
                          height: heightSize(12.5),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: heightSize(5)),

              // ── title text ──────────────────────────────────
              CText(
                text: widget.title,
                size: 11.2,
                fontWeight: FontWeight.w400,
                fontFamily: CFONT.REGULAR,
                textAlign: TextAlign.center,
                color: widget.colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
