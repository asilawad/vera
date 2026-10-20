import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({
    super.key,
    required this.percent,
    this.compact = false,
    this.filled = true,
  });

  final int percent;
  final bool compact;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final textColor = filled ? AppColors.white : AppColors.danger;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: compact ? AppSpacing.sm : AppSpacing.compact,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: filled ? AppColors.primary : AppColors.dangerSurface,
        borderRadius: BorderRadius.circular(
          compact ? AppRadius.badge : AppRadius.sm,
        ),
      ),
      child: Text(
        filled
            ? '-$percent%'
            : AppStrings.discountPercent.replaceAll('{percent}', '$percent'),
        textDirection: compact ? TextDirection.ltr : null,
        style:
            (compact
                    ? Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: AppSizes.discountCompactFont.sp,
                      )
                    : Theme.of(context).textTheme.labelMedium)
                ?.copyWith(color: textColor, fontWeight: FontWeight.w700),
      ),
    );
  }
}
