import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/cart_count_badge.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

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
      minimum: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ).resolve(Directionality.of(context)),
      child: Align(
        heightFactor: 1,
        child: Container(
          constraints: BoxConstraints(
            minHeight: AppSizes.bottomNavigationHeight,
            maxWidth: AppSizes.bottomNavigationMaxWidth,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: AppSizes.cardShadowBlur,
                offset: Offset(0, AppSpacing.sm),
              ),
            ],
          ),
          child: GlassContainer(
            strong: true,
            radius: AppRadius.card,
            child: Row(
              children: List.generate(
                _navItems.length,
                (itemIndex) => Expanded(
                  child: _NavItem(
                    itemIndex,
                    index,
                    onSelect,
                    lightSurface: true,
                  ),
                ),
              ),
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
  const _NavItem(
    this.itemIndex,
    this.selectedIndex,
    this.onSelect, {
    this.lightSurface = false,
  });

  final int itemIndex;
  final RxInt selectedIndex;
  final ValueChanged<int> onSelect;
  final bool lightSurface;

  @override
  Widget build(BuildContext context) {
    final primary = lightSurface
        ? AppColors.primary
        : Theme.of(context).colorScheme.primary;
    final unselectedIcon = lightSurface
        ? AppColors.muted
        : AppColors.whiteSubtle;
    final unselectedLabel = lightSurface
        ? AppColors.muted
        : AppColors.whiteMuted;
    final activeLabel = lightSurface ? AppColors.primary : AppColors.white;
    final (icon, activeIcon, label) = _navItems[itemIndex];
    return Obx(() {
      final active = selectedIndex.value == itemIndex;
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadius.navItem),
        onTap: () => onSelect(itemIndex),
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartCountBadge(
                visible: itemIndex == 2,
                color: primary,
                child: AnimatedContainer(
                  duration: AppMotion.normal,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.navigationIndicatorHorizontal,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? primary.withValues(alpha: AppSizes.navSelectedOpacity)
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Icon(
                    active ? activeIcon : icon,
                    color: active ? primary : unselectedIcon,
                    size: AppSizes.icon,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.micro),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: AppSizes.navItemLabelFont.sp,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? activeLabel : unselectedLabel,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
