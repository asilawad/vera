import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/app_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/home_getx_controller.dart';
import 'package:souqna_anaqa/models/banner_item.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_banner_slide.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home/home_sliver_box.dart';
import 'package:souqna_anaqa/screen/home/product_details_screen.dart';
import 'package:souqna_anaqa/screen/home/product_screen.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/animated_dots.dart';
import 'package:souqna_anaqa/widget/brand_cover_banner.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.controller});

  final HomeGetxController controller;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  PageController _pageController = PageController(
    viewportFraction: AppSizes.homeBannerMobileFraction,
  );
  int _page = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(AppMotion.bannerAutoScroll, (_) {
      if (!mounted) return;
      if (!_pageController.hasClients || widget.controller.banners.length < 2) {
        return;
      }
      _pageController.animateToPage(
        (_page + 1) % widget.controller.banners.length,
        duration: AppMotion.bannerPageTransition,
        curve: AppMotion.standard,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  double _fractionFor(double width) {
    if (width < Responsive.tablet) return AppSizes.homeBannerMobileFraction;
    if (width < Responsive.desktop) return AppSizes.homeBannerTabletFraction;
    return AppSizes.homeBannerDesktopFraction;
  }

  void _syncController(double fraction) {
    if (_pageController.viewportFraction == fraction) return;
    final previous = _pageController;
    _pageController = PageController(
      viewportFraction: fraction,
      initialPage: _page,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        previous.dispose();
        return;
      }
      previous.dispose();
    });
  }

  void _open(BannerItem banner) {
    if (banner.linkType == 'product' && banner.linkId != null) {
      Get.to(() => ProductDetailsScreen(id: banner.linkId!));
    } else if (banner.linkType == 'category' && banner.linkId != null) {
      Get.to(
        () => ProductScreen(
          title: banner.title ?? AppStrings.homeAllProducts,
          categoryId: banner.linkId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final banners = widget.controller.banners.toList();
      if (banners.isEmpty) {
        final cover = Get.find<AppGetxController>().store.value?.cover;
        return HomeSliverBox(child: BrandCoverBanner(imageUrl: cover));
      }
      return HomeSliverBox(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxHeight =
                MediaQuery.sizeOf(context).height *
                AppSizes.homeBannerMaxHeightFactor;
            final fraction = _fractionFor(constraints.maxWidth);
            final pageWidth = math.min(
              constraints.maxWidth * fraction -
                  AppSizes.homeBannerPageTabletPadding,
              maxHeight * AppSizes.homeBannerPageAspect,
            );
            _syncController(
              (pageWidth + AppSizes.homeBannerPageTabletPadding) /
                  constraints.maxWidth,
            );
            final height = pageWidth / AppSizes.homeBannerPageAspect;
            return Column(
              children: [
                SizedBox(height: AppSizes.homeBannerTopSpace),
                SizedBox(
                  height: height,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: banners.length,
                    onPageChanged: (index) => setState(() => _page = index),
                    itemBuilder: (context, index) => AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, _) {
                        var scale = AppSizes.homeBannerMaxScale;
                        if (_pageController.position.haveDimensions) {
                          scale =
                              (AppSizes.homeBannerMaxScale -
                                      ((_pageController.page ?? 0) - index)
                                              .abs() *
                                          AppSizes.homeBannerPageScale)
                                  .clamp(
                                    AppSizes.homeBannerMinScale,
                                    AppSizes.homeBannerMaxScale,
                                  );
                        }
                        return HomeBannerSlide(
                          image: banners[index].image,
                          scale: scale,
                          onTap: () => _open(banners[index]),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.homeBannerDotsGap),
                AnimatedDots(
                  count: banners.length,
                  index: _page,
                  activeColor: AppColors.primary,
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
