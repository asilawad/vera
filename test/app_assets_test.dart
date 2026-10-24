import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:souqna_anaqa/utils/app_assets.dart';

void main() {
  test('brand asset constants point to existing files declared by pubspec', () {
    final paths = [
      AppAssets.appIcon,
      AppAssets.adaptiveForeground,
      AppAssets.monochrome,
      AppAssets.splashLogo,
      AppAssets.logoMark,
      AppAssets.logoIcon,
      AppAssets.headerLogo,
    ];
    for (final path in paths) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }

    expect(File('pubspec.yaml').readAsStringSync(), contains('assets/brand/'));
  });
}
