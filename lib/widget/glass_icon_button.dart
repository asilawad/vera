import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.glassIconButton,
      height: AppSizes.glassIconButton,
      child: GlassContainer(
        radius: AppRadius.chip,
        child: IconButton(
          onPressed: onPressed,
          tooltip: tooltip,
          icon: Icon(icon, size: AppSizes.compactIcon),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.expand(),
        ),
      ),
    );
  }
}
