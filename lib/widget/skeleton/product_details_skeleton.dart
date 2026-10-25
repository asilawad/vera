import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ListView(
        padding: EdgeInsetsDirectional.all(AppSpacing.page),
        children: [
          AspectRatio(
            aspectRatio: AppSizes.skeletonBannerAspectRatio,
            child: Skeleton(radius: AppRadius.card),
          ),
          SizedBox(height: AppSpacing.lg),
          FractionallySizedBox(
            widthFactor: AppSizes.skeletonDetailTitleWidth,
            alignment: AlignmentDirectional.centerStart,
            child: Skeleton(height: AppSizes.skeletonTextHeight),
          ),
          SizedBox(height: AppSpacing.sm),
          FractionallySizedBox(
            widthFactor: AppSizes.skeletonDetailShortWidth,
            alignment: AlignmentDirectional.centerStart,
            child: Skeleton(height: AppSizes.skeletonTextHeight),
          ),
          SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            children: List.generate(
              AppSizes.skeletonDetailOptionCount,
              (_) => Skeleton(
                width: AppSizes.categorySkeletonWidth,
                height: AppSizes.chipHeight,
                radius: AppRadius.chip,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          for (
            var line = 0;
            line < AppSizes.skeletonStoreTextLines;
            line++
          ) ...[
            FractionallySizedBox(
              widthFactor: AppSizes.skeletonDetailLineWidth,
              alignment: AlignmentDirectional.centerStart,
              child: Skeleton(height: AppSizes.skeletonTextHeight),
            ),
            SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}
