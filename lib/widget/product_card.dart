import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/product_card_image.dart';
import 'package:souqna_anaqa/widget/product_hero.dart';
import 'package:souqna_anaqa/widget/price_tag.dart';
import 'package:souqna_anaqa/screen/home/product_details_screen.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';

/// بطاقة المنتج في القوائم: صورة كبيرة، خصم، مفضلة، اسم، سعر، تقييم.
class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    super.key,
    this.heroPrefix = AppStrings.heroProductDefault,
    this.imageAspect = gridImageAspect,
  });

  /// نسب الصور من فيجما: الشبكة 164×195، والقوائم الأفقية 168×220.
  static const gridImageAspect = AppSizes.productGridImageAspect;
  static const railImageAspect = AppSizes.productRailImageAspect;

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
          hero: ProductHero.tagFor(heroPrefix, product.id),
        ),
        preventDuplicates: false,
        transition: Transition.fadeIn,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : AppMotion.slow,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.line),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: AppSizes.cardShadowBlur,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.all(AppSizes.productHeaderInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductCardImage(
                product: product,
                heroPrefix: heroPrefix,
                aspectRatio: imageAspect,
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
              Text(
                product.name,
                maxLines: AppSizes.productNameMaxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSizes.productNameFont.sp,
                  fontWeight: FontWeight.w600,
                  height: AppSizes.productNameLineHeight,
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
        ),
      ),
    );
  }
}
