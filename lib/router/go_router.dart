import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    // Home
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: <RouteBase>[
        // Add To-do Screen
        GoRoute(path: '/add', builder: (context, state) => AddTodoScreen()),
      ],
    ),
  ],
);
