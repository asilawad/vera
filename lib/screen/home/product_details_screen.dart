import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/screen/home/product_details/product_details_content.dart';
import 'package:souqna_anaqa/screen/home/product_details/product_details_loading_view.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

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
    final product = _detailsController.product.value;
    if (product == null) return;
    if (product.sizes.isNotEmpty && _size == null) {
      Helpers.showSnackBar(message: AppStrings.selectSizeFirst, error: true);
      return;
    }
    final UserProfileGetxController profile = Get.find();
    if (!await profile.ensureLoggedIn()) return;
    final added = await _cartController.addToCart(
      productId: product.id,
      quantity: _quantity,
      options: {'size': ?_size, 'color': ?_color},
    );
    if (added && buyNow) {
      Get.until((route) => route.isFirst);
      MainScreenController.to.go(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = _detailsController.product.value;
      if (product == null) {
        return ProductDetailsLoadingView(
          errorMessage: _detailsController.errorMessage.value,
          onRetry: _loadDetails,
        );
      }
      return ProductDetailsContent(
        id: _id,
        heroTag: _hero,
        product: product,
        related: _detailsController.relatedList,
        reviews: _detailsController.reviewsSummary.value,
        reviewsLoading: _detailsController.isLoading.value,
        reviewsController: _detailsController,
        quantity: _quantity,
        isSubmitting: _cartController.isSubmitting.value,
        imageIndex: _imageIndex,
        selectedSize: _size,
        selectedColor: _color,
        onImageChanged: (index) => setState(() => _imageIndex = index),
        onQuantityChanged: (quantity) => setState(() => _quantity = quantity),
        onSizeSelected: (size) => setState(() => _size = size),
        onColorSelected: (color) => setState(() => _color = color),
        onAddToCart: () => _addToCart(),
      );
    });
  }
}
