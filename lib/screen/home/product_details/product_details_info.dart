import 'package:flutter/material.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_attributes_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_description_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_header_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_options_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_related_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_reviews_section.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';

class ProductDetailsInfo extends StatelessWidget {
  const ProductDetailsInfo({
    super.key,
    required this.id,
    required this.product,
    required this.related,
    required this.reviews,
    required this.reviewsLoading,
    required this.reviewsController,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
  });

  final int id;
  final Product product;
  final List<Product> related;
  final ReviewsSummary? reviews;
  final bool reviewsLoading;
  final ProductDetailsGetxController reviewsController;
  final String? selectedSize;
  final String? selectedColor;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<String> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductHeaderSection(product: product, reviews: reviews),
        ProductOptionsSection(
          sizes: product.sizes,
          colors: product.colors,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
          onSizeSelected: onSizeSelected,
          onColorSelected: onColorSelected,
        ),
        if (product.description != null)
          ProductDescriptionSection(description: product.description!),
        ProductAttributesSection(
          attributes: product.attributesDisplay
              .where(
                (attribute) =>
                    attribute.type != 'color' && attribute.key != 'sizes',
              )
              .toList(),
        ),
        SizedBox(height: AppSpacing.xl),
        ProductReviewsSection(
          productId: product.id,
          summary: reviews,
          loading: reviewsLoading,
          controller: reviewsController,
        ),
        ProductRelatedSection(products: related, heroPrefix: 'rel$id'),
      ],
    );
  }
}
