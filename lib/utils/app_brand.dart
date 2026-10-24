import 'package:flutter/material.dart';

/// Single home for Vera brand text, colors, and splash sizing.
class AppBrand {
  AppBrand._();

  static const String name = 'Vera';
  static const String tagline = 'جودة تحملها معك';
  static const String retry = 'إعادة المحاولة';

  static const Color splashBackground = Color(0xFF570E20);

  static const Color burgundy = Color(0xFF7A1F36);
  static const Color gold = Color(0xFFC9A24B);
  static const Color cream = Color(0xFFFAF5EE);

  static const double glowOpacity = 0.35;
  static const double glowSecondaryOpacity = 0.6;
  static const double mutedOpacity = 0.7;

  // Splash
  static const Duration splashMinDuration = Duration(milliseconds: 1400);
  static const Duration splashAnimDuration = Duration(milliseconds: 900);
  static const double splashRevealStart = 0;
  static const double splashRevealEnd = 1;
  static const Curve splashCurve = Curves.easeOutBack;
  static const double splashScaleStart = 0.85;
  static const double splashLogoSize = 150;
  static const double splashGap = 20;
  static const double splashSmallGap = 6;
  static const double splashTitleSize = 30;
  static const double splashTitleSpacing = 3;
  static const double splashTaglineSize = 15;
  static const double loaderSize = 26;
  static const double loaderStroke = 2.4;
  static const double glowLargeSize = 340;
  static const double glowSmallSize = 300;
  static const double glowTopOffset = -120;
  static const double glowTopSide = -80;
  static const double glowBottomOffset = -140;
  static const double glowBottomSide = -100;
  static const EdgeInsets splashPadding = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets splashBottomPadding = EdgeInsets.fromLTRB(
    24,
    16,
    24,
    40,
  );
}
