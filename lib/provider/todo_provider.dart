import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/service/database_service.dart';

import '../models/todo.dart';

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});

class TodoNotifier extends Notifier<List<Todo>> {
  final DatabaseService databaseService = DatabaseService();

  @override
  List<Todo> build() {
    return databaseService.getTodos();
  }

  void addTodo(Todo todo) {
    state = [...state, todo];
    databaseService.saveData(state);
  }

  void toggleTodo(String todoId) {
    state = state.map((t) {
      if (t.id == todoId) {
        return t.copyWith(isCompleted: !t.isCompleted);
      }
      return t;
    }).toList();
    databaseService.saveData(state);
  }

  void removeTodo(String todoId) {
    state = state.where((t) => t.id != todoId).toList();
    databaseService.saveData(state);
  }

  void editTodo(String todoId, Todo newTodo) {
    state = state.map((t) {
      if (t.id == todoId) {
        return newTodo;
      }
      return t;
    }).toList();
    databaseService.saveData(state);
  }

  void reorderTodo(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }

    final todo = state.removeAt(oldIndex);

    state.insert(newIndex, todo);

    databaseService.saveData(state);

    state = [...state];
  }
}
