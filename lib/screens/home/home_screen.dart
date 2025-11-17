import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/constants/category/category.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/filter_provider.dart';
import 'package:todo_app/provider/screen_provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/widgets/animation/animation_spread.dart';
import 'package:todo_app/widgets/todo_item.dart';

import '../../models/todo.dart';
import '../../widgets/category_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isFAB = false;

  // Animation
  final List<bool> _visibles = List.generate(5, (index) => false);

  Widget _buildAnimation(Widget child, bool visible) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : Offset(0, -0.05),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _visibles.length; i++) {
      await Future.delayed(Duration(milliseconds: i == 0 ? 100 : 100));
      if (mounted) setState(() => _visibles[i] = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Todo> todos = ref.watch(filteredTodoProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mq.height * 0.015),
                  _buildAnimation(_buildAppBar(), _visibles[0]),

                  SizedBox(height: mq.height * 0.035),
                  _buildAnimation(_buildTitle(), _visibles[1]),
                  SizedBox(height: mq.height * 0.025),
                  _buildAnimation(_buildCategory(), _visibles[2]),

                  Expanded(
                    child: _buildAnimation(
                      _buildTodos(todos, ref),
                      _visibles[3],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: _buildAnimation(
            GestureDetector(
              onTap: () async {
                setState(() {
                  isFAB = true;
                });
                await Future.delayed(Duration(milliseconds: 300));

                if (!context.mounted) return;
                await context.push('/add');
                setState(() {
                  isFAB = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(mq.width * 0.04),
                margin: EdgeInsets.only(right: mq.width * 0.025),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(100),
                      offset: Offset(0.0, mq.width * 0.015),
                      blurRadius: mq.width * 0.015,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: mq.width * 0.06,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            _visibles[4],
          ),
        ),
        AnimationSpread(isFAB: isFAB),
      ],
    );
  }

  Widget _buildTodos(List<Todo> todos, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: mq.height * 0.03),
        Text(
          'TODAY\'S TASKS',
          style: TextStyle(
            fontSize: mq.width * 0.033,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: mq.height * 0.02),

        Expanded(
          child: ReorderableListView.builder(
            onReorder: (int oldIndex, int newIndex) {
              ref.read(todoProvider.notifier).reorderTodo(oldIndex, newIndex);
            },
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoItem(key: Key(todo.id), todo: todo);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CATEGORIES',
          style: TextStyle(
            fontSize: mq.width * 0.033,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: mq.height * 0.02),

        SizedBox(
          height: mq.height * 0.133,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: mq.height * 0.007),
            itemCount: Category.values.length,
            itemBuilder: (context, index) =>
                CategoryContainer(category: Category.values[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    final textSize = mq.width * 0.08;
    return Text(
      'What\'s up, Ceyhun!',
      style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAppBar() {
    Color iconColor = Theme.of(context).colorScheme.onSurfaceVariant;
    double iconSize = mq.width * 0.08;
    double iconPadding = mq.width * 0.06;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            ref.read(screenProvider.notifier).toggleShowSide();
          },
          child: Icon(Icons.menu, color: iconColor, size: iconSize),
        ),
        Spacer(),
        Icon(Icons.search, color: iconColor, size: iconSize),
        SizedBox(width: iconPadding),
        Icon(
          Icons.notifications_none_outlined,
          color: iconColor,
          size: iconSize,
        ),
      ],
    );
  }
}
