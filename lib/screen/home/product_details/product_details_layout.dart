import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_gallery.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/favorite_icon.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';
import 'package:souqna_anaqa/widget/glass_icon_button.dart';
import 'package:souqna_anaqa/widget/glass_sliver_app_bar.dart';

class ProductDetailsLayout extends StatelessWidget {
  const ProductDetailsLayout({
    super.key,
    required this.product,
    required this.images,
    required this.heroTag,
    required this.imageIndex,
    required this.onImageChanged,
    required this.details,
    required this.bottomBar,
  });

  final Product product;
  final List<String> images;
  final String heroTag;
  final int imageIndex;
  final ValueChanged<int> onImageChanged;
  final Widget details;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    if (screenSize.width >= AppSizes.twoPaneWidth) {
      return Scaffold(
        extendBody: true,
        appBar: GlassAppBar(
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: AppSpacing.md),
              child: FavoriteIcon(product, size: 40, glass: true),
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
                    AppSizes.productDetailsDesktopBottomPadding +
                        MediaQuery.paddingOf(context).bottom,
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
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          GlassSliverAppBar(
            expandedHeight: (screenSize.width * 1.1).clamp(
              0,
              screenSize.height * 0.6,
            ),
            leading: Padding(
              padding: EdgeInsetsDirectional.all(AppSpacing.sm),
              child: GlassIconButton(
                icon: Icons.arrow_back_rounded,
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.all(AppSpacing.sm),
                child: FavoriteIcon(product, size: 40, glass: true),
              ),
            ],
            background: ProductGallery(
              images: images,
              imageIndex: imageIndex,
              heroTag: heroTag,
              onPageChanged: onImageChanged,
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
                AppSizes.productDetailsBottomPadding,
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
