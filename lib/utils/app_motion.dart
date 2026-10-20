import 'package:flutter/animation.dart';

abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration shimmer = Duration(milliseconds: 1200);
  static const Duration checkmark = Duration(milliseconds: 600);
  static const Duration bannerAutoScroll = Duration(seconds: 4);
  static const Duration bannerPageTransition = Duration(milliseconds: 600);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve bounce = Curves.elasticOut;
}
