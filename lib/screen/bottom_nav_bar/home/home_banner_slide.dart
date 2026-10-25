import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/net_image.dart';

class HomeBannerSlide extends StatelessWidget {
  const HomeBannerSlide({
    super.key,
    required this.image,
    required this.scale,
    required this.onTap,
  });

  final String? image;
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppSizes.homeBannerPageGap,
          ),
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
            child: NetImage(image, radius: AppRadius.card),
          ),
        ),
      ),
    );
  }
}
