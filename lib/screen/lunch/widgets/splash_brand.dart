import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/screen/lunch/widgets/splash_logo_reveal.dart';
import 'package:souqna_anaqa/utils/app_assets.dart';
import 'package:souqna_anaqa/utils/app_brand.dart';

class SplashBrand extends StatelessWidget {
  const SplashBrand({super.key, required this.logoReady});

  final bool logoReady;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppBrand.splashLogoSize.r,
          height: AppBrand.splashLogoSize.r,
          child: logoReady
              ? SplashLogoReveal(
                  child: Image.asset(AppAssets.splashLogo, fit: BoxFit.contain),
                )
              : null,
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
