import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/screen/home/product_details_screen.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/widget/net_image.dart';
import 'package:souqna_anaqa/widget/quantity_stepper.dart';

class CartLine extends StatelessWidget {
  const CartLine(this.item, {super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      onDismissed: (_) => cart.removeItem(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () =>
                  Get.to(() => ProductDetailsScreen(id: item.productId)),
              child: NetImage(
                item.image,
                width: 86.r,
                height: 100.r,
                radius: 14.r,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 6),
                  CartOptionsRow(item.options),
                  if (!item.isAvailable)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        AppStrings.unavailableCartQuantity,
                        style: TextStyle(
                          color: AppColors.danger,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Fmt.money(item.lineTotal),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Obx(
                        () => QuantityStepper(
                          compact: true,
                          value: item.quantity,
                          max: item.stock > 0 ? item.stock : 99,
                          busy: cart.busyItemId.value == item.id,
                          onChanged: (quantity) =>
                              cart.updateQuantity(item, quantity),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartOptionsRow extends StatelessWidget {
  const CartOptionsRow(this.options, {super.key});

  final Map<String, String> options;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (options['size'] != null)
          _OptionChip(
            child: Text(
              AppStrings.sizeOption.replaceAll('{size}', options['size']!),
              style: TextStyle(fontSize: 11.5.sp),
            ),
          ),
        if (options['color'] != null)
          _OptionChip(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.colorOption,
                  style: TextStyle(fontSize: 11.5.sp),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Fmt.hex(options['color']),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.line),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
