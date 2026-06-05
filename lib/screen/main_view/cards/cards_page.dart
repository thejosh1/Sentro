import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

import '../../../core/constants/enums.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

enum CardNetwork { verve, visa }

class _CardData {
  final String name;
  final String image;
  final CardNetwork network;

  const _CardData({
    required this.name,
    required this.image,
    required this.network,
  });
}

final _cards = [
  _CardData(name: 'Goku', image: cardGoku, network: CardNetwork.visa),
  _CardData(name: 'Floral', image: cardFloral, network: CardNetwork.visa),
  _CardData(name: 'John Wick', image: cardJohnWick, network: CardNetwork.visa),
  _CardData(
      name: 'John Wick II', image: cardJohnWick2, network: CardNetwork.visa),
  _CardData(name: 'Iron Man', image: cardIronMan, network: CardNetwork.visa),
  _CardData(
      name: 'Wonder Woman', image: cardWonderWoman, network: CardNetwork.visa),
  _CardData(name: 'Cat Woman', image: cardCatWoman, network: CardNetwork.visa),
  _CardData(name: 'Batman', image: cardBatman, network: CardNetwork.visa),
];

// ─────────────────────────────────────────────────────────────────────────────
// Entry point — switches between picker and dashboard
// ─────────────────────────────────────────────────────────────────────────────

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  bool _hasCard = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['cardCreated'] == true) {
      _hasCard = true;
      args['cardCreated'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasCard) {
      return _CardPickerScreen(
        onBack: () => setState(() => _hasCard = true),
      );
    }
    return _CardDashboardScreen(
      card: _cards.first,
      onNewCard: () => setState(() => _hasCard = false),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen A — Card picker (no card yet)
// ─────────────────────────────────────────────────────────────────────────────

class _CardPickerScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const _CardPickerScreen({super.key, this.onBack});

  @override
  State<_CardPickerScreen> createState() => _CardPickerScreenState();
}

class _CardPickerScreenState extends State<_CardPickerScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  bool get _isLastCard => _currentIndex == _cards.length - 1;

  bool _isDefaultAccent(Color c) =>
      c.value == AccentController.options.first.value;

  @override
  void initState() {
    super.initState();
    _scrollToArrow();
    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      if (page.round() != _currentIndex) {
        setState(() => _currentIndex = page.round());
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _CardData get _current => _cards[_currentIndex];

  void _next() {
    if (_isLastCard) {
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic);
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic);
    }
  }

  void _scrollToArrow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          final accent = AccentController.to.accent.value;
          final useAccent = !_isDefaultAccent(accent);
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: heightSize(100)),
            child: Column(
              children: [
                SizedBox(height: heightSize(24)),
                // Contextual header to support backing out of the picker interface back to active card view
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (widget.onBack != null)
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                              onTap: widget.onBack,
                              child: SvgPicture.asset(
                                isDark ? arrowBackWhite : arrowBack,
                                width: widthSize(42),
                                height: heightSize(42),
                                colorFilter: useAccent ? ColorFilter.mode(
                                    accent, BlendMode.srcIn) : null,)
                          ),
                        ),
                      Center(
                        child: SvgPicture.asset(logoCard,
                            width: widthSize(124.7), height: heightSize(37.59)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(23.87)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) =>
                      FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                              begin: const Offset(0, 0.06), end: Offset.zero)
                              .animate(anim),
                          child: child,
                        ),
                      ),
                  child: Column(
                    key: ValueKey(_currentIndex),
                    children: [
                      CText(
                        text: _current.name,
                        size: 22,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                      ),
                      SizedBox(height: heightSize(5)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: widthSize(42)),
                        child: CText(
                          text:
                          'Express yourself with cards that inspires your personality, find one that feels like you have arrived',
                          size: 14,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wRegular,
                          color: isDark ? sConfirmTextColor : sLightModeMutedText,
                          textAlign: TextAlign.center,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(24)),
                _NetworkTab(
                  isDark: isDark,
                  useAccent:useAccent,
                  accent: accent,
                  selected: _current.network,
                  onChanged: (network) {
                    final index = _cards.indexWhere((c) => c.network == network);
                    if (index != -1) {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic);
                    }
                  },
                ),
                SizedBox(height: heightSize(24)),
                SizedBox(
                  height: heightSize(463.89),
                  width: widthSize(464),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _cards.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: widthSize(
                            21.5)),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.virtualCard, arguments: {
                              'name': _cards[index].name,
                              'image': _cards[index].image,
                              'network': _cards[index].network,
                            });
                          },
                          child: _CardTile(card: _cards[index]),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: heightSize(24.61)),
                GestureDetector(
                  onTap: _next,
                  child: Obx(() {
                    final accent = AccentController.to.accent.value;
                    final useAccent = !_isDefaultAccent(accent);
                    return AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      turns: _isLastCard ? 0.5 : 0,
                      child: SvgPicture.asset(
                        arrowLeft,
                        width: widthSize(70),
                        height: heightSize(70),
                        colorFilter: useAccent
                            ? ColorFilter.mode(accent, BlendMode.srcIn)
                            : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen B — Card dashboard (card already created)
// ─────────────────────────────────────────────────────────────────────────────

class _CardDashboardScreen extends StatefulWidget {
  final _CardData card;
  final VoidCallback onNewCard;

  const _CardDashboardScreen({
    super.key,
    required this.card,
    required this.onNewCard,
  });

  @override
  State<_CardDashboardScreen> createState() => _CardDashboardScreenState();
}

class _CardDashboardScreenState extends State<_CardDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipCtrl;
  late Animation<double> _flipAnim;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isFlipped) {
      _flipCtrl.reverse();
    } else {
      _flipCtrl.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF000000),
                const Color(0xFF737373).withOpacity(0.0),
              ],
              stops: const [0.0, 0.85],
            ),
          ),
          child: SafeArea(
            bottom: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: heightSize(31)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heightSize(16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            // Triggers view transition state switch
                            child: Container(
                              height: heightSize(36),
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthSize(14)),
                              decoration: BoxDecoration(
                                color: isDark ? sDarkFill : sLightFill,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  CText(
                                    text: 'New Card',
                                    size: 14,
                                    fontFamily: CFONT.FAMILY,
                                    fontWeight: CFONT.wMedium,
                                  ),
                                  SizedBox(width: widthSize(6)),
                                  Icon(Icons.add_rounded,
                                      size: 18,
                                      color: isDark ? Colors.white : Colors
                                          .black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: heightSize(18)),
                    Center(
                      child: SvgPicture.asset(logoCard,
                          width: widthSize(124.7), height: heightSize(37.59)),
                    ),
                    SizedBox(height: heightSize(20)),

                    // ── Flippable card ───────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                      child: GestureDetector(
                        onTap: _flip,
                        child: AnimatedBuilder(
                          animation: _flipAnim,
                          builder: (context, child) {
                            final showBack = _flipAnim.value >= 0.5;
                            final angle = _flipAnim.value * math.pi;

                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(angle),
                              child: showBack
                                  ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(math.pi),
                                child: _CardBack(
                                  onFlip: _flip,
                                ),
                              )
                                  : _CardFront(
                                card: widget.card,
                                onFlip: _flip,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: heightSize(24)),

                    // ── Quick actions ────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: widthSize(12),
                            vertical: heightSize(16)),
                        decoration: BoxDecoration(
                          color: isDark ? sDarkBorder : sLightFill,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.transactionAction,
                                  arguments: TransactionActionType.topUp,
                                );
                              },
                              child: _ActionButton(
                                  iconImage: topUp, label: 'Top Up'),
                            ),
                            GestureDetector(
                              onTap: () => _showFreezeCardSheet(context),
                              child: _ActionButton(
                                  iconImage: freeze, label: 'Freeze'),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_isFlipped) {
                                  _flip();
                                } else {
                                  _showSpendLimitSheet(context);
                                }
                              },
                              child: _ActionButton(
                                  iconImage: spendLimit,
                                  label: _isFlipped
                                      ? 'Details'
                                      : 'Spend Limit'),
                            ),
                            GestureDetector(
                              onTap: () => _showTerminateCardSheet(context),
                              child: _ActionButton(
                                  iconImage: terminate, label: 'Terminate'),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.transactionAction,
                                  arguments: TransactionActionType.withdraw,
                                );
                              },
                              child: _ActionButton(
                                  iconImage: withdraw, label: 'Withdraw'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: heightSize(28)),

                    // ── Latest transactions ──────────────────────────
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: widthSize(20)),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isDark ? sDarkFill : sLightFill,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: widthSize(17), vertical: heightSize(21)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CText(
                                text: 'Latest Transaction',
                                size: 16,
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wRegular,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.transactionHistory);
                                },
                                child: CText(
                                  text: 'See all',
                                  size: 14,
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wRegular,
                                  color: useAccent
                                      ? accent
                                      : isDark
                                      ? sNavContainer
                                      : sActionButton,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: heightSize(29)),
                          ...() {
                            final txList = _dummyTransactions(
                                isFlipped: _isFlipped,
                            );
                            return txList
                                .asMap()
                                .entries
                                .map((e) =>
                                _TransactionTile(
                                  tx: e.value,
                                  useAccent: useAccent,
                                  accent: accent,
                                  isLast: e.key == txList.length - 1,
                                ));
                          }(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card front face — blurred card image + balance
// ─────────────────────────────────────────────────────────────────────────────

class _CardFront extends StatelessWidget {
  final _CardData card;
  final VoidCallback onFlip;

  const _CardFront({required this.card, required this.onFlip});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSize(233.75),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 12),
              child: Image.asset(
                card.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.60),
                  ],
                ),
              ),
            ),
            Positioned(
              top: heightSize(14),
              right: widthSize(14),
              child: GestureDetector(
                onTap: onFlip,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthSize(12), vertical: heightSize(6)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.more_horiz_rounded,
                          color: Colors.white, size: 18),
                      SizedBox(width: widthSize(4)),
                      CText(
                        text: 'Details',
                        size: 14,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CText(
                    text: 'Available to spend',
                    size: 15,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    color: Colors.white,
                  ),
                  SizedBox(height: heightSize(4)),
                  CText(
                    text: '\$275.05',
                    size: 40,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wBold,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: heightSize(16),
              left: widthSize(16),
              right: widthSize(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    logo,
                    width: widthSize(18),
                    height: widthSize(18),
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn),
                  ),
                  CText(
                    text: card.network == CardNetwork.visa ? 'VISA' : 'VERVE',
                    size: 16,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wBold,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card Back Face — Structural Column
// ─────────────────────────────────────────────────────────────────────────────

class _CardBack extends StatelessWidget {
  final VoidCallback onFlip;

  const _CardBack({required this.onFlip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize(233.75),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2E2E2E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: heightSize(14), right: widthSize(14)),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onFlip,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthSize(12), vertical: heightSize(6)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.more_horiz_rounded,
                          color: Colors.white, size: 16),
                      SizedBox(width: widthSize(4)),
                      CText(
                        text: 'Details',
                        size: 13,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: heightSize(25.33)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CardField(
                  label: 'Card Number',
                  value: '5612 1234 5678 9012',
                  copyPayload: '5612123456789012',
                  fullWidth: true,
                ),
                SizedBox(height: heightSize(10)),
                Row(
                  children: [
                    const Expanded(
                      child: _CardField(
                        label: 'Expiry Date',
                        value: '21 / 31',
                        copyPayload: '21/31',
                        fullWidth: false,
                      ),
                    ),
                    SizedBox(width: widthSize(10)),
                    const Expanded(
                      child: _CardField(
                        label: 'CVV',
                        value: '411',
                        copyPayload: '411',
                        fullWidth: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardField extends StatelessWidget {
  final String label;
  final String value;
  final String copyPayload;
  final bool fullWidth;

  const _CardField({
    required this.label,
    required this.value,
    required this.copyPayload,
    required this.fullWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(
          horizontal: widthSize(14), vertical: heightSize(10)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: label,
                size: 11,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                color: sGrey2,
              ),
              SizedBox(height: heightSize(4)),
              CText(
                text: value,
                size: 16,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: copyPayload));
              Get.rawSnackbar(
                messageText: CText(
                  text: '$label copied to clipboard',
                  color: Colors.white,
                  size: 14,
                ),
                backgroundColor: sNavContainer,
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
                margin: EdgeInsets.all(widthSize(20)),
                borderRadius: 10,
              );
            },
            child: SvgPicture.asset(
              copy,
              width: widthSize(24),
              height: heightSize(24),
              colorFilter: const ColorFilter.mode(
                  Colors.white60, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-components & Helpers (Completed missing truncated elements cleanly)
// ─────────────────────────────────────────────────────────────────────────────

class _NetworkTab extends StatelessWidget {
  final bool isDark;
  final CardNetwork selected;
  final ValueChanged<CardNetwork> onChanged;
  final bool useAccent;
  final Color accent;

  const _NetworkTab({
    required this.isDark,
    required this.selected,
    required this.onChanged,
    this.useAccent = false,
    required this.accent,

  });

  @override
  Widget build(BuildContext context) {
    final isVisaSelected = selected == CardNetwork.visa;
    final isVerveSelected = selected == CardNetwork.verve;

    return Container(
      width: widthSize(239.14),
      height: heightSize(61.46),
      padding: EdgeInsets.symmetric(
        horizontal: widthSize(9.57),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(44.7),
        color: sDescriptionColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(CardNetwork.visa),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                height: heightSize(48.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    44.7,
                  ),
                  color: isVisaSelected
                      ? sActiveColor
                      : Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Visa',
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    size: 15.64,
                    color: isVisaSelected
                        ? useAccent ? accent : sNavContainer
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(CardNetwork.verve),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                height: heightSize(48.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    44.7,
                  ),
                  color: isVerveSelected
                      ? sActiveColor
                      : Colors.transparent,
                ),
                child: Center(
                  child: CText(
                    text: 'Verve',
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    size: 15.64,
                    color: isVerveSelected
                        ? useAccent ? accent : sNavContainer
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// Transaction model + dummy data
// ─────────────────────────────────────────────────────────────────────────────

class _TxData {
  final String iconImage;
  final String title;
  final String subtitle;
  final String amount;
  final String status;

  const _TxData({
    required this.iconImage,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
  });
}

// Front transactions (Naira — local)
final _frontTransactions = [
  _TxData(
      iconImage: transfer,
      title: 'Transfer to bank',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: 'N500.50',
      status: 'Successful'),
  _TxData(
      iconImage: transfer,
      title: 'Transfer to Sentro Tag',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: 'N500.50',
      status: 'Successful'),
  _TxData(
      iconImage: data,
      title: 'Mobile Data - MTN 2GB - Daily',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: 'N500.50',
      status: 'Successful'),
  _TxData(
      iconImage: betting,
      title: 'Betting',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: 'N500.50',
      status: 'Successful'),
  _TxData(
      iconImage: invest,
      title: 'Investment',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: 'N500.50',
      status: 'Successful'),
];

// Back transactions (Dollar — international)
final _backTransactions = [
  _TxData(
      iconImage: card,
      title: 'Google Cloud Payment',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: '\$500.50',
      status: 'Successful'),
  _TxData(
      iconImage: card,
      title: 'Netflix Subscription',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: '\$500.50',
      status: 'Successful'),
  _TxData(
      iconImage: card,
      title: 'Prime TV Subscription',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: '\$500.50',
      status: 'Successful'),
  _TxData(
      iconImage: card,
      title: 'Amazon Checkout',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: '\$500.50',
      status: 'Successful'),
  _TxData(
      iconImage: card,
      title: 'Amazon AWS Subscription',
      subtitle: '12:45.10 • 14 May, 2026',
      amount: '\$500.50',
      status: 'Successful'),
];

List<_TxData> _dummyTransactions({required bool isFlipped}) =>
    isFlipped ? _backTransactions : _frontTransactions;

class _TransactionTile extends StatelessWidget {
  final _TxData tx;
  final bool useAccent;
  final Color accent;
  final bool isLast;

  const _TransactionTile({required this.tx, required this.useAccent, required this.accent, this.isLast = false,});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              tx.iconImage,
              width: widthSize(38),
              height: heightSize(38),
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            SizedBox(width: widthSize(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                      text: tx.title,
                      size: 14,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wMedium),
                  SizedBox(height: heightSize(2.5)),
                  CText(
                      text: tx.subtitle,
                      size: 10,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                      color: isDark ? sGrey2: sConfirmTextColor),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CText(
                  text: tx.amount,
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  color: isDark?sGrey1:sGrey2,
                ),
                SizedBox(height: heightSize(3)),
                CText(
                  text: tx.status,
                  size: 12,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: useAccent?accent:isDark?sNavContainer:sLightGreen,
                ),
              ],
            ),
          ],
        ),
        if (!isLast) ...[
          SizedBox(height: heightSize(10)),
          Divider(
            color: sDarkBorder,
            height: 1,
          ),
          SizedBox(height: heightSize(10)),
        ] else
          SizedBox(height: heightSize(4)),
      ],
    );
  }
}

class _CardTile extends StatelessWidget {
  final _CardData card;

  const _CardTile({required this.card});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        card.image,
        height: heightSize(463.89), // the larger value = height (portrait)
        width: widthSize(278),      // the smaller value = width
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String iconImage;
  final String label;

  const _ActionButton({required this.iconImage, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconImage, width: widthSize(46), height: heightSize(46),),
        SizedBox(height: heightSize(8)),
        CText(
          text: label,
          size: 11,
          fontWeight: CFONT.wRegular,
          fontFamily: CFONT.FAMILY,
        ),
      ],
    );
  }
}

class _Transaction {
  final String title;
  final String date;
  final String amount;
  final bool isCredit;

  const _Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
}

void _showFreezeCardSheet(BuildContext context) {
  _showSwipeActionSheet(
    context: context,
    title: 'Freeze Card',
    description:
    'Card will not be active, subscriptions and transactions on this card will not work on until it\'s unfrozen',
    initialSwipeText: 'Swipe to freeze card',
    completedSwipeText: 'Card Frozen Successfully',
    activeColor: const Color(0xFFFA8F23), // Custom vibrant orange thumb
    trackColor: const Color(0xFF3D2A1C),  // Dark brownish-orange lane background
    centerIllustration: SvgPicture.asset(freezeCard, width: widthSize(75), height: heightSize(75),),
  );
}

void _showTerminateCardSheet(BuildContext context) {
  _showSwipeActionSheet(
    context: context,
    title: 'Terminate Card',
    description:
    'Card will be permanently deleted, subscriptions and transactions on this card will not work after this.',
    initialSwipeText: 'Swipe to Terminate card', // Keeping it accurate to Terminate.png layout
    completedSwipeText: 'Card Terminated',
    activeColor: const Color(0xFFFF3B30), // Red thumb
    trackColor: const Color(0xFF3D1F1F),  // Muted dark red lane background
    centerIllustration: SvgPicture.asset(slash, width: widthSize(75), height: heightSize(75),),
  );
}

void _showSwipeActionSheet({
  required BuildContext context,
  required String title,
  required String description,
  required String initialSwipeText,
  required String completedSwipeText,
  required Color activeColor,
  required Color trackColor,
  required Widget centerIllustration,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: widthSize(24), vertical: heightSize(24)),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: heightSize(16)),
          CText(
            text: title,
            size: 18,
            fontWeight: CFONT.wMedium,
            fontFamily: CFONT.FAMILY,
          ),
          SizedBox(height: heightSize(25.5)),
          centerIllustration,
          SizedBox(height: heightSize(40.5)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
            child: CText(
              text: description,
              size: 16,
              textAlign: TextAlign.center,
              fontWeight: CFONT.wRegular,
              fontFamily: CFONT.FAMILY,
              height: 1.5,
            ),
          ),
          SizedBox(height: heightSize(34)),
          SwipeToConfirm(
            initialText: initialSwipeText,
            completedText: completedSwipeText,
            activeColor: activeColor,
            trackColor: trackColor,
            onCompleted: () {
              Future.delayed(const Duration(seconds: 1), () {
                Get.back();
              });
            },
          ),
          SizedBox(height: heightSize(16)),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

void _showSpendLimitSheet(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  String selectedMethod = 'Daily';
  TextEditingController amountController = TextEditingController();

  bool _isDefaultAccent(Color c) {
    final defaultAccent = AccentController.options.first;
    return c.value == defaultAccent.value;
  }

  Get.bottomSheet(
    StatefulBuilder(
      builder: (context, setSheetState) {
        final accent = AccentController.to.accent.value;
        final useAccent = !_isDefaultAccent(accent);
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: widthSize(24), vertical: heightSize(24)),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: widthSize(40),
                  height: heightSize(4),
                  decoration: BoxDecoration(
                    color: isDark ? sDarkBorder : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: heightSize(24)),
              Center(
                child: CText(
                  text: 'Spend Limit',
                  size: 20,
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                ),
              ),
              SizedBox(height: heightSize(12)),
              Center(
                child: CText(
                  text: 'Set limits on how much to spend on your card',
                  size: 14,
                  textAlign: TextAlign.center,
                  color: isDark ? sGrey1 : sGrey2,
                  fontFamily: CFONT.FAMILY,
                ),
              ),
              SizedBox(height: heightSize(28)),
              AppTextField(
                title: Center(
                  child: CText(
                    text: 'Limit Amount',
                    size: 16,
                    fontWeight: CFONT.wRegular,
                    fontFamily: CFONT.FAMILY,
                  ),
                ),
                showNairaPrefix: true,
                hint: '0.00',
                controller: amountController,
                inputType: const TextInputType.numberWithOptions(decimal: true), // Allowed decimals & commas smoothly
                inputFormatters: [NairaInputFormatter()],
                suffixWidth: 124,

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
                error: '',
                validFunction: (v) {
                  return null;
                },
              ),
              SizedBox(height: heightSize(6)),
              CText(
                text: '\$0.00',
                size: 14,
                color: sGrey2,
                fontFamily: CFONT.FAMILY,
              ),
              SizedBox(height: heightSize(20)),
              CText(
                text: 'Limit Method',
                size: 14,
                fontWeight: CFONT.wRegular,
                color: isDark ? sGrey1 : sGrey2,
                fontFamily: CFONT.FAMILY,
              ),
              SizedBox(height: heightSize(8)),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widthSize(16), vertical: heightSize(4)),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isDark ? const Color(0xFF383838) : Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedMethod,
                    isExpanded: true,
                    dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: <String>['Daily', 'Weekly', 'Monthly']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CText(
                          text: value,
                          size: 15,
                          fontFamily: CFONT.FAMILY,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setSheetState(() => selectedMethod = newValue);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: heightSize(36)),
              SizedBox(
                width: double.infinity,
                height: heightSize(52),
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: useAccent?accent:isDark?sNavContainer:sActionButton, // Vibrant lime green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: CText(
                    text: 'Set Limit',
                    size: 16,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    color: isDark?sActionButton:sNavContainer,
                  ),
                ),
              ),
              SizedBox(height: heightSize(16)),
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Completed SwipeToConfirm Custom Slide Widget
// ─────────────────────────────────────────────────────────────────────────────

class SwipeToConfirm extends StatefulWidget {
  final String initialText;
  final String completedText;
  final VoidCallback onCompleted;
  final Color activeColor;
  final Color? trackColor; // Optional custom background track tint override

  const SwipeToConfirm({
    super.key,
    required this.initialText,
    required this.completedText,
    required this.onCompleted,
    required this.activeColor,
    this.trackColor,
  });

  @override
  State<SwipeToConfirm> createState() => _SwipeToConfirmState();
}

class _SwipeToConfirmState extends State<SwipeToConfirm>
    with SingleTickerProviderStateMixin {
  late double _dragPosition;
  bool _isCompleted = false;
  late AnimationController _snapController;
  late Animation<double> _snapAnimation;

  // Layout constants
  final double _trackHeight = 80.0;
  final double _padding = 8.0; // Clean uniform spacing for the inner gutter

  // The thumb size becomes a perfect square inside the track: 80 - (8 * 2) = 64
  late final double _thumbSize = _trackHeight - (2 * _padding);

  @override
  void initState() {
    super.initState();
    // Start at the padded left coordinate instead of 0.0
    _dragPosition = _padding;

    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _snapController.addListener(() {
      setState(() {
        _dragPosition = _snapAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, double maxWidth) {
    if (_isCompleted) return;
    setState(() {
      _dragPosition += details.delta.dx;
      // Clamp between the left padding and the maximum allowable right padded position
      _dragPosition = _dragPosition.clamp(_padding, maxWidth - _thumbSize - _padding);
    });
  }

  void _onPanEnd(DragEndDetails details, double maxWidth) {
    if (_isCompleted) return;

    final minDrag = _padding;
    final maxDrag = maxWidth - _thumbSize - _padding;
    final slidableRange = maxDrag - minDrag;

    // Trigger success if swiped past 80% of the active channel length
    if (_dragPosition > minDrag + (slidableRange * 0.8)) {
      _snapAnimation = Tween<double>(begin: _dragPosition, end: maxDrag).animate(
        CurvedAnimation(parent: _snapController, curve: Curves.easeOutCubic),
      );
      _snapController.forward(from: 0.0).then((_) {
        setState(() => _isCompleted = true);
        widget.onCompleted();
      });
    } else {
      // Snap clean back to the starting left padding position
      _snapAnimation = Tween<double>(begin: _dragPosition, end: minDrag).animate(
        CurvedAnimation(parent: _snapController, curve: Curves.easeOutCubic),
      );
      _snapController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final minDrag = _padding;
        final maxDrag = maxWidth - _thumbSize - _padding;

        final slidableRange = maxDrag - minDrag;
        final progress = slidableRange > 0
            ? ((_dragPosition - minDrag) / slidableRange).clamp(0.0, 1.0)
            : 0.0;

        final rotationAngle = progress * math.pi;

        return Container(
          height: _trackHeight,
          clipBehavior: Clip.antiAlias, // Double containment guarantee
          decoration: BoxDecoration(
            color: widget.trackColor ?? (isDark ? sDarkFill : sLightFill),
            borderRadius: BorderRadius.circular(_trackHeight / 2), // Perfect structural capsule
          ),
          child: Stack(
            children: [
              // Background Text Track
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: CText(
                    key: ValueKey(_isCompleted),
                    text: _isCompleted ? widget.completedText : widget.initialText,
                    size: 15,
                    fontWeight: CFONT.wMedium,
                    fontFamily: CFONT.FAMILY,
                    color: _isCompleted ? Colors.white : Colors.white70,
                  ),
                ),
              ),

              // Precision Contained Thumb Button
              Positioned(
                left: _dragPosition,
                top: _padding,
                bottom: _padding,
                child: GestureDetector(
                  onPanUpdate: (d) => _onPanUpdate(d, maxWidth),
                  onPanEnd: (d) => _onPanEnd(d, maxWidth),
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: widget.activeColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: rotationAngle,
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}