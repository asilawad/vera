import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_controller_state.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/checkout_sheet_content.dart';

class CartCheckoutSheet extends StatelessWidget {
  const CartCheckoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    if (!Get.find<UserProfileGetxController>().isLoggedIn) {
      return const SizedBox.shrink();
    }
    return Obx(
      () => cart.displayState.value == CartDisplayState.content
          ? CheckoutSheetContent(cart: cart)
          : const SizedBox.shrink(),
    );
  }
}
