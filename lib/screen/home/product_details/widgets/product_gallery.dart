import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/animated_dots.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';
import 'package:souqna_anaqa/widget/net_image.dart';
import 'package:souqna_anaqa/widget/product_hero.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({
    super.key,
    required this.images,
    required this.imageIndex,
    required this.heroTag,
    required this.onPageChanged,
  });

  final List<String> images;
  final int imageIndex;
  final String heroTag;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: images.length,
          onPageChanged: onPageChanged,
          itemBuilder: (_, i) => i == 0
              ? ProductHero(
                  tag: heroTag,
                  radius: AppRadius.lg,
                  child: NetImage(images[i]),
                )
              : NetImage(images[i]),
        ),
        if (images.length > 1)
          Positioned(
            bottom: AppSpacing.lg,
            left: 0,
            right: 0,
            child: Center(
              child: GlassContainer(
                radius: AppRadius.pill,
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: AnimatedDots(
                  count: images.length,
                  index: imageIndex,
                  activeColor: AppColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
