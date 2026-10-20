import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
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
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(height: AppSpacing.xs),
        Text(
          product.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
        SizedBox(height: AppSpacing.compact),
        Row(
          children: [
            Expanded(
              child: PriceView(product, size: AppSizes.productPriceFontSize),
            ),
            if (product.discountPercent != null)
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.compact,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.dangerSurface,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  AppStrings.discountPercent.replaceAll(
                    '{percent}',
                    '${product.discountPercent}',
                  ),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.danger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: AppSpacing.compact),
        Row(
          children: [
            if (reviews != null && reviews!.count > 0) ...[
              Stars(reviews!.average),
              SizedBox(width: AppSpacing.xs),
              Text(
                AppStrings.reviewSummary
                    .replaceAll(
                      '{average}',
                      reviews!.average.toStringAsFixed(1),
                    )
                    .replaceAll('{count}', '${reviews!.count}'),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
              ),
              SizedBox(width: AppSpacing.md),
            ],
            Icon(
              product.inStock
                  ? Icons.check_circle_rounded
                  : Icons.cancel_rounded,
              size: AppSizes.smallIcon,
              color: product.inStock ? AppColors.success : AppColors.danger,
            ),
            SizedBox(width: AppSpacing.xs),
            Text(
              !product.inStock
                  ? AppStrings.outOfStock
                  : (product.stock <= 5
                        ? AppStrings.lowStock.replaceAll(
                            '{count}',
                            '${product.stock}',
                          )
                        : AppStrings.inStock),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: product.inStock
                    ? (product.stock <= 5
                          ? AppColors.warning
                          : AppColors.success)
                    : AppColors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
