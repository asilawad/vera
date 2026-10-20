import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
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
          const SizedBox(height: 24),
          Text(
            AppStrings.size,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes.map((size) {
              final active = selectedSize == size;
              return GestureDetector(
                onTap: () => onSizeSelected(size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  constraints: const BoxConstraints(minWidth: 52),
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: active ? AppColors.ink : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: active ? AppColors.ink : AppColors.line,
                    ),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : AppColors.ink,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        if (colors.isNotEmpty) ...[
          const SizedBox(height: 22),
          Text(
            AppStrings.color,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            children: colors.map((color) {
              final active = selectedColor == color;
              return GestureDetector(
                onTap: () => onColorSelected(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: active ? primary : Colors.transparent,
                      width: 2,
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
                            size: 18,
                            color: Fmt.hex(color).computeLuminance() > 0.5
                                ? AppColors.ink
                                : Colors.white,
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
