import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/getx_controller/product_details_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
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
    int rating = 5;
    final comment = TextEditingController();
    await Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.rateProduct,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
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
                        size: 38,
                        color: const Color(0xFFF5A623),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: comment,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: AppStrings.reviewCommentHint,
                  ),
                ),
                const SizedBox(height: 16),
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
