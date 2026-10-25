import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/screen/home/product_details/widgets/add_to_cart_button.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/quantity_stepper.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.isSubmitting,
    required this.isAdded,
    required this.onAddToCart,
  });

  final Product product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final bool isSubmitting;
  final bool isAdded;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      radius: AppRadius.none,
      strong: true,
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.page,
        AppSpacing.barVertical,
        AppSpacing.page,
        AppSpacing.barVertical + MediaQuery.paddingOf(context).bottom,
      ),
      child: MaxWidthBox(
        maxWidth: Responsive.readingMaxWidth,
        child: product.inStock
            ? LayoutBuilder(
                builder: (context, constraints) {
                  final label = AppStrings.addToCartPrice.replaceAll(
                    '{price}',
                    Fmt.money(product.finalPrice * quantity),
                  );
                  final stepper = QuantityStepper(
                    value: quantity,
                    max: product.stock,
                    onChanged: onQuantityChanged,
                  );
                  final button = AddToCartButton(
                    label: label,
                    isSubmitting: isSubmitting,
                    isAdded: isAdded,
                    onPressed: onAddToCart,
                  );
                  if (!_labelFits(context, label, constraints.maxWidth)) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        stepper,
                        SizedBox(height: AppSpacing.compact),
                        button,
                      ],
                    );
                  }
                  return Row(
                    children: [
                      stepper,
                      SizedBox(width: AppSpacing.md),
                      Expanded(child: button),
                    ],
                  );
                },
              )
            : const FilledButton(
                onPressed: null,
                child: Text(AppStrings.outOfStock),
              ),
      ),
    );
  }

  bool _labelFits(BuildContext context, String label, double maxWidth) {
    final style = Theme.of(
      context,
    ).filledButtonTheme.style?.textStyle?.resolve({});
    final painter = TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: TextDirection.rtl,
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final fits =
        painter.width <= maxWidth - AppSizes.addToCartLabelReservedWidth;
    painter.dispose();
    return fits;
  }
}
