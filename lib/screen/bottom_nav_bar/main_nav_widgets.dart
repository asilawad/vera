import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/cart_count_badge.dart';

const _navItems = [
  (Icons.home_outlined, Icons.home_rounded, AppStrings.navHome),
  (Icons.grid_view_outlined, Icons.grid_view_rounded, AppStrings.navCategories),
  (Icons.shopping_bag_outlined, Icons.shopping_bag_rounded, AppStrings.navCart),
  (
    Icons.favorite_border_rounded,
    Icons.favorite_rounded,
    AppStrings.navFavorites,
  ),
  (Icons.person_outline_rounded, Icons.person_rounded, AppStrings.navAccount),
];

class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key, required this.index, required this.onSelect});

  final RxInt index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Align(
        heightFactor: 1,
        child: Container(
          constraints: const BoxConstraints(minHeight: 68, maxWidth: 560),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              _navItems.length,
              (itemIndex) =>
                  Expanded(child: _NavItem(itemIndex, index, onSelect)),
            ),
          ),
        ),
      ),
    );
  }
}

class MainSideBar extends StatelessWidget {
  const MainSideBar({super.key, required this.index, required this.onSelect});

  final RxInt index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      color: AppColors.ink,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: List.generate(
              _navItems.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _NavItem(index, this.index, onSelect),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem(this.itemIndex, this.selectedIndex, this.onSelect);

  final int itemIndex;
  final RxInt selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final (icon, activeIcon, label) = _navItems[itemIndex];
    return Obx(() {
      final active = selectedIndex.value == itemIndex;
      return InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => onSelect(itemIndex),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartCountBadge(
                visible: itemIndex == 2,
                color: primary,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? primary.withValues(alpha: 0.18)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    active ? activeIcon : icon,
                    color: active ? primary : Colors.white60,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: 10.5.sp,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? Colors.white : Colors.white54,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
