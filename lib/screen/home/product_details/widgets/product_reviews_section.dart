import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_review_sheet.dart';
import 'package:souqna_anaqa/screen/home/reviews_screen.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
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
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
              ),
            ),
            TextButton.icon(
              onPressed: () => ProductReviewSheet.show(
                context,
                productId: productId,
                controller: controller,
              ),
              icon: const Icon(Icons.rate_review_outlined, size: 18),
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
          const SizedBox(height: 12),
          ...reviews.latest.map(ReviewCard.new),
          if (reviews.count > reviews.latest.length)
            Center(
              child: OutlinedButton.icon(
                onPressed: () =>
                    Get.to(() => ReviewsScreen(productId: productId)),
                icon: const Icon(Icons.reviews_outlined, size: 18),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                summary.average.toStringAsFixed(1),
                style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w700),
              ),
              Stars(summary.average),
              const SizedBox(height: 4),
              Text(
                AppStrings.reviewCount.replaceAll(
                  '{count}',
                  '${summary.count}',
                ),
                style: TextStyle(color: AppColors.muted, fontSize: 12.sp),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [5, 4, 3, 2, 1].map((rating) {
                final count = summary.distribution[rating] ?? 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.ratingValue.replaceAll(
                          '{rating}',
                          '$rating',
                        ),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: summary.count == 0
                                ? 0
                                : count / summary.count,
                            minHeight: 6,
                            backgroundColor: AppColors.sand,
                            color: const Color(0xFFF5A623),
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
