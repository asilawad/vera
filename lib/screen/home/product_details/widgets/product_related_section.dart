import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/models/product.dart';
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
        const SizedBox(height: 26),
        Text(
          AppStrings.recommendations,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        const SizedBox(height: 14),
        HorizontalProducts(
          padding: EdgeInsets.zero,
          itemWidth: 160.w,
          itemCount: products.length,
          itemBuilder: (_, index) =>
              ProductCard(products[index], heroPrefix: heroPrefix),
        ),
      ],
    );
  }
}
