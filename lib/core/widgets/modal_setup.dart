import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

modalSetup(
    BuildContext context, {
      required Widget createPage,
      required bool showBarrierColor,
    }) {
  final size = MediaQuery.of(context).size;
  final screenHeight = size.height;
  final screenWidth = size.width;

  final bool isWide = screenWidth > 600;

  // Base height = 40% of screen
  final double baseHeight = screenHeight * 0.4;

  final Color barrier = showBarrierColor
      ? Colors.black.withOpacity(0.6)
      : Colors.transparent;

  if (isWide) {
    // ─────────────────────────────
    // TABLET / DESKTOP DIALOG
    // ─────────────────────────────
    return Get.dialog(
      Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
            maxHeight: screenHeight * 0.8,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: baseHeight.clamp(200.0, screenHeight * 0.8),
              child: createPage,
            ),
          ),
        ),
      ),
      barrierColor: barrier,
    );
  }

  // ─────────────────────────────
  // MOBILE BOTTOM SHEET
  // ─────────────────────────────
  return showBarModalBottomSheet(
    context: context,
    duration: const Duration(milliseconds: 150),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    barrierColor: barrier,
    builder: (context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      final isKeyboardOpen = keyboardHeight > 0;

      final double height = isKeyboardOpen
          ? baseHeight + keyboardHeight
          : baseHeight;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: height.clamp(
          baseHeight,
          screenHeight * 0.9,
        ),
        child: SingleChildScrollView(
          child: createPage,
        ),
      );
    },
  );
}