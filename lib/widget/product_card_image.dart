import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/discount_badge.dart';
import 'package:souqna_anaqa/widget/favorite_icon.dart';
import 'package:souqna_anaqa/widget/net_image.dart';

class ProductCardImage extends StatelessWidget {
  const ProductCardImage({
    super.key,
    required this.product,
    required this.heroPrefix,
    required this.aspectRatio,
  });

  final Product product;
  final String heroPrefix;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: '$heroPrefix-${product.id}',
              child: NetImage(
                product.thumb ?? product.image,
                radius: AppRadius.card,
              ),
            ),
          ),
          if (product.discountPercent != null)
            PositionedDirectional(
              top: AppSpacing.compact,
              end: AppSpacing.compact,
              child: DiscountBadge(
                percent: product.discountPercent!,
                compact: true,
              ),
            ),
          PositionedDirectional(
            top: AppSpacing.sm,
            start: AppSpacing.sm,
            child: FavoriteIcon(product, size: AppSizes.favoriteButton),
          ),
          if (!product.inStock)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.unavailableProductOverlay,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    AppStrings.outOfStock,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSizes.productStockFont.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
