import 'package:flutter/material.dart';
import 'package:get/get.dart';

export 'package:souqna_anaqa/widget/skeleton/detail_skeletons.dart';
export 'package:souqna_anaqa/widget/skeleton/home_skeletons.dart';
export 'package:souqna_anaqa/widget/skeleton/product_skeletons.dart';
export 'package:souqna_anaqa/widget/skeleton/skeleton.dart';
export 'package:souqna_anaqa/widget/skeleton/skeleton_shimmer.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void showCustomLoading() {
    final overlay = Get.key.currentState?.overlay;
    if (overlay == null || _overlayEntry != null) return;

    final entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),
          Center(
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
    _overlayEntry = entry;
  }

  static void hideCustomLoading() {
    final entry = _overlayEntry;
    _overlayEntry = null;
    if (entry == null) return;
    try {
      entry.remove();
    } catch (_) {
      // The overlay can already have been removed during navigation or reload.
    }
  }
}
