import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/responsive.dart';
import 'package:souqna_anaqa/widget/app_search_bar.dart';
import 'package:souqna_anaqa/widget/skeleton/home_skeletons.dart';
import 'package:souqna_anaqa/widget/skeleton/product_skeletons.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: centeredPadding(
        MediaQuery.sizeOf(context).width,
        top: AppSpacing.page,
        bottom: AppSpacing.page,
      ),
      children: [
        const AppSearchBar(hint: AppStrings.homeSearchHint),
        SizedBox(height: AppSpacing.md),
        const BannerSkeleton(),
        SizedBox(height: AppSpacing.xl),
        const CategoryChipsSkeleton(count: AppSizes.homeSkeletonCategoryCount),
        SizedBox(height: AppSpacing.xl),
        const ProductRowSkeleton(),
        SizedBox(height: AppSpacing.xl),
        const ProductGridSkeleton(count: AppSizes.homeSkeletonProductGridCount),
      ],
    );
  }
}
