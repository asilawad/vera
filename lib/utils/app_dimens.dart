import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  AppSpacing._();

  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
}

class AppRadius {
  AppRadius._();

  static double get sm => 8.r;
  static double get md => 14.r;
  static double get lg => 20.r;
}

class AppSizes {
  AppSizes._();

  static double get icon => 24.w;
  static double get buttonHeight => 48.h;
  static double get galleryHeight => 375.h;

  static const tabletBreakpoint = 600.0;
  static const twoPaneWidth = 840.0;
  static const desktopBreakpoint = 1024.0;
}
