import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo.dart';

class TodoDatabaseService {
  final Box<Todo> _box = Hive.box<Todo>('todos');

  Future<void> saveData(List<Todo> todos) async {
    await _box.clear();
    _box.addAll(todos);
  }

  List<Todo> getTodos() {
    return _box.values.toList();
  }
}
