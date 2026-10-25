import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/product_skeletons.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class BannerSkeleton extends StatelessWidget {
  const BannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: AspectRatio(
        aspectRatio: AppSizes.skeletonBannerAspectRatio,
        child: Skeleton(radius: AppRadius.card),
      ),
    );
  }
}

class CategoryChipsSkeleton extends StatelessWidget {
  const CategoryChipsSkeleton({
    super.key,
    this.count = AppSizes.skeletonCategoryCount,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SizedBox(
        height: AppSizes.chipHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: count,
          separatorBuilder: (_, _) => SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, _) => Skeleton(
            width: AppSizes.categorySkeletonWidth,
            height: AppSizes.chipHeight,
            radius: AppRadius.chip,
          ),
        ),
      ),
    );
  }
}

class ProductRowSkeleton extends StatelessWidget {
  const ProductRowSkeleton({
    super.key,
    this.count = AppSizes.skeletonProductRowCount,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < count; index++) ...[
              if (index > 0) SizedBox(width: AppSpacing.md),
              SizedBox(
                width: AppSizes.relatedProductWidth,
                child: const ProductCardSkeleton(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
