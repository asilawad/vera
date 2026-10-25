import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/app_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_assets.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/net_image.dart';
import 'package:souqna_anaqa/screen/home/store_details_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < AppSizes.noonHour) return AppStrings.homeGreetingMorning;
    if (hour < AppSizes.eveningHour) return AppStrings.homeGreetingDay;
    return AppStrings.homeGreetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final storeController = Get.find<AppGetxController>();
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.page,
        AppSizes.homeHeaderVerticalPadding,
        AppSpacing.page,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: SizedBox(
              width: AppSizes.homeHeaderLogo,
              height: AppSizes.homeHeaderLogo,
              child: Obx(() {
                final logo = storeController.store.value?.logo;
                return logo == null || logo.isEmpty
                    ? Image.asset(AppAssets.headerLogo, fit: BoxFit.cover)
                    : NetImage(logo);
              }),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Obx(() {
              final profile = Get.find<UserProfileGetxController>();
              final name = profile.userProfile.value?.name.split(' ').first;
              final store = storeController.store.value;
              final greeting = _greeting();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name == null
                        ? AppStrings.homeGreetingWithoutName.replaceAll(
                            '{greeting}',
                            greeting,
                          )
                        : AppStrings.homeGreetingWithName
                              .replaceAll('{greeting}', greeting)
                              .replaceAll('{name}', name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                  ),
                  Text(
                    store?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (store?.tagline?.isNotEmpty == true)
                    Text(
                      store!.tagline!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                ],
              );
            }),
          ),
          SizedBox(width: AppSpacing.sm),
          Material(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.chip),
              side: const BorderSide(color: AppColors.line),
            ),
            child: IconButton(
              tooltip: AppStrings.aboutStore,
              onPressed: () => Get.to(() => const StoreDetailsScreen()),
              icon: const Icon(Icons.notifications_none_rounded),
              color: AppColors.ink,
              constraints: BoxConstraints.tightFor(
                width: AppSizes.homeBellButton,
                height: AppSizes.homeBellButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
