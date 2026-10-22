import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';

class AnimatedCheck extends StatelessWidget {
  const AnimatedCheck({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : AppMotion.checkmark;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: AppMotion.bounce,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.badge),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
      child: Icon(
        Icons.check_rounded,
        size: size * AppSizes.checkIconScale,
        color: color,
      ),
    );
  }
}
