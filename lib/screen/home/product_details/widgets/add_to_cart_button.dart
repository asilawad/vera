import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/animated_check.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.label,
    required this.isSubmitting,
    this.isAdded = false,
    required this.onPressed,
  });

  final String label;
  final bool isSubmitting;
  final bool isAdded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : AppMotion.normal;
    final icon = isSubmitting
        ? SizedBox(
            width: AppSizes.cartSpinner,
            height: AppSizes.cartSpinner,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.white,
            ),
          )
        : isAdded
        ? const AnimatedCheck(
            color: AppColors.success,
            size: AppSizes.checkBadgeSize,
          )
        : const Icon(Icons.shopping_bag_outlined);
    final labelText = isAdded ? AppStrings.addedToCart : label;
    return FilledButton(
      onPressed: isSubmitting ? null : onPressed,
      style: FilledButton.styleFrom(backgroundColor: AppColors.transparent),
      child: AnimatedContainer(
        duration: duration,
        curve: AppMotion.standard,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isAdded
              ? AppColors.success
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: duration,
                switchInCurve: AppMotion.bounce,
                child: KeyedSubtree(
                  key: ValueKey(
                    isSubmitting
                        ? 'loading'
                        : isAdded
                        ? 'added'
                        : 'idle',
                  ),
                  child: icon,
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              Flexible(
                child: AnimatedSwitcher(
                  duration: duration,
                  child: Text(
                    labelText,
                    key: ValueKey(labelText),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
