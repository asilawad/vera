import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

class CartCouponBox extends StatefulWidget {
  const CartCouponBox({super.key});

  @override
  State<CartCouponBox> createState() => _CartCouponBoxState();
}

class _CartCouponBoxState extends State<CartCouponBox> {
  final _code = TextEditingController();
  final CartGetxController cart = Get.find();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    final success = await cart.applyCoupon(_code.text);
    if (!mounted) return;
    if (success) {
      _code.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Obx(
      () => cart.couponCode.value == null
          ? _CouponEntry(
              cart: cart,
              controller: _code,
              primary: primary,
              onApply: _apply,
            )
          : _AppliedCouponPanel(cart: cart, code: cart.couponCode.value!),
    );
  }
}

class _CouponEntry extends StatelessWidget {
  const _CouponEntry({
    required this.cart,
    required this.controller,
    required this.primary,
    required this.onApply,
  });

  final CartGetxController cart;
  final TextEditingController controller;
  final Color primary;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textCapitalization: TextCapitalization.characters,
            textDirection: TextDirection.ltr,
            decoration: const InputDecoration(
              hintText: AppStrings.couponCode,
              prefixIcon: Icon(Icons.local_offer_outlined),
            ),
            onSubmitted: (_) => onApply(),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 54,
          child: Obx(
            () => FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size(90, 54),
                backgroundColor: AppColors.ink,
                foregroundColor: Colors.white,
              ),
              onPressed: cart.isSubmitting.value ? null : onApply,
              child: cart.isSubmitting.value
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primary,
                      ),
                    )
                  : const Text(AppStrings.apply),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppliedCouponPanel extends StatelessWidget {
  const _AppliedCouponPanel({required this.cart, required this.code});

  final CartGetxController cart;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final error = cart.couponError.value;
      final color = error == null ? AppColors.success : AppColors.danger;
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            Icon(Icons.local_offer_rounded, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  error == null
                      ? _CouponSavings(cart: cart)
                      : Text(
                          error,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: AppColors.danger,
                          ),
                        ),
                ],
              ),
            ),
            TextButton(
              onPressed: cart.removeCoupon,
              child: const Text(AppStrings.remove),
            ),
          ],
        ),
      );
    });
  }
}

class _CouponSavings extends StatelessWidget {
  const _CouponSavings({required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        AppStrings.couponSaved.replaceAll(
          '{amount}',
          Fmt.money(cart.discount.value),
        ),
        style: TextStyle(fontSize: 12.5.sp, color: AppColors.success),
      ),
    );
  }
}
