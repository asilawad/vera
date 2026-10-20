import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_horizontal_products.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_sliver_box.dart';
import 'package:souqna_anaqa/screen/home/product_screen.dart';
import 'package:souqna_anaqa/widget/section_header.dart';

class HomeHorizontalSection extends StatelessWidget {
  const HomeHorizontalSection({
    super.key,
    required this.products,
    required this.title,
    required this.hero,
    this.subtitle,
    this.featured = false,
    this.sort,
  });

  final RxList<Product> products;
  final String title;
  final String hero;
  final String? subtitle;
  final bool featured;
  final String? sort;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = products.toList();
      if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox());
      return HomeSliverBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title,
              subtitle: subtitle,
              onMore: () => Get.to(
                () =>
                    ProductScreen(title: title, featured: featured, sort: sort),
              ),
            ),
            HomeHorizontalProducts(products: items, hero: hero),
          ],
        ),
      );
    });
  }
}
