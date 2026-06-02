import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/headers.dart';

// ── Test PIN ─────────────────────────────────────────────────────────────────
const _kCurrentPin = '1234';

// ── Step enum ─────────────────────────────────────────────────────────────────
enum _PinStep { confirm, create, repeat }

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin>
    with SingleTickerProviderStateMixin {
  _PinStep _step = _PinStep.confirm;

  final _confirmCtrl = TextEditingController();
  final _createCtrl  = TextEditingController();
  final _repeatCtrl  = TextEditingController();

  // Shake animation
  late final AnimationController _shakeCtrl;
  late final Animation<double>    _shakeAnim;

  // Slide/fade between steps
  final _stepKey = GlobalKey();

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

    // Auto-advance when each field hits 4 chars
    _confirmCtrl.addListener(() {
      if (_confirmCtrl.text.length == 4) _handleConfirm();
    });
    _createCtrl.addListener(() {
      if (_createCtrl.text.length == 4) _advanceTo(_PinStep.repeat);
    });
    _repeatCtrl.addListener(() {
      if (_repeatCtrl.text.length == 4) _handleRepeat();
    });
  }

  @override
  void dispose() {
    _confirmCtrl.dispose();
    _createCtrl.dispose();
    _repeatCtrl.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  // ── Step logic ──────────────────────────────────────────────────────────────

  void _handleConfirm() {
    if (_confirmCtrl.text == _kCurrentPin) {
      _advanceTo(_PinStep.create);
    } else {
      _wrongPin(_confirmCtrl);
    }
  }

  void _handleRepeat() {
    if (_repeatCtrl.text == _createCtrl.text) {
      Get.offAllNamed(Routes.welcome); // or Routes.login
    } else {
      _wrongPin(_repeatCtrl);
    }
  }

  void _wrongPin(TextEditingController ctrl) {
    HapticFeedback.heavyImpact();
    _shakeCtrl.forward(from: 0).whenComplete(() {
      Future.delayed(const Duration(milliseconds: 80), () {
        if (mounted) ctrl.clear();
      });
    });
  }

  void _advanceTo(_PinStep step) {
    setState(() => _step = step);
  }

  TextEditingController get _activeCtrl => switch (_step) {
    _PinStep.confirm => _confirmCtrl,
    _PinStep.create  => _createCtrl,
    _PinStep.repeat  => _repeatCtrl,
  };

  String get _title => switch (_step) {
    _PinStep.confirm => 'Confirm current Pin',
    _PinStep.create  => 'Create new 4 digit PIN',
    _PinStep.repeat  => 'Repeat new 4 digit PIN',
  };

  String get _subtitle => switch (_step) {
    _PinStep.confirm => 'Provide your current PIN',
    _PinStep.create  => 'This PIN will be used to authorise transactions',
    _PinStep.repeat  => 'This PIN will be used to authorise transactions',
  };

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: Stack(
          children: [

            // Offstage keeps the field out of layout & hit-testing entirely
            Offstage(
              child: TextField(
                focusNode: _focusNode,
                controller: _activeCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                autofocus: true,
                showCursor: false,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),

            // Main content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heightSize(64)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _focusNode.unfocus();
                          FocusScope.of(context).unfocus();

                          await Future.delayed(const Duration(milliseconds: 100));

                          Get.back();
                        },
                        child: SvgPicture.asset(
                          isDark?arrowBackWhite:arrowBack,
                          width: widthSize(42),
                          height: heightSize(42),
                        ),
                      ),
                      Spacer(),
                      CText(
                        text: 'Change Pin',
                        size: 18,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wMedium,
                        height: 20/18,
                      ),
                      Spacer(),
                    ],
                  ),

                  SizedBox(height: heightSize(34)),

                  // Title + subtitle animate when step changes
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.08),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: Column(
                      key: ValueKey(_step),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: _title,
                          size: 22,
                          fontFamily: CFONT.FAMILY,
                          fontWeight: CFONT.wBold,
                        ),
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: _subtitle,
                          fontWeight: CFONT.wRegular,
                          size: 18,
                          fontFamily: CFONT.FAMILY,
                          color: isDark ? sDarkModeMutedText : sLightModeMutedText,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: heightSize(30)),

                  // PIN boxes with shake
                  AnimatedBuilder(
                    animation: _shakeAnim,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(_shakeAnim.value, 0),
                      child: child,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: _PinBoxes(
                        key: ValueKey(_step),
                        controller: _activeCtrl,
                        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
                        isDark: isDark,
                      ),
                    ),
                  ),

                  SizedBox(height: heightSize(30)),

                  // "Can't remember?" only on confirm step
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: _step == _PinStep.confirm ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: _step != _PinStep.confirm,
                      child: CText(
                        text: "Can't remember?",
                        size: 16,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        color: sCancel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _focusNode = FocusNode();
}

// ── PIN Boxes ─────────────────────────────────────────────────────────────────

class _PinBoxes extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isDark;

  const _PinBoxes({super.key, required this.controller, required this.onTap, required this.isDark});

  @override
  State<_PinBoxes> createState() => _PinBoxesState();
}

class _PinBoxesState extends State<_PinBoxes> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(4, (index) {
          final isFilled = index < widget.controller.text.length;

          return Padding(
            padding: EdgeInsets.only(
              right: index < 3 ? widthSize(12) : 0,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              width: widthSize(58),
              height: heightSize(58),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isFilled ? sActionButton : widget.isDark?sDarkFill:sLightFill,
              ),
              child: Center(
                child: AnimatedScale(
                  scale: isFilled ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutBack,
                  child: Container(
                    width: widthSize(14),
                    height: heightSize(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sNavContainer,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}