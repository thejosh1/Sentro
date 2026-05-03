import 'dart:ui';
import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double widthMultiplier;
  static late double heightMultiplier;
  static late double textMultiplier;

  static bool isTablet = false;
  static bool isUnfolded = false;
  static bool hasHinge = false;
  static List<DisplayFeature> displayFeatures = [];

  void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    displayFeatures = mediaQuery.displayFeatures;

    // Detect if the device is a tablet or an unfolded foldable
    isTablet = screenWidth >= 600;

    // Check for physical hinge or flexible fold
    hasHinge = displayFeatures.any((f) =>
    f.type == DisplayFeatureType.hinge || f.type == DisplayFeatureType.fold);

    // If it's wide and has a fold/hinge, it's definitely "Unfolded"
    isUnfolded = hasHinge && screenWidth > 400;

    // Multipliers for your existing math logic
    widthMultiplier = screenWidth / 100;
    heightMultiplier = screenHeight / 100;
    textMultiplier = heightMultiplier;
  }
}