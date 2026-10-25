import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/category.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/category_chip.dart';
import 'package:souqna_anaqa/widget/vera_chip.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    this.showAll = true,
  });

  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelected;
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    final offset = showAll ? 1 : 0;
    return SizedBox(
      height: AppSizes.chipHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + offset,
        separatorBuilder: (_, _) => SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          if (showAll && index == 0) {
            return VeraChip(
              label: AppStrings.categoryAll,
              icon: Icons.grid_view_rounded,
              selected: selectedId == null,
              onTap: () => onSelected(null),
            );
          }
          final category = categories[index - offset];
          return CategoryChip(
            category: category,
            selected: selectedId == category.id,
            onSelected: () => onSelected(category.id),
          );
        },
      ),
    );
  }
}
