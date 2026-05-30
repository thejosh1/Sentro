import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/home_page.dart';
import 'package:sentro/screen/main_view/Dashboard/views/transaction_history.dart';
import 'package:sentro/screen/main_view/controller/main_controller.dart';
import 'package:sentro/screen/main_view/qr_pay/qr_pay.dart';

class MainView extends StatefulWidget {
  final int initialIndex;

  const MainView({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainController controller = Get.put(MainController());
  late int _selectedIndex;
  bool _showAiOverlay = false;

  final _homeKey = GlobalKey();
  final _qrKey = GlobalKey();
  final _cardKey = GlobalKey();
  final _historyKey = GlobalKey();

  List<Widget> _buildPages() {
    return <Widget>[
      HomePage(key: _homeKey),
      QrPay(key: _qrKey, showBackButton: false),
      Container(),
      Container(),
      TransactionHistory(key: _historyKey, showBackButton: false,),
    ];
  }

  @override
  void initState() {
    super.initState();
    controller.changeTab(widget.initialIndex);
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      setState(() => _showAiOverlay = !_showAiOverlay);
      return;
    }
    controller.changeTab(index);
    setState(() => _selectedIndex = index);
  }

  Widget _navIcon({
    required String icon,
    required bool selected,
    required bool isDark,
    double width = 24,
    double height = 24,
  }) {
    return SvgPicture.asset(
      icon,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        selected ? sLightGreen : isDark?Colors.white.withOpacity(0.5):sDarkFill.withOpacity(0.5),
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildCenterAiButton() {
    return Transform.translate(
      offset: const Offset(0, 8),
      child: SizedBox(
        width: 53,
        height: 53,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(aiIcon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBody: true,

        body: Stack(
          children: [
            IndexedStack(
              index: controller.selectedIndex.value,
              children: _buildPages(),
            ),
            if (_showAiOverlay) const _AiOverlay(),
          ],
        ),

        bottomNavigationBar: Container(
          height: 84,
          padding: const EdgeInsets.only(
            top: 2,
            bottom: 0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: controller.selectedIndex.value,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: sLightGreen,
            unselectedItemColor: isDark?sDarkHintText:sLightHintText,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wMedium,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: CFONT.FAMILY,
              fontWeight: CFONT.wRegular,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _navIcon(
                  icon: home,
                  isDark: isDark,
                  selected: _selectedIndex == 0,
                  width: 25.5,
                  height: 25.5,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(
                  icon: qrPay,
                  isDark: isDark,
                  selected: _selectedIndex == 1,
                  width: 24,
                  height: 25.5,
                ),
                label: 'QR Pay',
              ),
              BottomNavigationBarItem(
                icon: _buildCenterAiButton(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: _navIcon(
                  isDark: isDark,
                  icon: card,
                  selected: _selectedIndex == 3,
                ),
                label: 'Cards',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  history,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 4 ? sLightGreen : isDark?Colors.white.withOpacity(0.5):sDarkFill,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'History',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiOverlay extends StatefulWidget {
  const _AiOverlay();

  @override
  State<_AiOverlay> createState() => _AiOverlayState();
}

class _AiOverlayState extends State<_AiOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  final TextEditingController _inputController = TextEditingController();

  final List<Map<String, String>> _suggestions = [
    {
      'title': 'Send Money',
      'subtitle':
      'Simply say just "Send Money" then to the Account, and Bank Account',
    },
    {
      'title': 'Buy Airtime',
      'subtitle':
      'Simply say just "Buy Airtime" then to the phone, Network and Amount',
    },
    {
      'title': 'Buy Data',
      'subtitle':
      'Simply say just "Buy Data" then to the phone, Network and Bundle size',
    },
    {
      'title': 'Account Inquiry',
      'subtitle': 'Simply say just "Check my account balance"',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Stack(
        children: [
          // ── Blurred backdrop ──────────────────────────
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.55),
                width: double.maxFinite,
                height: double.maxFinite,
              ),
            ),
          ),

          // ── Content ───────────────────────────────────
          SlideTransition(
            position: _slideAnim,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: heightSize(20)),

                  // ── Header ────────────────────────────
                  Center(
                    child: SvgPicture.asset(
                      sentroAi,
                      width: widthSize(125.72),
                      height: heightSize(32),
                    ),
                  ),

                  SizedBox(height: heightSize(41)),

                  // ── Suggestion cards ──────────────────
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: widthSize(20),
                      ),
                      itemCount: _suggestions.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: heightSize(10)),
                      itemBuilder: (context, index) {
                        final s = _suggestions[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: widthSize(16),
                                vertical: heightSize(14),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CText(
                                    text: s['title']!,
                                    fontWeight: CFONT.wMedium,
                                    fontFamily: CFONT.FAMILY,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: heightSize(4)),
                                  CText(
                                    text: s['subtitle']!,
                                    size: 12,
                                    fontFamily: CFONT.FAMILY,
                                    fontWeight: CFONT.wRegular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: heightSize(16)),

                  // ── Example bubble ────────────────────
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: widthSize(20)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: widthSize(14),
                          vertical: heightSize(8.5),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(113.27),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Send Money ',
                                style: TextStyle(
                                  fontSize: fontSize(14),
                                  fontWeight: CFONT.wBold,
                                  fontFamily: CFONT.FAMILY,
                                  color: sSentroLightGreen,
                                ),
                              ),
                              TextSpan(
                                text: "to John Doe's Opay",
                                style: TextStyle(
                                  fontSize: fontSize(14),
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wRegular,
                                  color: sDarkBorder,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: heightSize(16)),

                  // ── Input bar ─────────────────────────
                  Padding(
                    padding: EdgeInsets.only(
                      left: widthSize(25),
                      right: widthSize(25),
                    ),
                    child: Container(
                      height: heightSize(65),
                      padding: EdgeInsets.only(
                        left: widthSize(8),
                        right: widthSize(8),
                        top: heightSize(6),
                        bottom: heightSize(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(77.59),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: heightSize(53),
                              padding: EdgeInsets.symmetric(
                                horizontal: widthSize(20),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(77.59),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _inputController,
                                  style: TextStyle(
                                    fontSize: fontSize(14),
                                    fontFamily: CFONT.FAMILY,
                                    fontWeight: CFONT.wMedium,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'What are you doing today?',
                                    hintStyle: TextStyle(
                                      color: sGrey2,
                                      fontSize: fontSize(14),
                                      fontFamily: CFONT.FAMILY,
                                      fontWeight: CFONT.wMedium,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                    isCollapsed: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize(13.75)),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.confirmTransfer);
                            },
                            child: Container(
                              width: widthSize(52.02),
                              height: heightSize(52.02),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: sNavContainer,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  microphone,
                                  width: widthSize(37.03),
                                  height: heightSize(37.03),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}