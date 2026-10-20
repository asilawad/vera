import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

class ProductOptionsSection extends StatelessWidget {
  const ProductOptionsSection({
    super.key,
    required this.sizes,
    required this.colors,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
  });

  final List<String> sizes;
  final List<String> colors;
  final String? selectedSize;
  final String? selectedColor;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<String> onColorSelected;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sizes.isNotEmpty) ...[
          SizedBox(height: AppSpacing.xl),
          Text(
            AppStrings.size,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: AppSpacing.compact),
          Wrap(
            spacing: AppSpacing.compact,
            runSpacing: AppSpacing.compact,
            children: sizes.map((size) {
              final active = selectedSize == size;
              return GestureDetector(
                onTap: () => onSizeSelected(size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  constraints: BoxConstraints(
                    minWidth: AppSizes.sizeOptionMinWidth,
                  ),
                  height: AppSizes.sizeOptionHeight,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? AppColors.ink : AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: active ? AppColors.ink : AppColors.line,
                    ),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: active ? AppColors.white : AppColors.ink,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        if (colors.isNotEmpty) ...[
          SizedBox(height: AppSpacing.xl),
          Text(
            AppStrings.color,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: AppSpacing.compact),
          Wrap(
            spacing: AppSpacing.md,
            children: colors.map((color) {
              final active = selectedColor == color;
              return GestureDetector(
                onTap: () => onColorSelected(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: AppSizes.colorSwatch,
                  height: AppSizes.colorSwatch,
                  padding: EdgeInsetsDirectional.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: active ? primary : AppColors.transparent,
                      width: AppSizes.borderWidth,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Fmt.hex(color),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.line),
                    ),
                    child: active
                        ? Icon(
                            Icons.check_rounded,
                            size: AppSizes.compactIcon,
                            color: Fmt.hex(color).computeLuminance() > 0.5
                                ? AppColors.ink
                                : AppColors.white,
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
