import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/favorite_icon.dart';
import 'package:souqna_anaqa/widget/discount_badge.dart';
import 'package:souqna_anaqa/widget/net_image.dart';
import 'package:souqna_anaqa/widget/price_tag.dart';
import 'package:souqna_anaqa/screen/home/product_details_screen.dart';

/// بطاقة المنتج في القوائم: صورة كبيرة، خصم، مفضلة، اسم، سعر، تقييم.
class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    super.key,
    this.heroPrefix = 'p',
    this.imageAspect = gridImageAspect,
  });

  /// نسب الصور من فيجما: الشبكة 164×195، والقوائم الأفقية 168×220.
  static const gridImageAspect = 164 / 195;
  static const railImageAspect = 168 / 220;

  final Product product;
  final String heroPrefix;
  final double imageAspect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailsScreen(
          id: product.id,
          product: product,
          hero: '$heroPrefix-${product.id}',
        ),
        preventDuplicates: false,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: imageAspect,
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
                    start: AppSpacing.compact,
                    child: DiscountBadge(
                      percent: product.discountPercent!,
                      compact: true,
                    ),
                  ),
                PositionedDirectional(
                  top: AppSpacing.sm,
                  end: AppSpacing.sm,
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
                        padding: EdgeInsets.symmetric(
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
          ),
          SizedBox(height: AppSpacing.compact),
          if (product.categoryName != null)
            Text(
              product.categoryName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppSizes.productCategoryFont.sp,
                color: AppColors.subtle,
              ),
            ),
          // سطران للاسم: الأسماء العربية الطويلة شائعة، وارتفاع الصف يتبع المحتوى.
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppSizes.productNameFont.sp,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: PriceTag(product, size: AppSizes.productPriceFont),
              ),
              if (product.ratingCount > 0) ...[
                Icon(
                  Icons.star_rounded,
                  size: AppSizes.ratingStar.sp,
                  color: AppColors.star,
                ),
                SizedBox(width: AppSpacing.xxs),
                Text(
                  product.ratingAverage.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: AppSizes.productRatingFont.sp,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
