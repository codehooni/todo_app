import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  work(label: 'work', iconData: Icons.work_outline, color: Colors.blue),
  @HiveField(1)
  personal(
    label: 'personal',
    iconData: Icons.person_outline,
    color: Colors.green,
  ),
  @HiveField(2)
  business(
    label: 'business',
    iconData: Icons.business_center,
    color: Colors.orange,
  ),
  @HiveField(3)
  study(label: 'study', iconData: Icons.school_outlined, color: Colors.purple);

  final String label;
  final IconData iconData;
  final Color color;

  const Category({
    required this.label,
    required this.iconData,
    required this.color,
  });
}
