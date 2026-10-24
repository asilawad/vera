import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/app_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/main_screen.dart';
import 'package:souqna_anaqa/screen/lunch/widgets/splash_brand.dart';
import 'package:souqna_anaqa/screen/lunch/widgets/splash_error.dart';
import 'package:souqna_anaqa/screen/lunch/widgets/splash_glow.dart';
import 'package:souqna_anaqa/utils/app_assets.dart';
import 'package:souqna_anaqa/utils/app_brand.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({super.key});
  @override
  State<LunchScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<LunchScreen> {
  String? _error;
  bool _loading = false;
  bool _precacheStarted = false;
  bool _logoReady = false;
  @override
  void initState() {
    super.initState();
    unawaited(_start());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precacheStarted) return;
    _precacheStarted = true;
    unawaited(
      AppAssets.precacheBrand(context).then<void>((_) {
        if (!mounted) return;
        setState(() => _logoReady = true);
      }),
    );
  }

  Future<void> _start() async {
    if (_loading) return;
    _error = null;
    setState(() => _loading = true);
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
      _loading = false;
      setState(() => _error = app.errorMessage.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppBrand.splashBackground,
      body: Stack(
        children: [
          Positioned(
            top: AppBrand.glowTopOffset,
            right: AppBrand.glowTopSide,
            child: SplashGlow(
              color: AppBrand.gold,
              size: AppBrand.glowLargeSize.r,
            ),
          ),
          Positioned(
            bottom: AppBrand.glowBottomOffset,
            left: AppBrand.glowBottomSide,
            child: SplashGlow(
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
                      child: SplashBrand(logoReady: _logoReady),
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
                      : SplashError(message: _error!, onRetry: _start),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
