import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/screen_provider.dart';

class MyLineChart extends ConsumerStatefulWidget {
  const MyLineChart({super.key});

  @override
  ConsumerState<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends ConsumerState<MyLineChart> {
  // Data
  final List<double> originalData = [2, 5, 1, 7, 3, 7, 2];

  List<FlSpot> listToFlSpot(List spots) {
    return List.generate(
      spots.length,
      (index) => FlSpot(index.toDouble(), spots[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSideMenu = ref.watch(screenProvider);
    final minY = originalData.reduce((a, b) => a < b ? a : b);
    final maxY = originalData.reduce((a, b) => a > b ? a : b);

    return AspectRatio(
      aspectRatio: 2.0,
      child: Stack(
        children: [
          // Chart
          LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: listToFlSpot(originalData),
                  color: Theme.of(context).colorScheme.primary,
                  isCurved: true,
                  curveSmoothness: 0.3,
                  dotData: FlDotData(show: false),
                  barWidth: 3.5,
                  shadow: Shadow(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    blurRadius: mq.width * 0.02,
                    offset: Offset(0, mq.width * 0.02),
                  ),
                ),
              ],
              minY: minY - 1,
              maxY: maxY + 1,
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),

          // Animation
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              width: isSideMenu ? 0 : mq.width,
              duration: Duration(milliseconds: 1300),
              curve: Curves.easeInOutCubic,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ],
      ),
    );
  }
}
