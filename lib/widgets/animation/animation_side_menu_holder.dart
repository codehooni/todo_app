import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/screen_provider.dart';

class AnimationSideMenuHolder extends ConsumerStatefulWidget {
  final Widget sideMenu;

  const AnimationSideMenuHolder({super.key, required this.sideMenu});

  @override
  ConsumerState createState() => _AnimationSideMenuHolderState();
}

class _AnimationSideMenuHolderState
    extends ConsumerState<AnimationSideMenuHolder> {
  @override
  Widget build(BuildContext context) {
    final isSideMenu = ref.watch(screenProvider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.translationValues(isSideMenu ? 0 : -mq.width, 0, 0),
      child: widget.sideMenu,
    );
  }
}
