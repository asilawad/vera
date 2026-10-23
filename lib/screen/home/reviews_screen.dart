import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

import 'package:souqna_anaqa/getx_controller/reviews_getx_controller.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/widget/loading.dart';
import 'package:souqna_anaqa/widget/review_card.dart';
import 'package:souqna_anaqa/widget/states.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';

/// «كل التقييمات» لمنتج — تُحمَّل صفحة بعد صفحة مع النزول.
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId, this.productName});

  final int productId;
  final String? productName;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  late final String _tag = 'reviews-${widget.productId}';
  late final ReviewsGetxController c = Get.put(
    ReviewsGetxController(productId: widget.productId),
    tag: _tag,
  );
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
        c.fetchReviews(more: true);
      }
    });
  }

  @override
  void dispose() {
    Get.delete<ReviewsGetxController>(tag: _tag);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        title: Obx(
          () => Text(
            c.total.value > 0
                ? 'كل التقييمات (${c.total.value})'
                : 'كل التقييمات',
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: AppSizes.appBarHeight + MediaQuery.paddingOf(context).top,
        ),
        child: Obx(() {
          if (c.isLoading.value) {
            return _ReviewListState(c, _scroll, loading: true);
          }
          if (c.errorMessage.isNotEmpty) {
            return ErrorView(
              message: c.errorMessage.value,
              onRetry: c.fetchReviews,
            );
          }
          return _ReviewListState(c, _scroll);
        }),
      ),
    );
  }
}

class _ReviewListState extends StatelessWidget {
  const _ReviewListState(this.controller, this.scroll, {this.loading = false});

  final ReviewsGetxController controller;
  final ScrollController scroll;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (loading && controller.reviewsList.isEmpty) {
        return const ReviewsSkeleton();
      }
      if (controller.reviewsList.isEmpty) {
        return const EmptyView(
          icon: Icons.rate_review_outlined,
          title: 'لا توجد تقييمات بعد',
          body: 'كوني أول من يقيّم هذا المنتج.',
        );
      }
      return RefreshIndicator(
        onRefresh: controller.fetchReviews,
        child: ListView.builder(
          controller: scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: centeredPadding(
            MediaQuery.sizeOf(context).width,
            maxWidth: Responsive.readingMaxWidth,
            top: 20,
            bottom: 20 + MediaQuery.paddingOf(context).bottom,
          ),
          itemCount:
              controller.reviewsList.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (_, i) => i < controller.reviewsList.length
              ? ReviewCard(controller.reviewsList[i])
              : Padding(
                  padding: EdgeInsetsDirectional.all(AppSpacing.lg),
                  child: const SkeletonShimmer(child: ReviewRowSkeleton()),
                ),
        ),
      );
    });
  }
}
