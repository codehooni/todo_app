import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  work(
    label: 'work',
    iconData: Icons.work_outline,
    color: Color(0xFF06B6D4), // Teal Cyan
  ),
  @HiveField(1)
  personal(
    label: 'personal',
    iconData: Icons.person_outline,
    color: Color(0xFFF472B6), // Soft Pink
  ),
  @HiveField(2)
  business(
    label: 'business',
    iconData: Icons.business_center,
    color: Color(0xFFFB923C), // Warm Orange
  ),
  @HiveField(3)
  study(
    label: 'study',
    iconData: Icons.school_outlined,
    color: Color(0xFFA78BFA), // Soft Lavender
  );

  final String label;
  final IconData iconData;
  final Color color;

  const Category({
    required this.label,
    required this.iconData,
    required this.color,
  });
}
