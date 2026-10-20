import 'package:flutter/material.dart';

abstract final class CategoryIcons {
  static const _icons = <String, IconData>{
    'accessories': Icons.watch_outlined,
    'bags': Icons.shopping_bag_outlined,
    'beauty': Icons.spa_outlined,
    'clothing': Icons.checkroom_outlined,
    'dress': Icons.checkroom_outlined,
    'electronics': Icons.devices_outlined,
    'fashion': Icons.checkroom_outlined,
    'home': Icons.home_outlined,
    'jewelry': Icons.diamond_outlined,
    'kids': Icons.child_friendly_outlined,
    'perfume': Icons.spa_outlined,
    'shoes': Icons.directions_walk_outlined,
    'sports': Icons.sports_soccer_outlined,
    'women': Icons.checkroom_outlined,
  };

  static IconData forKey(String? key) =>
      _icons[key?.trim().toLowerCase()] ?? Icons.sell_outlined;
}
