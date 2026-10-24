import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_brand.dart';

class SplashLogoReveal extends StatelessWidget {
  const SplashLogoReveal({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: AppBrand.splashRevealStart,
        end: AppBrand.splashRevealEnd,
      ),
      duration: AppBrand.splashAnimDuration,
      curve: AppBrand.splashCurve,
      builder: (_, value, child) => Opacity(
        opacity: value.clamp(
          AppBrand.splashRevealStart,
          AppBrand.splashRevealEnd,
        ),
        child: Transform.scale(
          scale:
              AppBrand.splashScaleStart +
              (AppBrand.splashRevealEnd - AppBrand.splashScaleStart) * value,
          child: child,
        ),
      ),
      child: child,
    );
  }
}
