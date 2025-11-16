import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/analytics/analytics_screen.dart';
import 'package:todo_app/screens/category/category_screen.dart';
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
          pageBuilder: (context, state) =>
              NoTransitionPage(child: HomeScreen()),
          routes: [
            GoRoute(
              path: '/add',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: AddTodoScreen()),
            ),
          ],
        ),

        // Analysis
        GoRoute(
          path: '/analytics',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: AnalyticsScreen()),
        ),
        GoRoute(
          path: '/categories',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: CategoryScreen()),
        ),
      ],
    ),
  ],
);
