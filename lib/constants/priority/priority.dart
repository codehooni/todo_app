import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'priority.g.dart';

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low(value: 1, label: '낮음', color: Colors.blue),
  @HiveField(1)
  medium(value: 2, label: '중간', color: Colors.yellow),
  @HiveField(2)
  high(value: 3, label: '높음', color: Colors.orange),
  @HiveField(3)
  urgent(value: 4, label: '긴금', color: Colors.red);

  final int value;
  final String label;
  final Color color;

  const Priority({
    required this.value,
    required this.label,
    required this.color,
  });
}
