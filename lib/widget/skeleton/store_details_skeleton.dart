import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class StoreDetailsSkeleton extends StatelessWidget {
  const StoreDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.bannerSkeletonHeight,
              child: const Skeleton(radius: AppRadius.none),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsDirectional.all(AppSpacing.page),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Skeleton(
                      width: AppSizes.reviewStar,
                      height: AppSizes.reviewStar,
                      radius: AppRadius.pill,
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Skeleton(height: AppSizes.skeletonTextHeight),
                    ),
                  ],
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
                Skeleton(height: AppSizes.chipHeight),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
