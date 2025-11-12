import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => <Todo>[];

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void toggleTodo(String todoId) {
    state = state.map((t) {
      if (t.id == todoId) {
        return t.copyWith(isCompleted: !t.isCompleted);
      }
      return t;
    }).toList();
  }

  void removeTodo(String todoId) {
    state = state.where((t) => t.id != todoId).toList();
  }

  void editTodo(String todoId, Todo newTodo) {
    state = state.map((t) {
      if (t.id == todoId) {
        return newTodo;
      }
      return t;
    }).toList();
  }
}
