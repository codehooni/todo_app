import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/screen_provider.dart';
import 'package:todo_app/widgets/animation/animation_side_menu_holder.dart';
import 'package:todo_app/widgets/side_menu.dart';

import '../widgets/animation/animation_screens_holder.dart';

class MainScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final isShowSide = ref.watch(screenProvider);

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: isShowSide ? Curves.easeOutQuart : Curves.easeInQuart,
        color: isShowSide
            ? Theme.of(context).colorScheme.inverseSurface
            : Theme.of(context).colorScheme.shadow.withAlpha(60),
        child: Stack(
          children: [
            // Side Menu
            AnimationSideMenuHolder(sideMenu: SideMenu()),

            // Screens (Home, Analysis, ...)
            AnimationScreensHolder(screen: widget.child),
          ],
        ),
      ),
    );
  }
}
