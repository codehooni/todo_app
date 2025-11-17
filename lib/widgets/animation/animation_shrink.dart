import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class AnimationShrink extends StatelessWidget {
  final bool isShrink;

  const AnimationShrink({super.key, required this.isShrink});

  @override
  Widget build(BuildContext context) {
    if (!isShrink) return SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: mq.height + mq.width,
        end: 0,
      ),
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      builder: (context, radius, child) {
        return CustomPaint(
          painter: CirclePainter(
            color: Theme.of(context).colorScheme.surfaceContainer,
            radius: radius,
          ),
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;
  final double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 왼쪽 상단으로 수축
    Offset center = Offset(mq.width * 0.2, mq.height * 0.35);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
