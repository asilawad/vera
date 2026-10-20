import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/price.dart';

class ProductHeaderSection extends StatelessWidget {
  const ProductHeaderSection({
    super.key,
    required this.product,
    required this.reviews,
  });

  final Product product;
  final ReviewsSummary? reviews;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.categoryName != null)
          Text(
            product.categoryName!,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        const SizedBox(height: 4),
        Text(
          product.name,
          style: TextStyle(
            fontSize: 23.sp,
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: PriceView(product, size: 22)),
            if (product.discountPercent != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  AppStrings.discountPercent.replaceAll(
                    '{percent}',
                    '${product.discountPercent}',
                  ),
                  style: TextStyle(
                    color: AppColors.danger,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            if (reviews != null && reviews!.count > 0) ...[
              Stars(reviews!.average),
              const SizedBox(width: 6),
              Text(
                AppStrings.reviewSummary
                    .replaceAll(
                      '{average}',
                      reviews!.average.toStringAsFixed(1),
                    )
                    .replaceAll('{count}', '${reviews!.count}'),
                style: TextStyle(color: AppColors.muted, fontSize: 13.sp),
              ),
              const SizedBox(width: 14),
            ],
            Icon(
              product.inStock
                  ? Icons.check_circle_rounded
                  : Icons.cancel_rounded,
              size: 16,
              color: product.inStock ? AppColors.success : AppColors.danger,
            ),
            const SizedBox(width: 4),
            Text(
              !product.inStock
                  ? AppStrings.outOfStock
                  : (product.stock <= 5
                        ? AppStrings.lowStock.replaceAll(
                            '{count}',
                            '${product.stock}',
                          )
                        : AppStrings.inStock),
              style: TextStyle(
                color: product.inStock
                    ? (product.stock <= 5
                          ? AppColors.warning
                          : AppColors.success)
                    : AppColors.danger,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
