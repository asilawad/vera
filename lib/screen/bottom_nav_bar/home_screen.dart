import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/home_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_banner_carousel.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_categories_section.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_header.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_horizontal_section.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_newest_section.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_skeleton.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_sliver_box.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/app_search_bar.dart';
import 'package:souqna_anaqa/widget/states.dart';
import 'package:souqna_anaqa/screen/home/product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeGetxController>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (home.isLoading.value) return const HomeSkeleton();
          if (home.errorMessage.value.isNotEmpty) {
            return Obx(() {
              if (home.featured.isEmpty && home.newest.isEmpty) {
                return ErrorView(
                  message: home.errorMessage.value,
                  onRetry: home.fetchHome,
                );
              }
              return _HomeFeed(home);
            });
          }
          return _HomeFeed(home);
        }),
      ),
    );
  }
}

class _HomeFeed extends StatelessWidget {
  const _HomeFeed(this.controller);

  final HomeGetxController controller;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: controller.fetchHome,
    child: CustomScrollView(
      slivers: [
        const HomeSliverBox(child: HomeHeader()),
        HomeSliverBox(
          child: AppSearchBar(
            hint: AppStrings.searchHint,
            onTap: () => Get.to(
              () => const ProductScreen(
                title: AppStrings.homeSearch,
                search: true,
              ),
            ),
          ),
        ),
        HomeBannerCarousel(controller: controller),
        HomeCategoriesSection(controller: controller),
        HomeHorizontalSection(
          products: controller.featured,
          title: AppStrings.homeFeatured,
          subtitle: AppStrings.homeFeaturedSubtitle,
          hero: AppStrings.heroFeatured,
          featured: true,
        ),
        HomeNewestSection(controller: controller),
        HomeHorizontalSection(
          products: controller.bestSellers,
          title: AppStrings.homeBestSellers,
          subtitle: AppStrings.homeBestSellersSubtitle,
          hero: AppStrings.heroBestSellers,
          sort: AppStrings.sortBestSelling,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Responsive.bottomClearance(context, AppSpacing.xl),
          ),
        ),
      ],
    ),
  );
}
