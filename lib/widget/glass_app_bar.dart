import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/glass_bar.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.bottom,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
    AppSizes.appBarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      bottom: bottom,
      toolbarHeight: AppSizes.appBarHeight,
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: const GlassBar(safeArea: false, child: SizedBox.expand()),
    );
  }
}
