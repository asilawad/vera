import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_brand.dart';

class SplashGlow extends StatelessWidget {
  const SplashGlow({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          color.withValues(alpha: AppBrand.glowOpacity),
          color.withValues(alpha: 0),
        ],
      ),
    ),
  );
}
