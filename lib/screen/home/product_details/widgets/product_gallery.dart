import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/net_image.dart';

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
              ? Hero(tag: heroTag, child: NetImage(images[i]))
              : NetImage(images[i]),
        ),
        if (images.length > 1)
          Positioned(
            bottom: AppSpacing.lg,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.micro,
                  ),
                  width: i == imageIndex
                      ? AppSizes.galleryIndicatorActiveWidth
                      : AppSizes.galleryIndicatorWidth,
                  height: AppSizes.galleryIndicatorHeight,
                  decoration: BoxDecoration(
                    color: i == imageIndex
                        ? AppColors.white
                        : AppColors.whiteMuted,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
