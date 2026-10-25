import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_glass.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.radius,
    this.strong = false,
    this.padding,
  });

  final Widget child;
  final double? radius;
  final bool strong;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? AppRadius.card),
      child: RepaintBoundary(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: strong ? AppGlass.blurSigmaStrong : AppGlass.blurSigma,
            sigmaY: strong ? AppGlass.blurSigmaStrong : AppGlass.blurSigma,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: strong
                  ? AppColors.glassSurfaceStrong
                  : AppColors.glassSurface,
              border: Border.all(
                color: AppColors.glassBorder,
                width: AppGlass.borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
