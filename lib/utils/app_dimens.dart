import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  AppSpacing._();

  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get page => 20.w;
  static double get compact => 10.w;
  static double get micro => 3.w;
  static double get barVertical => 14.w;
}

class AppRadius {
  AppRadius._();

  static double get sm => 8.r;
  static double get md => 14.r;
  static double get lg => 20.r;
  static double get pill => 999.r;
  static double get chip => md;
  static double get card => lg;
}

class AppSizes {
  AppSizes._();

  static double get icon => 24.w;
  static double get compactIcon => 18.w;
  static double get smallIcon => 16.w;
  static double get cartSpinner => 18.w;
  static double get productPriceFontSize => 22;
  static double get galleryIndicatorActiveWidth => 20.w;
  static double get galleryIndicatorWidth => 7.w;
  static double get galleryIndicatorHeight => 7.h;
  static double get sizeOptionMinWidth => 52.w;
  static double get sizeOptionHeight => 46.h;
  static double get colorSwatch => 42.w;
  static double get reviewStar => 38.w;
  static double get reviewProgressHeight => 6.h;
  static double get relatedProductWidth => 160.w;
  static double get bottomBarShadowBlur => 20.r;
  static double get borderWidth => 2.w;
  static double get buttonHeight => 48.h;
  static double get galleryHeight => 375.h;
  static double get chipHeight => 40.h;
  static double get chipIcon => 18.w;
  static double get dot => 6.w;
  static double get dotActive => 18.w;
  static double get appBarHeight => 56.h;

  static const tabletBreakpoint = 600.0;
  static const twoPaneWidth = 840.0;
  static const desktopBreakpoint = 1024.0;

  /// Reserved width beside the cart label: stepper (40 + 34 + 40),
  /// row gap (12), button padding (16 + 24), icon (18), and icon-label gap (8).
  static const addToCartLabelReservedWidth = 114 + 12 + 16 + 24 + 18 + 8;
}
