import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_glass.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

class GlassBar extends StatelessWidget {
  const GlassBar({
    super.key,
    required this.child,
    this.bottom = false,
    this.strong = false,
    this.padding,
    this.safeArea = true,
  });

  final Widget child;
  final bool bottom;
  final bool strong;
  final EdgeInsetsGeometry? padding;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final bar = Container(
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: bottom
              ? BorderSide.none
              : const BorderSide(
                  color: AppColors.glassBorder,
                  width: AppGlass.borderWidth,
                ),
          top: bottom
              ? const BorderSide(
                  color: AppColors.glassBorder,
                  width: AppGlass.borderWidth,
                )
              : BorderSide.none,
        ),
      ),
      child: GlassContainer(
        radius: AppRadius.none,
        strong: strong,
        padding: padding,
        child: child,
      ),
    );
    if (!safeArea) return bar;
    return SafeArea(top: !bottom, bottom: bottom, child: bar);
  }
}
