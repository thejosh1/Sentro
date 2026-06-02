import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/accent_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<String> images = [
    getStarted,
    getStarted, // replace with second image
    getStarted, // replace with third image
  ];

  final List<String> text = [
    'Go beyond banking',
    'Go beyond banking',
    'We\'re 5% better'
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: sBlack,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (i) {
              setState(() => _index = i);
            },
            itemBuilder: (_, __) => const SizedBox(),
          ),
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              images[_index],
              fit: BoxFit.cover,
            ),
          ),

          /// GRADIENT OVERLAY
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.65),
                    Colors.black.withOpacity(0.90),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: heightSize(68)),

                Center(
                  child: Obx(() {
                    final accent = AccentController.to.accent.value;
                    final isDefault = AccentController.options.first.value == accent.value;

                    return SvgPicture.asset(
                      logo,
                      width: widthSize(204.79),
                      height: heightSize(48),
                      colorFilter: isDefault
                          ? null
                          : ColorFilter.mode(
                        accent,
                        BlendMode.srcIn,
                      ),
                    );
                  }),
                ),

                const Spacer(),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(47),
                  ),
                  child: Center(
                    child: CText(
                      text: text[_index],
                      fontWeight: CFONT.wRegular,
                      size: 37.2,
                      letterSpacing: 0.48,
                      fontFamily: 'Perfectly Vintages',
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: heightSize(5)),

                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: widthSize(25),
                  ),
                  child: CText(
                    text:
                    'Semper vel id ut quisque sit. Sapien ut amet non in varius. Odio libero nulla lorem ornare nibh nulla interdum arcu.',
                    size: 15,
                    fontFamily: CFONT.FAMILY,
                    fontWeight: CFONT.wRegular,
                    textAlign: TextAlign.center,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: heightSize(12.12),),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_index > 0) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Obx(() {
                          final accent = AccentController.to.accent.value;
                          return SvgPicture.asset(
                            arrowBackWhite,
                            width: widthSize(61),
                            height: heightSize(61),
                            colorFilter: ColorFilter.mode(
                              _index > 0 ? accent : Colors.white.withOpacity(0.3),  // 👈 dimmed when no prev
                              BlendMode.srcIn,
                            ),
                          );
                        }),
                      ),
                  
                      SizedBox(width: widthSize(20)),
                  
                      /// DOT INDICATOR (NOW IN THE MIDDLE)
                      Obx(() {
                        final accent = AccentController.to.accent.value;
                        return Row(
                          children: List.generate(images.length, (i) {
                            final active = i == _index;
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: EdgeInsets.symmetric(horizontal: widthSize(4)),
                                width: active ? widthSize(18) : widthSize(8),
                                height: widthSize(8),
                                decoration: BoxDecoration(
                                  color: active ? accent : Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                  
                      SizedBox(width: widthSize(20)),

                      GestureDetector(
                        onTap: () {
                          if (_index < images.length - 1) {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Obx(() {
                          final accent = AccentController.to.accent.value;
                          return SvgPicture.asset(
                            arrowLeft,
                            width: widthSize(61),
                            height: heightSize(61),
                            colorFilter: ColorFilter.mode(
                              _index < images.length - 1 ? accent : Colors.white.withOpacity(0.3),  // 👈 dimmed when no next
                              BlendMode.srcIn,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: heightSize(73)),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(25),
                  ),
                  child: Obx(() {
                    final accent = AccentController.to.accent.value;
                    return Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: heightSize(60),
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(Routes.verifyPhone),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent.withOpacity(0.10),  // 👈
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wMedium,
                                  color: accent,                            // 👈
                                  letterSpacing: 0.54,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: widthSize(20)),

                        Expanded(
                          child: SizedBox(
                            height: heightSize(60),
                            child: ElevatedButton(
                              onPressed: () => Get.toNamed(Routes.createAccount),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,                    // 👈
                                foregroundColor: sDeepGreen,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontFamily: CFONT.FAMILY,
                                  fontWeight: CFONT.wMedium,
                                  color: Colors.black,
                                  letterSpacing: 0.54,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                SizedBox(height: heightSize(35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}