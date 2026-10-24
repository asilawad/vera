import 'package:flutter/widgets.dart';

abstract final class AppAssets {
  static const String _basePath = 'assets/brand/';

  static const String appIcon = '${_basePath}app_icon.png';
  static const String adaptiveForeground =
      '${_basePath}adaptive_foreground.png';
  static const String monochrome = '${_basePath}monochrome.png';
  static const String cover = '${_basePath}vera_cover.png';

  static const String splashLogo = '${_basePath}splash_logo.png';
  static const String logoMark = splashLogo;
  static const String logoIcon = appIcon;
  static const String headerLogo = appIcon;

  static Future<void> precacheBrand(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage(splashLogo), context),
      precacheImage(const AssetImage(cover), context),
      if (headerLogo != splashLogo)
        precacheImage(const AssetImage(headerLogo), context),
    ]);
  }
}
