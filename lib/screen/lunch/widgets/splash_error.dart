import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_brand.dart';

class SplashError extends StatelessWidget {
  const SplashError({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppBrand.cream.withValues(alpha: AppBrand.mutedOpacity),
          ),
        ),
        SizedBox(height: AppBrand.splashGap.h),
        TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded, color: AppBrand.cream),
          label: const Text(
            AppBrand.retry,
            style: TextStyle(color: AppBrand.cream),
          ),
        ),
      ],
    );
  }
}
