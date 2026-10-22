import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';

void main() {
  testWidgets('GlassAppBar displays its title', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Responsive.designSize,
        builder: (_, _) => const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(title: Text('Glass title')),
            body: SizedBox(),
          ),
        ),
      ),
    );
    expect(find.text('Glass title'), findsOneWidget);
  });
}
