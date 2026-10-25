import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/add_to_cart_button.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/animated_check.dart';
import 'package:souqna_anaqa/widget/animated_dots.dart';

Widget _testApp(Widget child) => ScreenUtilInit(
  designSize: Responsive.designSize,
  builder: (_, _) => MaterialApp(
    home: Scaffold(body: Center(child: child)),
  ),
);

void main() {
  testWidgets('add button shows check when added', (tester) async {
    await tester.pumpWidget(
      _testApp(
        const AddToCartButton(
          label: AppStrings.addedToCart,
          isSubmitting: false,
          isAdded: true,
          onPressed: _noop,
        ),
      ),
    );

    expect(find.byType(AnimatedCheck), findsOneWidget);
  });

  testWidgets('add button shows spinner while submitting', (tester) async {
    await tester.pumpWidget(
      _testApp(
        const AddToCartButton(
          label: AppStrings.addedToCart,
          isSubmitting: true,
          onPressed: _noop,
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('animated dots build for one and three items', (tester) async {
    await tester.pumpWidget(
      _testApp(
        const AnimatedDots(count: 1, index: 0, activeColor: AppColors.danger),
      ),
    );
    expect(find.byType(AnimatedDots), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsOneWidget);

    await tester.pumpWidget(
      _testApp(
        const AnimatedDots(count: 3, index: 1, activeColor: AppColors.danger),
      ),
    );
    expect(find.byType(AnimatedDots), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsNWidgets(3));
  });
}

void _noop() {}
