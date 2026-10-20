import 'package:flutter/material.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/models/review.dart';
import 'package:souqna_anaqa/screen/home/product_details/product_details_info.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_bottom_bar.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_gallery.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/favorite_icon.dart';

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
    required this.isSubmitting,
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
  final bool isSubmitting;
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
    final screenSize = MediaQuery.sizeOf(context);
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
    final bottomBar = ProductBottomBar(
      product: product,
      quantity: quantity,
      onQuantityChanged: onQuantityChanged,
      isSubmitting: isSubmitting,
      onAddToCart: onAddToCart,
    );

    if (screenSize.width >= AppSizes.twoPaneWidth) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: AppSpacing.md),
              child: FavoriteIcon(product, size: 40),
            ),
          ],
        ),
        body: MaxWidthBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xl,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    AppSpacing.xl,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1 / 1.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: ProductGallery(
                        images: images,
                        imageIndex: imageIndex,
                        heroTag: heroTag,
                        onPageChanged: onImageChanged,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xl,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    120 + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: details,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: bottomBar,
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: (screenSize.width * 1.1).clamp(
              0,
              screenSize.height * 0.6,
            ),
            pinned: true,
            backgroundColor: AppColors.paper,
            leading: Padding(
              padding: EdgeInsetsDirectional.all(AppSpacing.sm),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: BackButton(color: AppColors.ink),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.all(AppSpacing.sm),
                child: FavoriteIcon(product, size: 40),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ProductGallery(
                images: images,
                imageIndex: imageIndex,
                heroTag: heroTag,
                onPageChanged: onImageChanged,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.paper,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
              ),
              transform: Matrix4.translationValues(0, -AppSpacing.xl, 0),
              padding: EdgeInsetsDirectional.fromSTEB(
                AppSpacing.page,
                AppSpacing.xl,
                AppSpacing.page,
                140,
              ),
              child: details,
            ),
          ),
        ],
      ),
      bottomSheet: bottomBar,
    );
  }
}
