import 'package:hive_flutter/adapters.dart';

import '../constants/category/category.dart';
import '../constants/priority/priority.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool isCompleted;
  @HiveField(3)
  final Priority priority;
  @HiveField(4)
  final Category category;
  @HiveField(5)
  final DateTime endDate;
  @HiveField(6)
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
    Category? category,
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
