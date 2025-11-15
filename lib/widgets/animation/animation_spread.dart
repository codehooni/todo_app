import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

class AnimationSpread extends StatelessWidget {
  final bool isFAB;

  const AnimationSpread({super.key, required this.isFAB});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isFAB ? mq.height + mq.width : 0),
      duration: Duration(milliseconds: 300),
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

    // offset으로 원의 중심 지정 (오른쪽 하단)
    Offset center = Offset(mq.width - 16, mq.height - 16);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.color != color;
  }
}
