import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/keyboard_pin.dart';

class ContinuousLogin extends StatefulWidget {
  const ContinuousLogin({super.key});

  @override
  State<ContinuousLogin> createState() => _ContinuousLoginState();
}

class _ContinuousLoginState extends State<ContinuousLogin>
    with SingleTickerProviderStateMixin {
  static const int _pinLength = 4;
  static const String _correctPin = '1234';

  final TextEditingController controller = TextEditingController();

  Future<void> _onSubmitPin() async {
    final pin = controller.text.trim();
    if (pin.length < 4) {
      // cToast(title: "Invalid PIN", message: "Enter your 4-digit PIN", color: kRed);
      return;
    } else {
      Get.toNamed(Routes.welcome);
    }
  }

  final List<int> _entered = [];

  // Shake animation for wrong PIN
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12, end: 12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12, end: -8),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8),   weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0),    weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  // ── Input logic ────────────────────────────────────────────────────────────




  void _onBiometric() {
    // Trigger biometric auth here
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // ── Background web pattern ──────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.40,
            child: SvgPicture.asset(
              union,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                sNavContainer.withOpacity(0.5),
                BlendMode.srcIn,
              ),
            ),
          ),

          // ── Main content ────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: heightSize(20)),

                // ── Logo ──────────────────────────────────
                Center(
                  child: SvgPicture.asset(
                    logo,
                    width: widthSize(180),
                    height: heightSize(44),
                  ),
                ),

                SizedBox(height: heightSize(48)),

                // ── Avatar ────────────────────────────────
                Container(
                  width: widthSize(70),
                  height: heightSize(70),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: heightSize(12)),

                // ── Greeting ──────────────────────────────
                CText(
                  text: 'Hi Richmond,',
                  size: 20,
                  fontFamily: CFONT.SEMIBOLD,
                  fontWeight: CFONT.wBold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),

                SizedBox(height: heightSize(4)),

                CText(
                  text: 'Login with your PIN or Biometrics',
                  size: 14,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wRegular,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),

                SizedBox(height: heightSize(24)),

                // ── PIN dots ──────────────────────────────
                AnimatedBuilder(
                  animation: _shakeAnim,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(_shakeAnim.value, 0),
                    child: child,
                  ),
                  child: _PinDots(
                    entered: _entered.length,
                    total: _pinLength,
                  ),
                ),

                const Spacer(),

                // ── Numpad ────────────────────────────────
                KeyboardPin(
                  controller: controller,
                  callback: _onSubmitPin,
                ),

                SizedBox(height: heightSize(40)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── PIN dots ──────────────────────────────────────────────────────────────────

class _PinDots extends StatelessWidget {
  final int entered;
  final int total;

  const _PinDots({required this.entered, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize(52),
      padding: EdgeInsets.symmetric(horizontal: widthSize(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: sNavContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_pinLength, (i) {
          final isFilled = i < entered;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutBack,
              width: isFilled ? widthSize(18) : widthSize(14),
              height: isFilled ? heightSize(18) : heightSize(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled
                    ? sActiveColor
                    : Colors.white.withOpacity(0.4),
              ),
            ),
          );
        }),
      ),
    );
  }

  int get _pinLength => total;
}