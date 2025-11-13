import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/constants/category/category.dart';
import 'package:todo_app/constants/priority/priority.dart';
import 'package:todo_app/router/go_router.dart';
import 'package:todo_app/theme/light_mode.dart';

import 'models/todo.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // HIVE SETTINGS
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Todo>('todos');

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp.router(theme: lightMode, routerConfig: goRouter);
  }
}
