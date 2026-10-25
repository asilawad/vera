import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_controller_state.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/screen/setting/payment_screen.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

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
          ? _CheckoutSheetContent(cart: cart)
          : const SizedBox.shrink(),
    );
  }
}

class _CheckoutSheetContent extends StatelessWidget {
  const _CheckoutSheetContent({required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        14 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: MaxWidthBox(
        maxWidth: Responsive.readingMaxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => cart.meetsMinOrder.value
                  ? const SizedBox.shrink()
                  : _MinOrderNotice(cart: cart),
            ),
            Obx(
              () => FilledButton(
                onPressed: cart.meetsMinOrder.value
                    ? () => Get.to(() => const PaymentScreen())
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(child: Text(AppStrings.checkout)),
                    const SizedBox(width: 12),
                    Obx(() => Text(Fmt.money(cart.total.value))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MinOrderNotice extends StatelessWidget {
  const _MinOrderNotice({required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(
        () => Text(
          AppStrings.cartMinOrderMessage.replaceAll(
            '{amount}',
            Fmt.money(cart.minOrder.value - cart.subtotal.value),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.danger,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
