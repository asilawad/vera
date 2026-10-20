import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class CartSkeleton extends StatelessWidget {
  const CartSkeleton({super.key, this.count = AppSizes.skeletonCartCount});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ListView(
        padding: EdgeInsetsDirectional.all(AppSpacing.page),
        children: [
          for (var item = 0; item < count; item++) ...[
            Row(
              children: [
                Skeleton(
                  width: AppSizes.cartSkeletonImage,
                  height: AppSizes.cartSkeletonImage,
                  radius: AppRadius.md,
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    children: [
                      Skeleton(height: AppSizes.skeletonTextHeight),
                      SizedBox(height: AppSpacing.sm),
                      FractionallySizedBox(
                        widthFactor: AppSizes.skeletonDetailShortWidth,
                        alignment: AlignmentDirectional.centerStart,
                        child: Skeleton(height: AppSizes.skeletonTextHeight),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),
          ],
          Skeleton(height: AppSizes.cartSkeletonSummaryHeight),
        ],
      ),
    );
  }
}
