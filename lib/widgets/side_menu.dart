import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/screen_provider.dart';

import 'my_line_chart.dart';

class SideMenu extends ConsumerStatefulWidget {
  const SideMenu({super.key});

  @override
  ConsumerState<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: mq.width * 0.75,
      padding: EdgeInsets.only(
        top: mq.height * 0.13,
        bottom: mq.height * 0.13,
        left: mq.width * 0.12,
        right: mq.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(mq.width * 0.07),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mq.height * 0.028),
              // Profile
              Stack(
                alignment: Alignment.center,
                children: [
                  ShadowProgressIndicator(
                    value: 0.3,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withAlpha(100),
                    color: Theme.of(context).colorScheme.tertiary,
                    strokeWidth: mq.width * 0.009,
                    size: mq.width * 0.26,
                  ),
                  CircleAvatar(
                    radius: mq.width * 0.105,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(mq.width * 0.5),
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.height * 0.033),

              // Name
              Text(
                'Ceyhun\nLee',
                style: TextStyle(
                  fontSize: mq.width * 0.085,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  height: mq.height * 0.0014,
                ),
              ),
              SizedBox(height: mq.height * 0.025),

              // Menu
              _buildMenu(context, ref),
              Spacer(),

              // Graph
              _buildGraph(context),

              // My State (Good, Bad)
              _buildMyState(context),
            ],
          ),

          // BackButton
          Align(
            alignment: AlignmentGeometry.topRight,
            child: GestureDetector(
              onTap: ref.read(screenProvider.notifier).toggleShowSide,
              child: Container(
                padding: EdgeInsets.all(mq.width * 0.025),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withAlpha(100),
                    width: 2,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.back,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMyState(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Good',
        style: TextStyle(
          fontSize: mq.width * 0.033,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(190),
        ),
      ),
      Text(
        'Consistency',
        style: TextStyle(
          fontSize: mq.width * 0.05,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
          letterSpacing: 0.1,
        ),
      ),
    ],
  );
}

Widget _buildGraph(BuildContext context) {
  return MyLineChart();
}

Widget _buildMenu(BuildContext context, WidgetRef ref) {
  return Column(
    children: [
      _buildMenuItem(context, Icons.home, 'Home', '/', ref),
      _buildMenuItem(
        context,
        Icons.bookmark_border_rounded,
        'Templates',
        '/templates',
        ref,
      ),
      // _buildMenuItem(context, Icons.category, 'Categories', '/categories', ref),
      _buildMenuItem(
        context,
        CupertinoIcons.chart_pie,
        'Analytics',
        '/analytics',
        ref,
      ),
      _buildMenuItem(context, Icons.settings, 'Settings', '/settings', ref),
    ],
  );
}

Widget _buildMenuItem(
  BuildContext context,
  IconData icon,
  String title,
  String route,
  WidgetRef ref,
) {
  return GestureDetector(
    onTap: () {
      context.go(route);
      ref.read(screenProvider.notifier).toggleShowSide();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
      child: Row(
        children: [
          Icon(
            icon,
            size: mq.width * 0.065,
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withAlpha(190),
          ),
          SizedBox(width: mq.width * 0.04),
          Text(
            title,
            style: TextStyle(
              fontSize: mq.width * 0.04,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}

// ShadowProgressIndicator
class ShadowProgressIndicator extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;
  final double size;

  const ShadowProgressIndicator({
    super.key,
    required this.value,
    this.backgroundColor = Colors.grey,
    this.color = Colors.blue,
    this.strokeWidth = 8.0,
    this.size = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ShadowProgressPainter(
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _ShadowProgressPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;

  _ShadowProgressPainter({
    required this.value,
    required this.backgroundColor,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 배경원 회색
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress 원
    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1);

    // 그림자 레이어 (더 큰 blur)
    final shadowPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth + 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);

    final sweepAngle = 2 * pi * value;

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, shadowPaint);

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(_ShadowProgressPainter oldDelegated) {
    return oldDelegated.value != value ||
        oldDelegated.color != color ||
        oldDelegated.strokeWidth != strokeWidth;
  }
}
