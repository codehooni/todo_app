import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/constants/category/category.dart';
import 'package:todo_app/constants/priority/priority.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:todo_app/router/go_router.dart';
import 'package:todo_app/theme/dark_mode.dart';
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
  await Hive.openBox('theme_mode');

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    mq = MediaQuery.of(context).size;
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}
