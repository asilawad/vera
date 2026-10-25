import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_nav_metrics.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/min_order_notice.dart';
import 'package:souqna_anaqa/screen/setting/payment_screen.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

class CheckoutSheetContent extends StatelessWidget {
  const CheckoutSheetContent({super.key, required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.orientationOf(context) == Orientation.landscape;
    final verticalPadding = compact ? AppSpacing.xxs : AppSpacing.md;
    return GlassContainer(
      strong: true,
      radius: AppRadius.card,
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.page,
        verticalPadding,
        AppSpacing.page,
        verticalPadding +
            MediaQuery.paddingOf(context).bottom +
            MainNavMetrics.bottomInset(context),
      ),
      child: MaxWidthBox(
        maxWidth: Responsive.readingMaxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => cart.meetsMinOrder.value
                  ? const SizedBox.shrink()
                  : MinOrderNotice(cart: cart),
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
                    SizedBox(width: AppSpacing.md),
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
