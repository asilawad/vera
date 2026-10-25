import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/screen/home/product_details/product_details_info.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_bottom_bar.dart';
import 'package:souqna_anaqa/screen/home/product_details/product_details_layout.dart';

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({
    super.key,
    required this.id,
    required this.heroTag,
    required this.product,
    required this.related,
    required this.reviews,
    required this.reviewsLoading,
    required this.reviewsController,
    required this.quantity,
    required this.cartController,
    required this.isAdded,
    required this.imageIndex,
    required this.selectedSize,
    required this.selectedColor,
    required this.onImageChanged,
    required this.onQuantityChanged,
    required this.onSizeSelected,
    required this.onColorSelected,
    required this.onAddToCart,
  });

  final int id;
  final String heroTag;
  final Product product;
  final List<Product> related;
  final ReviewsSummary? reviews;
  final bool reviewsLoading;
  final ProductDetailsGetxController reviewsController;
  final int quantity;
  final CartGetxController cartController;
  final bool isAdded;
  final int imageIndex;
  final String? selectedSize;
  final String? selectedColor;
  final ValueChanged<int> onImageChanged;
  final ValueChanged<int> onQuantityChanged;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<String> onColorSelected;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    final images = product.images.isNotEmpty
        ? product.images
        : [if (product.image != null) product.image!];
    final details = ProductDetailsInfo(
      id: id,
      product: product,
      related: related,
      reviews: reviews,
      reviewsLoading: reviewsLoading,
      reviewsController: reviewsController,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      onSizeSelected: onSizeSelected,
      onColorSelected: onColorSelected,
    );
    final bottomBar = Obx(
      () => ProductBottomBar(
        product: product,
        quantity: quantity,
        onQuantityChanged: onQuantityChanged,
        isSubmitting: cartController.isSubmitting.value,
        isAdded: isAdded,
        onAddToCart: onAddToCart,
      ),
    );

    return ProductDetailsLayout(
      product: product,
      images: images,
      heroTag: heroTag,
      imageIndex: imageIndex,
      onImageChanged: onImageChanged,
      details: details,
      bottomBar: bottomBar,
    );
  }
}
