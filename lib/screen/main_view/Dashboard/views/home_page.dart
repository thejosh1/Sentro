import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
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

  void _toggleRecentlyUsed() {
    setState(() => _recentlyUsedExpanded = !_recentlyUsedExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          children: [
                            CText(
                              text: 'Hi, Richmond',
                              size: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: CFONT.REGULAR,
                            ),
                            Container(
                              width: widthSize(72.69),
                              height: heightSize(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(113.27),
                                color: isDark ? sTierColor : sResendCode,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(goldMedal),
                                  SizedBox(width: widthSize(3)),
                                  CText(
                                    text: 'Tier 3',
                                    fontFamily: CFONT.REGULAR,
                                    fontWeight: FontWeight.w400,
                                    size: 15.88,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                color: isDark
                                    ? sDarkFill
                                    : sNavContainer.withOpacity(0.25),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  headPhone,
                                  width: widthSize(25.93),
                                  height: heightSize(25.93),
                                  colorFilter: ColorFilter.mode(
                                    isDark ? Colors.white : Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -4,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: widthSize(36.11),
                                height: heightSize(13.89),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.93),
                                  color: isDark ? Colors.white : sNavContainer,
                                ),
                                child: Center(
                                  child: CText(
                                    text: 'Help?',
                                    fontFamily: CFONT.BOLD,
                                    size: 7.41,
                                    fontWeight: FontWeight.w700,
                                    color: sCancel,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: widthSize(39.17),
                              height: heightSize(39.17),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? sDarkFill
                                    : sNavContainer.withOpacity(0.25),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  notification,
                                  width: widthSize(23.33),
                                  height: heightSize(23.33),
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
                SizedBox(height: heightSize(40)),
                AvailableBalance(),
                BillerCategories(),
                SizedBox(height: heightSize(12.5)),
                InvestmentCategories(),
                // Space so content isn't hidden behind the panel
                SizedBox(height: heightSize(140)),
              ],
            ),
          ),

          // ── Blur overlay (tap outside to collapse) ───────────────
          // ── Blur overlay ─────────────────────────────────────────────
          if (_recentlyUsedExpanded)
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () => _panelKey.currentState?.collapse(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black.withOpacity(0.15),
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

// ── Recently Used Panel Widget ─────────────────────────────────────────────

class _RecentlyUsedPanel extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onExpandedChanged;

  const _RecentlyUsedPanel({
    super.key,
    required this.isDark,
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
  static const double _expandedH  = 228;

  void collapse() => _collapse();

  double _dragStartDy    = 0;
  double _dragStartValue = 0;
  bool   _isExpanded     = false;

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

  // ── Expand / Collapse ─────────────────────────────────────────

  void _expand() {
    _isExpanded = true;
    _controller.forward().whenComplete(() {
      widget.onExpandedChanged(true);   // ← notify AFTER animation finishes
    });
  }

  void _collapse() {
    _isExpanded = false;
    _controller.reverse().whenComplete(() {
      widget.onExpandedChanged(false);  // ← notify AFTER animation finishes
    });
  }


  void _toggle() => _isExpanded ? _collapse() : _expand();

  // ── Drag ──────────────────────────────────────────────────────

  void _onDragStart(DragStartDetails d) {
    _controller.stop();
    _dragStartDy    = d.globalPosition.dy;
    _dragStartValue = _controller.value;
  }

  void _onDragUpdate(DragUpdateDetails d) {
    final delta = _dragStartDy - d.globalPosition.dy; // positive = up
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

  // ── Build ─────────────────────────────────────────────────────

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

                // ── Panel body ─────────────────────────────────
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(Values().buttonRadius11 + 1),
                      topRight: Radius.circular(Values().buttonRadius11 + 1),
                    ),
                    child: Container(
                      color: widget.isDark ? sContainerColor : sContainer2,
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
                              child: _CollapsedRow(isDark: widget.isDark),
                            ),
                          ),
                          // Expanded content — fades in
                          Opacity(
                            opacity: _fadeAnim.value,
                            child: IgnorePointer(
                              ignoring: _controller.value < 0.7,
                              child: _ExpandedContent(isDark: widget.isDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Pill tab ───────────────────────────────────
                Positioned(
                  left: 10,
                  top: -20,
                  child: GestureDetector(
                    onTap: _toggle,
                    // also draggable from the pill
                    onVerticalDragStart:  _onDragStart,
                    onVerticalDragUpdate: _onDragUpdate,
                    onVerticalDragEnd:    _onDragEnd,
                    child: Container(
                      width:  widthSize(123),
                      height: heightSize(28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:  Radius.circular(Values().buttonRadius11 + 1),
                          topRight: Radius.circular(Values().buttonRadius11 + 1),
                        ),
                        color: widget.isDark ? sContainerColor : sContainer2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            turns: _turnAnim,
                            child: SvgPicture.asset(
                              arrowUp,
                              width:  widthSize(16),
                              height: heightSize(16),
                            ),
                          ),
                          SizedBox(width: widthSize(8)),
                          CText(
                            text: 'Recently used',
                            fontFamily: CFONT.MEDIUM,
                            fontWeight: FontWeight.w500,
                            size: 12,
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

// ── Collapsed row (shown when panel is closed) ─────────────────────────────

class _CollapsedRow extends StatelessWidget {
  final bool isDark;
  const _CollapsedRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        investmentItem(assetName: mobileWhite, title: 'Airtime', callback: () {}),
        investmentItem(assetName: globalSearch, title: 'Data', callback: () {}),
        investmentItem(assetName: electricityWhite, title: 'Electricity',callback: () {}),
        investmentItem(assetName: giftWhite,  title: 'Gift Cards', callback: () {}),
        investmentItem(assetName: keySquareWhite, title: 'Save Money', callback: () {}),
        investmentItem(assetName: discountCircleWhite, title: 'Loans', callback: () {}),
      ],
    );
  }
}

// ── Expanded panel content ─────────────────────────────────────────────────

class _ExpandedContent extends StatelessWidget {
  final bool isDark;

  const _ExpandedContent({required this.isDark});

  // fixed slot width so both rows align column-by-column
  static const double _itemWidth = 52;

  Widget _item({required String assetName, required String title}) {
    return SizedBox(
      width: widthSize(_itemWidth),
      child: investmentItem(
        assetName: assetName,
        title: title,
        callback: () {},
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
        ),
        SizedBox(height: heightSize(17)),

        // Row 1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(assetName: mobileWhite,        title: 'Airtime'),
            _item(assetName: globalSearch,        title: 'Data'),
            _item(assetName: electricityWhite,    title: 'Electricity'),
            _item(assetName: giftWhite,           title: 'Gift Cards'),
            _item(assetName: discountCircleWhite, title: 'Loans'),
          ],
        ),

        SizedBox(height: heightSize(15.01)),

        // Row 2 — same 5 slots, aligns under row 1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _item(assetName: invest,              title: 'Save & Invest'),
            _item(assetName: discountCircleWhite, title: 'Loans'),
            _item(assetName: card,                title: 'Cards'),
            _item(assetName: qrPay,               title: 'QR Pay'),
            _item(assetName: transfer,            title: 'Transfer'),
          ],
        ),
      ],
    );
  }
}

Widget investmentItem({
  required String assetName,
  required String title,
  required VoidCallback callback,
}) {
  return _AnimatedCategoryItem(
    assetName: assetName,
    title: title,
    onTap: callback,
  );
}

class _AnimatedCategoryItem extends StatefulWidget {
  final String assetName;
  final String title;
  final VoidCallback onTap;

  const _AnimatedCategoryItem({
    required this.assetName,
    required this.title,
    required this.onTap,
  });

  @override
  State<_AnimatedCategoryItem> createState() => _AnimatedCategoryItemState();
}

class _AnimatedCategoryItemState extends State<_AnimatedCategoryItem> {
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _pressed ? 0.9 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  height: heightSize(46),
                  width: widthSize(46),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      Colors.white.red,
                      Colors.white.green,
                      Colors.white.blue,
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(Values().buttonRadius20),
                  ),
                  child: SvgPicture.asset(
                    widget.assetName,
                    height: heightSize(33.12),
                    width: widthSize(33.12),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: heightSize(5)),
              CText(
                text: widget.title,
                size: 11.2,
                fontWeight: FontWeight.w400,
                fontFamily: CFONT.REGULAR,
                textAlign: TextAlign.center,   // ← add this so 2-line text centers under icon
              ),
            ],
          ),
        ),
      ),
    );
  }
}
