import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';

class CartCountBadge extends StatelessWidget {
  const CartCountBadge({
    super.key,
    required this.visible,
    required this.color,
    required this.child,
  });

  final bool visible;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final count = Get.find<CartGetxController>().itemsCount.value;
      return Badge(
        isLabelVisible: visible && count > 0,
        label: Text('$count'),
        backgroundColor: color,
        textColor: Theme.of(context).colorScheme.onPrimary,
        child: child,
      );
    });
  }
}
