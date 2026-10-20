import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/cart_coupon_box.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/cart_line.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/cart_summary_view.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

class CartContent extends StatelessWidget {
  const CartContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    return Obx(
      () => RefreshIndicator(
        onRefresh: cart.fetchCart,
        child: ListView(
          padding: centeredPadding(
            MediaQuery.sizeOf(context).width,
            maxWidth: Responsive.readingMaxWidth,
            top: 8,
            bottom: Responsive.bottomClearance(context, 150),
          ),
          children: [
            ...cart.items.map((item) => CartLine(item)),
            const SizedBox(height: 8),
            const CartCouponBox(),
            const SizedBox(height: 16),
            const CartSummaryView(),
          ],
        ),
      ),
    );
  }
}
