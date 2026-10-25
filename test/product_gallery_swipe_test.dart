import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:souqna_anaqa/screen/home/product_details/widgets/product_gallery.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/glass_sliver_app_bar.dart';

void main() {
  testWidgets('product gallery responds to horizontal swipes', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var changedPage = -1;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: Responsive.designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: Responsive.fontSize,
        builder: (context, _) {
          Responsive.capScale(context);
          return MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  GlassSliverAppBar(
                    expandedHeight: 360,
                    background: ProductGallery(
                      images: const ['', '', ''],
                      imageIndex: 0,
                      heroTag: 'gallery-test',
                      onPageChanged: (index) => changedPage = index,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 640)),
                ],
              ),
            ),
          );
        },
      ),
    );
    await tester.pump();

    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(changedPage, 1);
  });
}
