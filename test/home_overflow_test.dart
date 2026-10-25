import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/favorites_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/home_getx_controller.dart';
import 'package:souqna_anaqa/models/category.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_categories_section.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_horizontal_products.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/product_card.dart';

class _FakeFavoritesController extends FavoritesGetxController {
  @override
  void onInit() {}
}

void main() {
  const sizes = [Size(360, 640), Size(400, 554), Size(412, 915)];
  const textScales = [1.0, 1.3, 1.5];

  for (final size in sizes) {
    for (final textScale in textScales) {
      testWidgets(
        'home content fits ${size.width}x${size.height} at $textScale text scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          Get.put<FavoritesGetxController>(_FakeFavoritesController());
          addTearDown(Get.reset);

          final home = HomeGetxController()
            ..categories.addAll([
              Category(id: 1, name: 'Sportswear'),
              Category(id: 2, name: 'Accessories'),
            ]);
          final products = [
            Product(
              id: 1,
              name: 'A breathable quick-dry training shirt',
              categoryName: 'Sportswear',
              price: 65,
              finalPrice: 65,
              stock: 4,
            ),
          ];

          await tester.pumpWidget(
            ScreenUtilInit(
              designSize: Responsive.designSize,
              minTextAdapt: true,
              splitScreenMode: true,
              fontSizeResolver: Responsive.fontSize,
              builder: (context, _) {
                Responsive.capScale(context);
                return MaterialApp(
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.linear(textScale)),
                    child: child!,
                  ),
                  home: Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        HomeCategoriesSection(controller: home),
                        SliverToBoxAdapter(
                          child: HomeHorizontalProducts(
                            products: products,
                            hero: 'home-overflow',
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: 180,
                            child: ProductCard(products.first),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
          await tester.pump();

          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}
