import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_brand.dart';

class AppColors {
  AppColors._();

  // هوية Vera (المصدر الوحيد: AppBrand)
  static const Color primary = AppBrand.burgundy;
  static const Color primaryDeep = Color(0xFF4A1021);
  static const Color gold = AppBrand.gold;
  static const Color goldDark = Color(
    0xFFA8832F,
  ); // للنصوص الذهبية على الخلفيات الفاتحة
  static const Color cream = AppBrand.cream;
  static const Color star =
      AppBrand.gold; // بدل 0xFFF5A623 المكتوب في عدة ملفات

  static const Color ink = Color(0xFF1C1416);
  static const Color paper = AppBrand.cream;
  static const Color surface = Colors.white;
  static const Color white = Colors.white;
  static const Color whiteMuted = Color(0x8AFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x14000000);
  static const Color sand = Color(0xFFF3EBE4);
  static const Color line = Color(0xFFE7DDD3);
  static const Color muted = Color(0xFF6F6368);
  static const Color subtle = Color(0xFFA39A9D);
  static const Color success = Color(0xFF2F7D5B);
  static const Color danger = Color(0xFFC62828);
  static const Color warning = Color(0xFFD9822B);
  static const Color dangerSurface = Color(0x1AC62828);
}

class AppTheme {
  AppTheme._();

  /// [primary] اختياري: بدونه يُستخدم عنابي Vera. التطبيق حاليا يمرر لون المتجر من الباكند.
  static ThemeData build([Color primary = AppColors.primary]) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: AppColors.gold,
      surface: AppColors.surface,
      brightness: Brightness.light,
    ).copyWith(onPrimary: _onColor(primary));

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Plex',
      scaffoldBackgroundColor: AppColors.paper,
      splashFactory: InkSparkle.splashFactory,
    );

    return base.copyWith(
      // 1.sp = مقياس الخط المحدود من Responsive.fontSize (للنصوص بلا حجم صريح).
      // نبدأ من أحجام Material للعربية (tall2021) لأن base.textTheme بلا أحجام بعد.
      textTheme: Typography.tall2021
          .merge(base.textTheme)
          .apply(
            bodyColor: AppColors.ink,
            displayColor: AppColors.ink,
            fontSizeFactor: 1.sp,
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Plex',
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: AppColors.subtle, fontSize: 14.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: _onColor(primary),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyle(
            fontFamily: 'Plex',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: TextStyle(
            fontFamily: 'Plex',
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.line),
        labelStyle: const TextStyle(
          fontFamily: 'Plex',
          fontWeight: FontWeight.w600,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(
          fontFamily: 'Plex',
          color: AppColors.cream,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// نص كريمي أو أسود حسب سطوع اللون.
  static Color _onColor(Color c) =>
      c.computeLuminance() > 0.5 ? AppColors.ink : AppColors.cream;
}
