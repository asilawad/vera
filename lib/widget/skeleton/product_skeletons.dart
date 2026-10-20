import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/product_card.dart';
import 'package:souqna_anaqa/widget/product_grid.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class ProductGridSkeleton extends StatelessWidget {
  const ProductGridSkeleton({
    super.key,
    this.count = AppSizes.productGridSkeletonCount,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ProductGrid(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        top: AppSpacing.lg,
        itemCount: count,
        itemBuilder: (_, _) => const ProductCardSkeleton(),
      ),
    );
  }
}

class ProductCardSkeleton extends StatelessWidget {
  const ProductCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: ProductCard.gridImageAspect,
          child: Skeleton(radius: AppRadius.card),
        ),
        SizedBox(height: AppSpacing.compact),
        FractionallySizedBox(
          widthFactor: AppSizes.skeletonProductTitleWidth,
          child: Skeleton(height: AppSizes.skeletonTextHeight),
        ),
        SizedBox(height: AppSpacing.xs),
        FractionallySizedBox(
          widthFactor: AppSizes.skeletonProductPriceWidth,
          child: Skeleton(height: AppSizes.skeletonTextHeight),
        ),
      ],
    );
  }
}
