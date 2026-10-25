import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';

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
        label: TweenAnimationBuilder<double>(
          key: ValueKey(count),
          tween: Tween(
            begin: AppSizes.cartBadgeBumpScale,
            end: AppSizes.cartBadgeRestScale,
          ),
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : AppMotion.fast,
          curve: AppMotion.bounce,
          builder: (context, scale, child) =>
              Transform.scale(scale: scale, child: child),
          child: Text('$count'),
        ),
        backgroundColor: color,
        textColor: Theme.of(context).colorScheme.onPrimary,
        child: child,
      );
    });
  }
}
