import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/constants/category/category.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../models/todo.dart';

// CATEGORY
final categoryProvider = NotifierProvider<CategoryNotifier, Category?>(() {
  return CategoryNotifier();
});

class CategoryNotifier extends Notifier<Category?> {
  @override
  Category? build() {
    return null;
  }

  void selectCategory(Category? category) {
    state = category;
  }
}

// PRIORITY
final priorityProvider = NotifierProvider<PriorityNotifier, Priority?>(() {
  return PriorityNotifier();
});

class PriorityNotifier extends Notifier<Priority?> {
  @override
  Priority? build() {
    return null;
  }

  void selectPriority(Priority? priority) {
    state = priority;
  }
}

/*

 F I L T E R  P R O V I D E R

*/
final filteredTodoProvider = NotifierProvider<FilterNotifier, List<Todo>>(() {
  return FilterNotifier();
});

class FilterNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    final category = ref.watch(categoryProvider);
    final priority = ref.watch(priorityProvider);
    final todos = ref.watch(todoProvider);

    List<Todo> filteredTodos = [];

    if (todos.isEmpty) {
      return [];
    }

    if (category != null) {
      filteredTodos = [...todos.where((t) => t.category == category)];
    } else {
      filteredTodos = [...todos];
    }

    // if (priority != null) {
    //   filteredTodos = [
    //     ...filteredTodos,
    //     ...todos.where((t) => t.priority == priority),
    //   ];
    // }

    return filteredTodos;
  }
}
