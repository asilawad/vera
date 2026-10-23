import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/app_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/utils/app_brand.dart';

/// Splash: the brand is local (no backend dependency); store data loads behind it.
class LunchScreen extends StatefulWidget {
  const LunchScreen({super.key});

  @override
  State<LunchScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<LunchScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() => _error = null);
    final app = Get.find<AppGetxController>();
    final results = await Future.wait([
      app.fetchStore(),
      Get.find<UserProfileGetxController>().fetchUserProfile(),
      Future.delayed(AppBrand.splashMinDuration),
    ]);
    if (!mounted) return;
    if (results.first == true) {
      Get.offAll(() => const MainScreen(), transition: Transition.fadeIn);
    } else {
      setState(() => _error = app.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppBrand.burgundy,
      body: Stack(
        children: [
          Positioned(
            top: AppBrand.glowTopOffset,
            right: AppBrand.glowTopSide,
            child: _Glow(color: AppBrand.gold, size: AppBrand.glowLargeSize.r),
          ),
          Positioned(
            bottom: AppBrand.glowBottomOffset,
            left: AppBrand.glowBottomSide,
            child: _Glow(
              color: AppBrand.gold.withValues(
                alpha: AppBrand.glowSecondaryOpacity,
              ),
              size: AppBrand.glowSmallSize.r,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: AppBrand.splashPadding,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: AppBrand.splashAnimDuration,
                        curve: AppBrand.splashCurve,
                        builder: (_, v, child) => Opacity(
                          opacity: v.clamp(0.0, 1.0),
                          child: Transform.scale(
                            scale:
                                AppBrand.splashScaleStart +
                                (1 - AppBrand.splashScaleStart) * v,
                            child: child,
                          ),
                        ),
                        child: const _SplashBrand(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: AppBrand.splashBottomPadding,
                  child: _error == null
                      ? const SizedBox(
                          width: AppBrand.loaderSize,
                          height: AppBrand.loaderSize,
                          child: CircularProgressIndicator(
                            strokeWidth: AppBrand.loaderStroke,
                            color: AppBrand.gold,
                          ),
                        )
                      : _SplashError(message: _error!, onRetry: _start),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashBrand extends StatelessWidget {
  const _SplashBrand();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppBrand.logoMark,
          width: AppBrand.splashLogoSize.r,
          height: AppBrand.splashLogoSize.r,
        ),
        SizedBox(height: AppBrand.splashGap.h),
        Text(
          AppBrand.name,
          style: TextStyle(
            color: AppBrand.cream,
            fontSize: AppBrand.splashTitleSize.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: AppBrand.splashTitleSpacing,
          ),
        ),
        SizedBox(height: AppBrand.splashSmallGap.h),
        Text(
          AppBrand.tagline,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppBrand.gold,
            fontSize: AppBrand.splashTaglineSize.sp,
          ),
        ),
      ],
    );
  }
}

class _SplashError extends StatelessWidget {
  const _SplashError({required this.message, required this.onRetry});

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

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

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
