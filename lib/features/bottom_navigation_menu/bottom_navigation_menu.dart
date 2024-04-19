import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:iconsax/iconsax.dart';

class DashBoardBottomMenu extends StatefulWidget {
  const DashBoardBottomMenu({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<DashBoardBottomMenu> createState() => _DashBoardBottomMenuState();
}

class _DashBoardBottomMenuState extends State<DashBoardBottomMenu>
    with TickerProviderStateMixin {
  late AnimationController _iconAnimationController;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconScale =
        Tween<double>(begin: 0.8, end: 1.0).animate(_iconAnimationController);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _goBranch,
          currentIndex: widget.navigationShell.currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: ScaleTransition(
                  scale: iconScale,
                  child: const Icon(Iconsax.home),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ScaleTransition(
                  scale: iconScale,
                  child: const Icon(Iconsax.shop),
                ),
                label: 'Store'),
            BottomNavigationBarItem(
                icon: ScaleTransition(
                  scale: iconScale,
                  child: const Icon(Iconsax.heart),
                ),
                label: 'Wishlist'),
            BottomNavigationBarItem(
                icon: ScaleTransition(
                  scale: iconScale,
                  child: const Icon(Iconsax.user),
                ),
                label: 'Account')
          ]),
    );
  }
}
