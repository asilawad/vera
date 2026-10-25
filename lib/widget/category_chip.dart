import 'package:flutter/material.dart';

import 'package:souqna_anaqa/models/category.dart';
import 'package:souqna_anaqa/utils/category_icons.dart';
import 'package:souqna_anaqa/widget/vera_chip.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  final Category category;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return VeraChip(
      label: category.name,
      icon: CategoryIcons.forKey(category.icon),
      selected: selected,
      onTap: onSelected,
    );
  }
}
