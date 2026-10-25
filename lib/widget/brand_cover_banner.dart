import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_assets.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/net_image.dart';

class BrandCoverBanner extends StatelessWidget {
  const BrandCoverBanner({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight =
            MediaQuery.sizeOf(context).height *
            AppSizes.homeBannerMaxHeightFactor;
        final fraction = constraints.maxWidth < Responsive.tablet
            ? AppSizes.homeBannerMobileFraction
            : constraints.maxWidth < Responsive.desktop
            ? AppSizes.homeBannerTabletFraction
            : AppSizes.homeBannerDesktopFraction;
        final pageWidth = math.min(
          constraints.maxWidth * fraction -
              AppSizes.homeBannerPageTabletPadding,
          maxHeight * AppSizes.homeBannerPageAspect,
        );
        final height = pageWidth / AppSizes.homeBannerPageAspect;
        final coverUrl = imageUrl?.trim();
        return Column(
          children: [
            SizedBox(height: AppSizes.homeBannerTopSpace),
            SizedBox(
              height: height,
              child: Center(
                child: SizedBox(
                  width: pageWidth,
                  height: height,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: AppSizes.homeCarouselShadowBlur,
                          offset: Offset(0, AppSizes.homeCarouselShadowOffset),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      child: coverUrl != null && coverUrl.isNotEmpty
                          ? NetImage(coverUrl)
                          : Image.asset(
                              AppAssets.cover,
                              cacheWidth: AppSizes.coverDecodeWidth,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
