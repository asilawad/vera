import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/responsive.dart';

class HomeSliverBox extends StatelessWidget {
  const HomeSliverBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: MaxWidthBox(child: child));
  }
}
