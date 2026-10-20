import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/review_row_skeleton.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class ReviewsSkeleton extends StatelessWidget {
  const ReviewsSkeleton({super.key, this.count = AppSizes.skeletonReviewCount});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SkeletonShimmer(
      child: ListView.separated(
        padding: EdgeInsetsDirectional.all(AppSpacing.page),
        itemCount: count,
        separatorBuilder: (_, _) => SizedBox(height: AppSpacing.md),
        itemBuilder: (_, _) => const ReviewRowSkeleton(),
      ),
    );
  }
}
