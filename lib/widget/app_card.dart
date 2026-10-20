import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
      side: const BorderSide(color: AppColors.line),
    );
    return Material(
      color: AppColors.surface,
      elevation: 0,
      shape: shape,
      shadowColor: AppColors.shadow,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Container(
          padding: padding ?? EdgeInsetsDirectional.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: AppSizes.cardShadowBlur,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
