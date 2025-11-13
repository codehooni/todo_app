import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo.dart';

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});

class TodoNotifier extends Notifier<List<Todo>> {
  final Box<Todo> _box = Hive.box<Todo>('todos');

  @override
  List<Todo> build() {
    return _box.values.toList();
  }

  void addTodo(Todo todo) {
    _box.put(todo.id, todo);
    state = [...state, todo];
  }

  void toggleTodo(String todoId) {
    state = state.map((t) {
      if (t.id == todoId) {
        final updated = t.copyWith(isCompleted: !t.isCompleted);
        _box.put(todoId, updated);
        return updated;
      }
      return t;
    }).toList();
  }

  void removeTodo(String todoId) {
    _box.delete(todoId);
    state = state.where((t) => t.id != todoId).toList();
  }

  void editTodo(String todoId, Todo newTodo) {
    _box.put(todoId, newTodo);
    state = state.map((t) {
      if (t.id == todoId) {
        return newTodo;
      }
      return t;
    }).toList();
  }
}
