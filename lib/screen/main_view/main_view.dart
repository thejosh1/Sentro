import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/screen/main_view/Dashboard/views/home_page.dart';

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
  late int _selectedIndex;

  final _homeKey = GlobalKey();
  final _savingsKey = GlobalKey();
  final _cardKey = GlobalKey();

  List<Widget> _buildPages() {
    return <Widget>[
      HomePage(key: _homeKey),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navIcon({
    required String icon,
    required bool selected,
    double width = 24,
    double height = 24,
  }) {
    return SvgPicture.asset(
      icon,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        selected ? sLightGreen : Colors.white.withOpacity(0.5),
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBody: true,                           // ✅ allows center button to float above body

        body: IndexedStack(
          index: _selectedIndex,
          children: _buildPages(),
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

            currentIndex: _selectedIndex,
            onTap: _onItemTapped,

            showSelectedLabels: true,
            showUnselectedLabels: true,

            selectedItemColor: sLightGreen,

            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: CFONT.MEDIUM,
              fontWeight: FontWeight.w500,
            ),

            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: CFONT.REGULAR,
              fontWeight: FontWeight.w400,
            ),

            items: [
              BottomNavigationBarItem(
                icon: _navIcon(
                  icon: home,
                  selected: _selectedIndex == 0,
                  width: 25.5,
                  height: 25.5,
                ),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: _navIcon(
                  icon: qrPay,
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
                  colorFilter: ColorFilter.mode(   // ✅ was `color:` (deprecated & breaks loading)
                    _selectedIndex == 4 ? sLightGreen : Colors.white,
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