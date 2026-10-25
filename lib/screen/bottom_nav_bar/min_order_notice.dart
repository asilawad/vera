import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

class MinOrderNotice extends StatelessWidget {
  const MinOrderNotice({super.key, required this.cart});

  final CartGetxController cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: AppSpacing.compact),
      child: Obx(
        () => Text(
          AppStrings.cartMinOrderMessage.replaceAll(
            '{amount}',
            Fmt.money(cart.minOrder.value - cart.subtotal.value),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.danger,
            fontSize: AppSizes.cartMinOrderFont,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
