import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/filter_provider.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../constants/category/category.dart';
import '../main.dart';

class CategoryContainer extends ConsumerStatefulWidget {
  final Category category;

  const CategoryContainer({super.key, required this.category});

  @override
  ConsumerState<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends ConsumerState<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    // 선택된 Category 확인 변수
    final selectedCategory = ref.watch(categoryProvider);

    // Task 분석
    final todos = ref
        .watch(todoProvider)
        .where((t) => t.category == widget.category);
    final int countTasks = todos.length;
    final int completedTasks = todos.fold(
      0,
      (count, t) => t.isCompleted ? count + 1 : count,
    );
    final double percent = countTasks != 0 ? completedTasks / countTasks : 0;

    // 크기를 위한 변수들
    final totalContainerWidth = mq.width * 0.45;
    final horizontalPadding = mq.width * 0.035;
    final progressBarHeight = mq.height * 0.007;
    final progressBarWidth = totalContainerWidth - (horizontalPadding * 2);

    final progressBarVerticalIconWidth = progressBarHeight / 2;
    double progressBarVerticalIconPadding =
        progressBarWidth * percent - progressBarVerticalIconWidth;
    // padding이 0보다 작아지면 0
    if (progressBarVerticalIconPadding < 0) {
      progressBarVerticalIconPadding = 0;
    }

    return GestureDetector(
      onTap: () {
        ref
            .read(categoryProvider.notifier)
            .selectCategory(
              selectedCategory != widget.category ? widget.category : null,
            );
      },
      child: Container(
        width: totalContainerWidth,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        margin: EdgeInsets.only(right: mq.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mq.width * 0.05),
          color: Theme.of(context).colorScheme.surfaceContainer,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withAlpha(30),
              offset: Offset(0.0, mq.height * 0.004),
              spreadRadius: 0.1,
              blurRadius: mq.height * 0.004,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mq.height * 0.033),
            // count of tasks
            Text(
              '$countTasks tasks',
              style: TextStyle(
                fontSize: mq.width * 0.03,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: mq.height * 0.005),
            // Category Name
            Text(
              widget.category.label,
              style: TextStyle(
                fontSize: mq.width * 0.048,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),

            // Progress bar
            SizedBox(
              width: double.infinity,
              height: progressBarHeight,
              child: Stack(
                alignment: AlignmentGeometry.bottomLeft,
                children: [
                  // 어두운 부분
                  Container(
                    width: progressBarWidth,
                    height: progressBarHeight / 2,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withAlpha(50),
                      borderRadius: BorderRadius.circular(mq.width * 0.015),
                    ),
                  ),

                  // 프로그래스 상태 색칠
                  Container(
                    width: progressBarWidth * percent,
                    height: progressBarHeight / 2,
                    decoration: BoxDecoration(
                      color: widget.category.color,
                      borderRadius: BorderRadius.circular(mq.width * 0.015),
                      boxShadow: [
                        BoxShadow(
                          color: widget.category.color.withAlpha(90),
                          offset: Offset(0.0, mq.height * 0.005),
                          spreadRadius: 0.1,
                          blurRadius: mq.height * 0.005,
                        ),
                      ],
                    ),
                  ),

                  // 위로 튀어나온 아이콘
                  Padding(
                    padding: EdgeInsets.only(
                      left: progressBarVerticalIconPadding,
                    ),
                    child: Container(
                      width: progressBarVerticalIconWidth,
                      height: progressBarHeight,
                      decoration: BoxDecoration(
                        color: widget.category.color,
                        borderRadius: BorderRadius.circular(mq.width * 0.015),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mq.height * 0.016),
          ],
        ),
      ),
    );
  }
}
