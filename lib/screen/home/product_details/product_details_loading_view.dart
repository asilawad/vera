import 'package:flutter/material.dart';

import 'package:souqna_anaqa/widget/states.dart';
import 'package:souqna_anaqa/widget/loading.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';

class ProductDetailsLoadingView extends StatelessWidget {
  const ProductDetailsLoadingView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlassAppBar(),
      body: errorMessage.isNotEmpty
          ? ErrorView(message: errorMessage, onRetry: onRetry)
          : const ProductDetailsSkeleton(),
    );
  }
}
