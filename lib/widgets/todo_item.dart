import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../models/todo.dart';

class TodoItem extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: mq.height * 0.01),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05,
          vertical: mq.height * 0.025,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(mq.height * 0.025),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildCheckContainer(context, ref),
            SizedBox(width: mq.width * 0.04),
            Text(
              widget.todo.title,
              style: TextStyle(
                fontSize: mq.width * 0.04,
                decoration: widget.todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckContainer(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(todoProvider.notifier).toggleTodo(widget.todo.id);
      },
      child: Container(
        width: mq.width * 0.06,
        height: mq.width * 0.06,
        decoration: widget.todo.isCompleted
            ? BoxDecoration(shape: BoxShape.circle, color: Colors.grey)
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.todo.category.color,
                  width: mq.width * 0.006,
                ),
              ),
        child: widget.todo.isCompleted
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: Theme.of(context).colorScheme.onPrimary,
                size: mq.width * 0.05,
              )
            : null,
      ),
    );
  }
}
