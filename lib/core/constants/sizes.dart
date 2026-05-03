import 'dart:math';

import 'package:sentro/core/constants/size_config.dart';

const double _designWidth = 414;
const double _designHeight = 896;

double widthSize(num value) {
  if (SizeConfig.isTablet || SizeConfig.isUnfolded) {
    // For large screens, scale based on design width but cap it
    // so the UI doesn't stretch awkwardly.
    double scaled = (value / _designWidth) * SizeConfig.screenWidth;
    return min(scaled, 550.0);
  }

  // Standard phone behavior:
  // (value / 4.14) * (screenWidth / 100) is mathematically the same
  // as (value / 414) * screenWidth.
  return (value / 4.14) * SizeConfig.widthMultiplier;
}

double heightSize(num value) {
  if (SizeConfig.isTablet || SizeConfig.isUnfolded) {
    double scaled = (value / _designHeight) * SizeConfig.screenHeight;
    return min(scaled, 900.0);
  }
  return (value / 8.96) * SizeConfig.heightMultiplier;
}

double fontSize(num value) {
  if (SizeConfig.isTablet || SizeConfig.isUnfolded) {
    // Tablets need slightly larger text to balance the white space
    double scaled = (value / _designHeight) * SizeConfig.screenHeight;
    return scaled.clamp(14.0, 24.0);
  }
  return (value / 8.96) * SizeConfig.textMultiplier;
}