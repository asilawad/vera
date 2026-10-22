import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';

class ProductHero extends StatelessWidget {
  const ProductHero({
    super.key,
    required this.tag,
    required this.radius,
    required this.child,
  });

  final Object tag;
  final double radius;
  final Widget child;

  static String tagFor(String prefix, int id) => '$prefix-$id';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (context, animation, direction, from, to) {
        final reducedMotion = MediaQuery.disableAnimationsOf(context);
        final radiusTween = Tween<double>(
          begin: direction == HeroFlightDirection.push ? radius : AppRadius.lg,
          end: direction == HeroFlightDirection.push ? AppRadius.lg : radius,
        );
        final fade = direction == HeroFlightDirection.push
            ? animation
            : ReverseAnimation(animation);
        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) => FadeTransition(
            opacity: fade,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                reducedMotion
                    ? (direction == HeroFlightDirection.push
                          ? AppRadius.lg
                          : radius)
                    : radiusTween.evaluate(animation),
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
