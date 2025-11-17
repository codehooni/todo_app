import 'dart:async';

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
  bool isFAB = false;
  late Completer<bool> completer;
  final Duration _deleteDelay = Duration(seconds: 2);
  Timer? _deleteTimer;

  Color? _checkColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Theme 변경 시 색상 업데이트
    if (widget.todo.isCompleted && _checkColor != null) {
      _checkColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 첫 build 시에만 초기화
    _checkColor ??= widget.todo.isCompleted
        ? Theme.of(context).colorScheme.surfaceContainerHigh
        : null;

    return Dismissible(
      key: Key(widget.todo.id),
      movementDuration: Duration(milliseconds: 300),
      resizeDuration: Duration(milliseconds: 200),
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (_) {
          if (!completer.isCompleted) {
            completer.complete(true);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.delete,
                  size: mq.width * 0.05,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: mq.width * 0.03),
                Text(
                  'The task was deleted',
                  style: TextStyle(
                    fontSize: mq.width * 0.04,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            // UNDO Button
            GestureDetector(
              onTap: () {
                if (!completer.isCompleted) {
                  completer.complete(true);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: mq.width * 0.015,
                  horizontal: mq.width * 0.025,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withAlpha(100),
                  ),
                  borderRadius: BorderRadius.circular(mq.width * 0.05),
                ),
                child: Text(
                  'UNDO',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: mq.width * 0.035,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        _deleteTimer?.cancel();

        completer = Completer();

        _deleteTimer = Timer(_deleteDelay, () {
          if (!completer.isCompleted) {
            completer.complete(false);
          }
        });

        final shouldUndo = await completer.future;

        if (!shouldUndo) {
          return true;
        } else {
          _deleteTimer?.cancel();
          return false;
        }
      },
      onDismissed: (_) {
        ref.read(todoProvider.notifier).removeTodo(widget.todo.id);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: mq.height * 0.01),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(mq.height * 0.025),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * 0.05,
            vertical: mq.height * 0.025,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildCheckContainer(context, ref),
              SizedBox(width: mq.width * 0.04),
              Expanded(
                child: Text(
                  widget.todo.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: mq.width * 0.04,
                    decoration: widget.todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckContainer(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (!widget.todo.isCompleted) {
          setState(() {
            _checkColor = widget.todo.category.color;
          });
          Future.delayed(Duration(milliseconds: 150), () {
            if (mounted) {
              setState(() {
                _checkColor = Theme.of(
                  context,
                ).colorScheme.surfaceContainerHigh;
              });
            }
          });
        } else {
          setState(() {
            _checkColor = widget.todo.category.color;
          });
          Future.delayed(Duration(milliseconds: 150), () {
            if (mounted) {
              setState(() {
                _checkColor = Theme.of(
                  context,
                ).colorScheme.surfaceContainerHigh;
              });
            }
          });
        }

        ref.read(todoProvider.notifier).toggleTodo(widget.todo.id);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: mq.width * 0.06,
        height: mq.width * 0.06,
        decoration: widget.todo.isCompleted
            ? BoxDecoration(shape: BoxShape.circle, color: _checkColor)
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
