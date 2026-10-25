import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';
import 'package:souqna_anaqa/widget/glass_icon_button.dart';

class GlassSliverAppBar extends StatelessWidget {
  const GlassSliverAppBar({
    super.key,
    required this.expandedHeight,
    required this.background,
    this.leading,
    this.actions,
    this.title,
  });

  final double expandedHeight;
  final Widget background;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      leading:
          leading ??
          GlassIconButton(
            icon: Icons.arrow_back_rounded,
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => Navigator.maybePop(context),
          ),
      actions: actions,
      title: title,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topInset = MediaQuery.paddingOf(context).top;
          final collapsedHeight = AppSizes.appBarHeight + topInset;
          final expandedExtent = expandedHeight + topInset;
          final collapse =
              (1 -
                      (constraints.maxHeight - collapsedHeight) /
                          (expandedExtent - collapsedHeight))
                  .clamp(0.0, 1.0);
          return Stack(
            fit: StackFit.expand,
            children: [
              background,
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: collapse,
                  duration: AppMotion.normal,
                  curve: AppMotion.standard,
                  child: const GlassContainer(
                    radius: AppRadius.none,
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
