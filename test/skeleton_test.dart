import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/loading.dart';

Widget _appWith(Widget child) {
  return ScreenUtilInit(
    designSize: Responsive.designSize,
    builder: (_, _) => MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  testWidgets('product grid skeleton builds without overflow', (tester) async {
    await tester.pumpWidget(_appWith(const ProductGridSkeleton(count: 2)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);
  });

  testWidgets('category chip skeleton builds without overflow', (tester) async {
    await tester.pumpWidget(_appWith(const CategoryChipsSkeleton()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);
  });

  testWidgets('product details skeleton builds without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(_appWith(const ProductDetailsSkeleton()));
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);
  });
}
