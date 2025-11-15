import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/analytics/analytics_screen.dart';
import 'package:todo_app/screens/home/add_todo_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/main_screen.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      // Main
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        // Home
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
          routes: [
            GoRoute(path: '/add', builder: (context, state) => AddTodoScreen()),
          ],
        ),

        // Analysis
        GoRoute(
          path: '/analytics',
          builder: (context, state) => AnalyticsScreen(),
        ),
      ],
    ),
  ],
);
