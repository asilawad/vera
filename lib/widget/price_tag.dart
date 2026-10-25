import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/widget/price.dart';

class PriceTag extends StatelessWidget {
  const PriceTag(this.product, {super.key, this.size = 15});

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) => PriceView(product, size: size);
}
