import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/home_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_sliver_box.dart';
import 'package:souqna_anaqa/screen/home/product_screen.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/product_card.dart';
import 'package:souqna_anaqa/widget/product_grid.dart';
import 'package:souqna_anaqa/widget/section_header.dart';

class HomeNewestSection extends StatelessWidget {
  const HomeNewestSection({super.key, required this.controller});

  final HomeGetxController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.newest.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox());
      }
      return SliverMainAxisGroup(
        slivers: [
          HomeSliverBox(
            child: SectionHeader(
              AppStrings.homeNewest,
              onMore: () => Get.to(
                () => const ProductScreen(title: AppStrings.homeNewest),
              ),
            ),
          ),
          SliverProductGrid(
            itemCount: controller.newest.length,
            maxRows: AppSizes.homeFeaturedMaxRows,
            itemBuilder: (_, index) => ProductCard(
              controller.newest[index],
              heroPrefix: AppStrings.heroNewest,
            ),
          ),
        ],
      );
    });
  }
}
