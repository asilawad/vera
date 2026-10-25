import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

class CartSummaryView extends StatelessWidget {
  const CartSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          _CartSummaryLine(
            label: _CartItemCountLabel(cart: cart),
            value: _SummaryMoney(amount: cart.subtotal),
          ),
          Obx(
            () => cart.discount.value > 0
                ? _CartSummaryLine(
                    label: const Text(AppStrings.discount),
                    value: _SummaryMoney(
                      amount: cart.discount,
                      prefix: '- ',
                      color: AppColors.success,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          _CartSummaryLine(
            label: const Text(AppStrings.delivery),
            value: _DeliveryValue(cart: cart),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          _CartSummaryLine(
            label: const Text(AppStrings.total),
            value: _SummaryMoney(amount: cart.total),
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _CartSummaryLine extends StatelessWidget {
  const _CartSummaryLine({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final Widget label;
  final Widget value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                color: bold ? AppColors.ink : AppColors.muted,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                fontSize: (bold ? 16 : 14).sp,
              ),
              child: label,
            ),
          ),
          value,
        ],
      ),
    );
  }
}

class _CartItemCountLabel extends StatelessWidget {
  const _CartItemCountLabel({required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        AppStrings.subtotalCount.replaceAll(
          '{count}',
          '${cart.itemsCount.value}',
        ),
      ),
    );
  }
}

class _SummaryMoney extends StatelessWidget {
  const _SummaryMoney({required this.amount, this.prefix = '', this.color});

  final RxDouble amount;
  final String prefix;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        '$prefix${Fmt.money(amount.value)}',
        style: TextStyle(
          color: color ?? AppColors.ink,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _DeliveryValue extends StatelessWidget {
  const _DeliveryValue({required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        cart.deliveryFee.value == 0
            ? AppStrings.free
            : Fmt.money(cart.deliveryFee.value),
        style: TextStyle(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
