import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/screen_provider.dart';

class AnimationScreensHolder extends ConsumerStatefulWidget {
  final Widget screen;

  const AnimationScreensHolder({super.key, required this.screen});

  @override
  ConsumerState<AnimationScreensHolder> createState() => _ScreensHolderState();
}

class _ScreensHolderState extends ConsumerState<AnimationScreensHolder> {
  final xOffset = mq.width * 0.8;
  final yOffset = mq.height * 0.1;
  final scale = 0.8;

  @override
  Widget build(BuildContext context) {
    final bool isSideMenu = ref.watch(screenProvider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      transform: isSideMenu
          ? (Matrix4.translationValues(xOffset, yOffset, 0)..scale(scale))
          : Matrix4.identity(),
      curve: Curves.fastOutSlowIn,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(mq.width * 0.1),
        child: widget.screen,
      ),
    );
  }
}
