import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/skeleton/skeleton.dart';

class ReviewRowSkeleton extends StatelessWidget {
  const ReviewRowSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Skeleton(
                width: AppSizes.reviewStar,
                height: AppSizes.reviewStar,
                radius: AppRadius.pill,
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(child: Skeleton(height: AppSizes.skeletonTextHeight)),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Skeleton(height: AppSizes.skeletonTextHeight),
          SizedBox(height: AppSpacing.sm),
          FractionallySizedBox(
            widthFactor: AppSizes.skeletonDetailShortWidth,
            child: Skeleton(height: AppSizes.skeletonTextHeight),
          ),
        ],
      ),
    );
  }
}
