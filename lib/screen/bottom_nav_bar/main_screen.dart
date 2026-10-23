import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:souqna_anaqa/screen/bottom_nav_bar/main_nav_widgets.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/shopping_screen.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/categories_screen.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/favorites_screen.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/home_screen.dart';
import 'package:souqna_anaqa/screen/bottom_nav_bar/more_screen.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

class MainScreenController extends GetxController {
  static MainScreenController get to => Get.find();
  final index = 0.obs;
  void go(int i) => index.value = i;
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const _tabs = [
    HomeScreen(),
    CategoriesScreen(),
    ShoppingScreen(),
    FavoritesScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final shell = Get.find<MainScreenController>();
    final sideNav = Responsive.useSideNav(context);
    return Scaffold(
      extendBody: !sideNav,
      body: sideNav
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainSideBar(index: shell.index, onSelect: shell.go),
                Expanded(
                  child: Obx(
                    () => PopScope(
                      canPop: shell.index.value == 0,
                      onPopInvokedWithResult: (didPop, _) {
                        if (!didPop) shell.go(0);
                      },
                      child: IndexedStack(
                        index: shell.index.value,
                        children: _tabs,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Obx(
              () => PopScope(
                canPop: shell.index.value == 0,
                onPopInvokedWithResult: (didPop, _) {
                  if (!didPop) shell.go(0);
                },
                child: IndexedStack(index: shell.index.value, children: _tabs),
              ),
            ),
      bottomNavigationBar: sideNav
          ? null
          : MainBottomBar(index: shell.index, onSelect: shell.go),
    );
  }
}
