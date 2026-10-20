import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/screen/setting/checkout_form_fields.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({
    super.key,
    required this.summary,
    required this.storeAddress,
  });

  final CartSummary summary;
  final String? storeAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CheckoutStepTitle(number: 3, title: AppStrings.orderSummary),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line),
          ),
          child: Column(
            children: [
              ...summary.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        '${item.quantity}×',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        Fmt.money(item.lineTotal),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 22),
              _CheckoutLine(AppStrings.subtotal, Fmt.money(summary.subtotal)),
              if (summary.discount > 0)
                _CheckoutLine(
                  '${AppStrings.discount} (${summary.couponCode})',
                  '- ${Fmt.money(summary.discount)}',
                  color: AppColors.success,
                ),
              _CheckoutLine(
                AppStrings.delivery,
                summary.deliveryFee == 0
                    ? AppStrings.free
                    : Fmt.money(summary.deliveryFee),
              ),
              const Divider(height: 22),
              _CheckoutLine(
                AppStrings.total,
                Fmt.money(summary.total),
                bold: true,
              ),
            ],
          ),
        ),
        if (storeAddress != null) ...[
          const SizedBox(height: 12),
          Text(
            AppStrings.ordersShipFrom.replaceAll('{address}', storeAddress!),
            style: TextStyle(color: AppColors.muted, fontSize: 12.5.sp),
          ),
        ],
      ],
    );
  }
}

class _CheckoutLine extends StatelessWidget {
  const _CheckoutLine(this.label, this.value, {this.color, this.bold = false});

  final String label;
  final String value;
  final Color? color;
  final bool bold;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: bold ? AppColors.ink : AppColors.muted,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              fontSize: (bold ? 16 : 14).sp,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? AppColors.ink,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            fontSize: (bold ? 17 : 14).sp,
          ),
        ),
      ],
    ),
  );
}
