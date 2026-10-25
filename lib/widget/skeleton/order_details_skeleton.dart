import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class OrderDetailsSkeleton extends StatelessWidget {
  const OrderDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ListView(
        padding: EdgeInsetsDirectional.all(AppSpacing.page),
        children: [
          Skeleton(height: AppSizes.orderSkeletonStatusHeight),
          SizedBox(height: AppSpacing.lg),
          for (
            var item = 0;
            item < AppSizes.skeletonOrderItemCount;
            item++
          ) ...[
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
                      Skeleton(height: AppSizes.skeletonTextHeight),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}
