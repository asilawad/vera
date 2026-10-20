import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/home_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_sliver_box.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/screen/home/product_screen.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/category_chip_list.dart';
import 'package:souqna_anaqa/widget/section_header.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key, required this.controller});

  final HomeGetxController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox());
      }
      return HomeSliverBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              AppStrings.homeShopByCategory,
              onMore: () =>
                  MainScreenController.to.go(AppSizes.homeCategoryTabIndex),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.page,
              ),
              child: CategoryChipList(
                categories: controller.categories.toList(),
                selectedId: null,
                onSelected: (id) {
                  if (id == null) {
                    Get.to(
                      () => const ProductScreen(
                        title: AppStrings.homeAllProducts,
                      ),
                    );
                    return;
                  }
                  final category = controller.categories.firstWhere(
                    (item) => item.id == id,
                  );
                  Get.to(
                    () => ProductScreen(
                      title: category.name,
                      categoryId: category.id,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
