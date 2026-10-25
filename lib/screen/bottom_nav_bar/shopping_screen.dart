import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_controller_state.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/screen/auth/login_screen.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/cart_checkout_sheet.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/cart_content.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/states.dart';
import 'package:souqna_anaqa/widget/loading.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    return Scaffold(
      appBar: GlassAppBar(
        title: Obx(
          () => Text(
            cart.itemsCount.value > 0
                ? '${AppStrings.cartTitle} (${cart.itemsCount.value})'
                : AppStrings.cartTitle,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: AppSizes.appBarHeight + MediaQuery.paddingOf(context).top,
        ),
        child: !Get.find<UserProfileGetxController>().isLoggedIn
            ? EmptyView(
                icon: Icons.lock_outline_rounded,
                title: AppStrings.cartLoginRequired,
                body: AppStrings.cartLoginPrompt,
                action: AppStrings.login,
                onAction: () => Get.to(() => const LoginScreen()),
              )
            : Obx(() {
                switch (cart.displayState.value) {
                  case CartDisplayState.loading:
                    return const CartSkeleton();
                  case CartDisplayState.empty:
                    return EmptyView(
                      icon: Icons.shopping_bag_outlined,
                      title: AppStrings.cartEmptyTitle,
                      body: AppStrings.cartEmptyPrompt,
                      action: AppStrings.startShopping,
                      onAction: () => MainScreenController.to.go(0),
                    );
                  case CartDisplayState.content:
                    return const CartContent();
                }
              }),
      ),
      bottomSheet: const CartCheckoutSheet(),
    );
  }
}
