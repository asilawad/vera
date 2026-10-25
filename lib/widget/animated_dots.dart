import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';

class AnimatedDots extends StatelessWidget {
  const AnimatedDots({
    super.key,
    required this.count,
    required this.index,
    required this.activeColor,
  });

  final int count;
  final int index;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : AppMotion.normal;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (dotIndex) => AnimatedContainer(
          duration: duration,
          curve: AppMotion.standard,
          margin: EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.micro),
          width: dotIndex == index ? AppSizes.dotActive : AppSizes.dot,
          height: AppSizes.dot,
          decoration: BoxDecoration(
            color: dotIndex == index ? activeColor : AppColors.line,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ),
    );
  }
}
