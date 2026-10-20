import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/widget/favorite_icon.dart';
import 'package:souqna_anaqa/widget/states.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_attributes_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_bottom_bar.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_description_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_gallery.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_header_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_options_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_related_section.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/product_reviews_section.dart';

/// تفاصيل المنتج: معرض صور، السعر، المقاس واللون، الوصف، التقييمات، ومنتجات مشابهة.
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.id,
    this.product,
    this.hero,
  });

  final int id;
  final Product? product;
  final String? hero;

  @override
  State<ProductDetailsScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductDetailsScreen> {
  late final int _id = widget.id;
  late final String _hero = widget.hero ?? 'p-$_id';
  late final String _tag =
      'product-$_id-${DateTime.now().microsecondsSinceEpoch}';
  late final ProductDetailsGetxController _detailsController = Get.put(
    ProductDetailsGetxController(),
    tag: _tag,
  );
  final CartGetxController _cartController = Get.find();

  int _imageIndex = 0;
  int _quantity = 1;
  String? _size;
  String? _color;

  @override
  void initState() {
    super.initState();
    _detailsController.product.value = widget.product;
    _loadDetails();
  }

  @override
  void dispose() {
    Get.delete<ProductDetailsGetxController>(tag: _tag);
    super.dispose();
  }

  Future<void> _loadDetails() async {
    await _detailsController.fetchProductDetails(id: _id);
    final product = _detailsController.product.value;
    if (product == null || !mounted) return;
    setState(() {
      _size ??= product.sizes.length == 1 ? product.sizes.first : null;
      _color ??= product.colors.isNotEmpty ? product.colors.first : null;
    });
  }

  Future<void> _addToCart({bool buyNow = false}) async {
    final p = _detailsController.product.value;
    if (p == null) return;
    if (p.sizes.isNotEmpty && _size == null) {
      Helpers.showSnackBar(message: 'اختاري المقاس أولًا', error: true);
      return;
    }
    final UserProfileGetxController profile = Get.find();
    if (!await profile.ensureLoggedIn()) return;
    final ok = await _cartController.addToCart(
      productId: p.id,
      quantity: _quantity,
      options: {'size': ?_size, 'color': ?_color},
    );
    if (ok && buyNow) {
      Get.until((route) => route.isFirst);
      MainScreenController.to.go(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final p = _detailsController.product.value;
      if (p == null) {
        return Scaffold(
          appBar: AppBar(),
          body: _detailsController.errorMessage.value.isNotEmpty
              ? ErrorView(
                  message: _detailsController.errorMessage.value,
                  onRetry: _loadDetails,
                )
              : const Center(child: CircularProgressIndicator()),
        );
      }
      return _buildDetails(context, p);
    });
  }

  Widget _buildDetails(BuildContext context, Product p) {
    final images = p.images.isNotEmpty
        ? p.images
        : [if (p.image != null) p.image!];
    final size = MediaQuery.sizeOf(context);

    // على الشاشات الواسعة: الصور والتفاصيل جنبًا إلى جنب بدل صورة بطول الشاشة.
    if (size.width >= _twoPaneWidth) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: FavoriteIcon(p, size: 40),
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
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: AspectRatio(
                    aspectRatio: 1 / 1.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: ProductGallery(
                        images: images,
                        imageIndex: _imageIndex,
                        heroTag: _hero,
                        onPageChanged: (i) => setState(() => _imageIndex = i),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  // 120: مساحة لشريط «أضيفي للسلة» السفلي فوق آخر المحتوى.
                  padding: EdgeInsets.fromLTRB(
                    24,
                    8,
                    24,
                    120 + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: _info(context, p),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: ProductBottomBar(
          product: p,
          quantity: _quantity,
          onQuantityChanged: (q) => setState(() => _quantity = q),
          isSubmitting: _cartController.isSubmitting.value,
          onAddToCart: () => _addToCart(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // نسبة التصميم 1:1.1، بحد أقصى حتى يبقى جزء من التفاصيل ظاهرًا في الوضع الأفقي.
            expandedHeight: (size.width * 1.1).clamp(0, size.height * 0.6),
            pinned: true,
            backgroundColor: AppColors.paper,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: BackButton(color: AppColors.ink),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: FavoriteIcon(p, size: 40),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ProductGallery(
                images: images,
                imageIndex: _imageIndex,
                heroTag: _hero,
                onPageChanged: (i) => setState(() => _imageIndex = i),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.paper,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              transform: Matrix4.translationValues(0, -24, 0),
              padding: EdgeInsets.fromLTRB(20.w, 24, 20.w, 140),
              child: _info(context, p),
            ),
          ),
        ],
      ),
      bottomSheet: ProductBottomBar(
        product: p,
        quantity: _quantity,
        onQuantityChanged: (q) => setState(() => _quantity = q),
        isSubmitting: _cartController.isSubmitting.value,
        onAddToCart: () => _addToCart(),
      ),
    );
  }

  static const _twoPaneWidth = 840.0;

  Widget _info(BuildContext context, Product p) {
    final reviews = _detailsController.reviewsSummary.value;
    final related = _detailsController.relatedList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductHeaderSection(product: p, reviews: reviews),
        ProductOptionsSection(
          sizes: p.sizes,
          colors: p.colors,
          selectedSize: _size,
          selectedColor: _color,
          onSizeSelected: (size) => setState(() => _size = size),
          onColorSelected: (color) => setState(() => _color = color),
        ),
        if (p.description != null)
          ProductDescriptionSection(description: p.description!),
        ProductAttributesSection(
          attributes: p.attributesDisplay
              .where((a) => a.type != 'color' && a.key != 'sizes')
              .toList(),
        ),
        const SizedBox(height: 24),
        ProductReviewsSection(
          productId: p.id,
          summary: reviews,
          loading: _detailsController.isLoading.value,
          controller: _detailsController,
        ),
        ProductRelatedSection(products: related, heroPrefix: 'rel$_id'),
      ],
    );
  }
}
