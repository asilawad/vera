import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/product_card.dart';

class HomeHorizontalProducts extends StatelessWidget {
  const HomeHorizontalProducts({
    super.key,
    required this.products,
    required this.hero,
  });

  final List<Product> products;
  final String hero;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final cardContentWidth =
        AppSizes.homeProductRailWidth - AppSizes.productHeaderInset * 2;
    final imageHeight = cardContentWidth / ProductCard.railImageAspect;
    final textHeight = textScaler.scale(
      AppSizes.productCategoryFont.sp * AppSizes.productNameLineHeight +
          AppSizes.productNameFont.sp *
              AppSizes.productNameLineHeight *
              AppSizes.productNameMaxLines +
          AppSizes.productPriceFont.sp *
              AppSizes.productNameLineHeight *
              AppSizes.homeProductPriceMaxLines,
    );
    final railHeight =
        AppSizes.productHeaderInset +
        AppSizes.productHeaderInset +
        imageHeight +
        AppSpacing.compact +
        textHeight +
        AppSpacing.xs;
    return SizedBox(
      height: railHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.page),
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.only(
            end: index == products.length - 1 ? 0 : AppSpacing.md,
          ),
          child: SizedBox(
            width: AppSizes.homeProductRailWidth,
            child: ProductCard(
              products[index],
              heroPrefix: hero,
              imageAspect: ProductCard.railImageAspect,
            ),
          ),
        ),
      ),
    );
  }
}
