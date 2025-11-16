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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body: Stack(
        children: [
          // Side Menu
          AnimationSideMenuHolder(sideMenu: SideMenu()),

          // Screens (Home, Analysis, ...)
          AnimationScreensHolder(screen: widget.child),
        ],
      ),
    );
  }
}
