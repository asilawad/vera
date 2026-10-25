import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

class MainNavMetrics {
  MainNavMetrics._();

  static double bottomInset(BuildContext context) {
    if (Responsive.useSideNav(context)) return 0;
    return AppSizes.bottomNavigationHeight + AppSizes.bottomNavigationMargin;
  }
}
