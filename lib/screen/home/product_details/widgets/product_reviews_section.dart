import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_review_sheet.dart';
import 'package:souqna_anaqa/screen/home/reviews_screen.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/price.dart';
import 'package:souqna_anaqa/widget/review_card.dart';

class ProductReviewsSection extends StatelessWidget {
  const ProductReviewsSection({
    super.key,
    required this.productId,
    required this.summary,
    required this.loading,
    required this.controller,
  });

  final int productId;
  final ReviewsSummary? summary;
  final bool loading;
  final ProductDetailsGetxController controller;

  @override
  Widget build(BuildContext context) {
    final reviews = summary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.reviewsTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton.icon(
              onPressed: () => ProductReviewSheet.show(
                context,
                productId: productId,
                controller: controller,
              ),
              icon: Icon(
                Icons.rate_review_outlined,
                size: AppSizes.compactIcon,
              ),
              label: Text(AppStrings.addReview),
            ),
          ],
        ),
        if (reviews == null || reviews.count == 0)
          Text(
            loading ? AppStrings.reviewsLoading : AppStrings.noReviewsYet,
            style: const TextStyle(color: AppColors.muted),
          )
        else ...[
          _ReviewSummaryCard(summary: reviews),
          SizedBox(height: AppSpacing.md),
          ...reviews.latest.map(ReviewCard.new),
          if (reviews.count > reviews.latest.length)
            Center(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Get.to(() => ReviewsScreen(productId: productId)),
                icon: Icon(Icons.reviews_outlined, size: AppSizes.compactIcon),
                label: Text(
                  AppStrings.showAllReviews.replaceAll(
                    '{count}',
                    '${reviews.count}',
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _ReviewSummaryCard extends StatelessWidget {
  const _ReviewSummaryCard({required this.summary});

  final ReviewsSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                summary.average.toStringAsFixed(1),
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              Stars(summary.average),
              SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.reviewCount.replaceAll(
                  '{count}',
                  '${summary.count}',
                ),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
          SizedBox(width: AppSpacing.page),
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((rating) {
                final count = summary.distribution[rating] ?? 0;
                return Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: AppSpacing.micro,
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.ratingValue.replaceAll(
                          '{rating}',
                          '$rating',
                        ),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          child: LinearProgressIndicator(
                            value: summary.count == 0
                                ? 0
                                : count / summary.count,
                            minHeight: AppSizes.reviewProgressHeight,
                            backgroundColor: AppColors.sand,
                            color: AppColors.star,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
