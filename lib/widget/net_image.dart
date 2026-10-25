import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_motion.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/widget/loading.dart';

/// صورة من الإنترنت مع تخزين مؤقت وهيكل تحميل لطيف.
class NetImage extends StatelessWidget {
  const NetImage(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = 0,
    this.width,
    this.height,
  });

  final String? url;
  final BoxFit fit;
  final double radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      color: AppColors.sand,
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: AppColors.subtle),
    );
    final Widget image;
    if (url == null || url!.isEmpty) {
      image = placeholder;
    } else {
      image = CachedNetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: AppMotion.normal,
        placeholder: (_, _) => SkeletonShimmer(
          child: Skeleton(width: width, height: height),
        ),
        errorWidget: (_, _, _) => placeholder,
      );
    }
    return radius == 0
        ? image
        : ClipRRect(borderRadius: BorderRadius.circular(radius), child: image);
  }
}
