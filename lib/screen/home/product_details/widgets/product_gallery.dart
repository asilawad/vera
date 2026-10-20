import 'package:flutter/material.dart';

import 'package:souqna_anaqa/widget/net_image.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({
    super.key,
    required this.images,
    required this.imageIndex,
    required this.heroTag,
    required this.onPageChanged,
  });

  final List<String> images;
  final int imageIndex;
  final String heroTag;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: images.length,
          onPageChanged: onPageChanged,
          itemBuilder: (_, i) => i == 0
              ? Hero(tag: heroTag, child: NetImage(images[i]))
              : NetImage(images[i]),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 18,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == imageIndex ? 20 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == imageIndex ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
