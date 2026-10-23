import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class ProductReviewSheet {
  ProductReviewSheet._();

  static Future<void> show(
    BuildContext context, {
    required int productId,
    required ProductDetailsGetxController controller,
  }) async {
    final UserProfileGetxController profile = Get.find();
    if (!await profile.ensureLoggedIn()) return;
    if (!context.mounted) return;
    int rating = 5;
    final comment = TextEditingController();
    await Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.page,
            AppSpacing.page,
            AppSpacing.page,
            AppSpacing.page + MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.rateProduct,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => IconButton(
                      onPressed: () => setState(() => rating = i + 1),
                      icon: Icon(
                        i < rating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        size: AppSizes.reviewStar,
                        color: AppColors.star,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.compact),
                TextField(
                  controller: comment,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: AppStrings.reviewCommentHint,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () async {
                    Get.back();
                    await controller.addReview(
                      productId: productId,
                      rating: rating,
                      comment: comment.text,
                    );
                  },
                  child: const Text(AppStrings.submitReview),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
    comment.dispose();
  }
}
