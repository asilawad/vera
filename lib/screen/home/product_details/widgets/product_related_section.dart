import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/product_card.dart';
import 'package:souqna_anaqa/widget/product_grid.dart';

class ProductRelatedSection extends StatelessWidget {
  const ProductRelatedSection({
    super.key,
    required this.products,
    required this.heroPrefix,
  });

  final List<Product> products;
  final String heroPrefix;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpacing.xxl),
        Text(
          AppStrings.recommendations,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: AppSpacing.md),
        HorizontalProducts(
          padding: EdgeInsets.zero,
          itemWidth: AppSizes.relatedProductWidth,
          itemCount: products.length,
          itemBuilder: (_, index) =>
              ProductCard(products[index], heroPrefix: heroPrefix),
        ),
      ],
    );
  }
}
