import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/favorites_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/models/product.dart';
import 'package:souqna_anaqa/widget/glass_container.dart';

/// قلب المفضلة مع حركة نبض.
class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon(
    this.product, {
    super.key,
    this.size = 36,
    this.glass = false,
  });

  final Product product;
  final double size;
  final bool glass;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final active = Get.find<FavoritesGetxController>().isFavorite(product.id);
      final duration = MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : AppMotion.fast;
      final shape = glass
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.chip),
            )
          : const CircleBorder();
      final button = Material(
        color: glass ? AppColors.transparent : AppColors.favoriteSurface,
        shape: shape,
        elevation: 0,
        child: InkWell(
          customBorder: shape,
          onTap: () async {
            final UserProfileGetxController profile = Get.find();
            if (!await profile.ensureLoggedIn()) return;
            await Get.find<FavoritesGetxController>().toggleFavorite(product);
          },
          child: SizedBox(
            width: size,
            height: size,
            child: AnimatedSwitcher(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : AppMotion.normal,
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: AnimatedScale(
                scale: active ? AppSizes.favoritePopScale : 1,
                duration: duration,
                curve: AppMotion.bounce,
                child: Icon(
                  active
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  key: ValueKey(active),
                  size: size * AppSizes.favoriteIconScale,
                  color: active ? AppColors.danger : AppColors.ink,
                ),
              ),
            ),
          ),
        ),
      );
      return glass
          ? GlassContainer(radius: AppRadius.chip, child: button)
          : button;
    });
  }
}
