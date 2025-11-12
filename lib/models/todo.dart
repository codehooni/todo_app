import 'package:flutter/material.dart';

enum Priority {
  low(value: 1, label: '낮음', color: Colors.blue),
  medium(value: 2, label: '중간', color: Colors.yellow),
  high(value: 3, label: '높음', color: Colors.orange),
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

enum Categories {
  work(label: 'work', iconData: Icons.work_outline, color: Colors.blue),
  personal(
    label: 'personal',
    iconData: Icons.person_outline,
    color: Colors.green,
  ),
  business(
    label: 'business',
    iconData: Icons.business_center,
    color: Colors.orange,
  ),
  study(label: 'study', iconData: Icons.school_outlined, color: Colors.purple);

  final String label;
  final IconData iconData;
  final Color color;

  const Categories({
    required this.label,
    required this.iconData,
    required this.color,
  });
}

class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final Priority priority;
  final Categories category;
  final DateTime endDate;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.priority = Priority.low,
    required this.category,
    required this.endDate,
    required this.createdAt,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    Priority? priority,
    Categories? category,
    DateTime? endDate,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
