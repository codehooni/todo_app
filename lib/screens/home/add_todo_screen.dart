import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';

import 'package:todo_app/utils/date_utils.dart' as date_utils;
import 'package:uuid/uuid.dart';

import '../../constants/category/category.dart';
import '../../constants/priority/priority.dart';
import '../../main.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen> {
  // FormKey
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  // Category
  Category selectedCategory = Category.work;

  // Priority
  Priority priority = Priority.low;

  // EndDate
  DateTime? endDate;

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: mq.width * 0.1),
              child: Column(
                children: [
                  SizedBox(height: mq.height * 0.02),
                  // Back Button
                  _buildAnimation(
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(mq.width * 0.025),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant.withAlpha(100),
                                width: 2,
                              ),
                            ),
                            child: Icon(CupertinoIcons.xmark),
                          ),
                        ),
                      ],
                    ),
                    _visibles[0],
                  ),

                  SizedBox(height: mq.height * 0.2),

                  // TextField
                  _buildAnimation(
                    TextFormField(
                      controller: controller,
                      maxLength: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: mq.width * 0.055),
                      decoration: InputDecoration(
                        hintText: 'Enter New Task',
                        hintStyle: TextStyle(fontSize: mq.width * 0.055),
                        border: InputBorder.none,
                      ),
                    ),
                    _visibles[1],
                  ),

                  SizedBox(height: mq.height * 0.04),

                  // Calendar & Categories
                  _buildAnimation(
                    GestureDetector(
                      onTap: () => _selectEndDate(context),
                      child: Row(
                        children: [
                          // Calendar Button
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: mq.height * 0.012,
                              horizontal: mq.width * 0.045,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                mq.width * 0.1,
                              ),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant.withAlpha(100),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  size: mq.width * 0.055,
                                ),

                                SizedBox(width: mq.width * 0.03),

                                Text(
                                  date_utils.DateUtils.getDateText(endDate),
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    fontSize: mq.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: mq.width * 0.02),

                          // Categories Button
                          GestureDetector(
                            onTap: () => _selectCategoriesBottomSheet(context),
                            child: Container(
                              padding: EdgeInsets.all(mq.width * 0.025),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant.withAlpha(100),
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(mq.width * 0.006),
                                height: mq.width * 0.055,
                                width: mq.width * 0.055,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: mq.width * 0.005,
                                    color: selectedCategory.color,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCategory.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _visibles[2],
                  ),

                  SizedBox(height: mq.height * 0.13),

                  // 궁금한 버튼들
                  _buildAnimation(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        Icon(
                          Icons.create_new_folder_outlined,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: mq.width * 0.07,
                        ),
                        InkWell(
                          onTap: _onPriority,
                          child: Icon(
                            Icons.flag,
                            color: priority.color,
                            size: mq.width * 0.07,
                          ),
                        ),
                        Icon(
                          Icons.nightlight_outlined,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: mq.width * 0.07,
                        ),
                        SizedBox(),
                      ],
                    ),
                    _visibles[3],
                  ),

                  SizedBox(height: mq.height * 0.13),

                  // Task 추가하기
                  _buildAnimation(
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final todo = Todo(
                                id: Uuid().v4(),
                                title: controller.text,
                                category: selectedCategory,
                                priority: priority,
                                createdAt: DateTime.now(),
                                endDate: endDate ?? DateTime.now(),
                              );
                              ref.read(todoProvider.notifier).addTodo(todo);
                              context.pop();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: mq.height * 0.02,
                              horizontal: mq.width * 0.1,
                            ),
                            margin: EdgeInsets.only(bottom: mq.height * 0.05),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                mq.width * 0.1,
                              ),
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'New Task',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                    fontSize: mq.width * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: mq.width * 0.02),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  size: mq.width * 0.056,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _visibles[4],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPriority() {
    setState(() {
      if (priority == Priority.low) {
        priority = Priority.medium;
      } else if (priority == Priority.medium) {
        priority = Priority.high;
      } else if (priority == Priority.high) {
        priority = Priority.urgent;
      } else {
        priority = Priority.low;
      }
    });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    setState(() {
      endDate = pickedDate;
    });
  }

  void _selectCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mq.width * 0.07),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(mq.width * 0.06),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Category',
                style: TextStyle(
                  fontSize: mq.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mq.height * 0.02),

              _buildCategoryItem(Category.work),
              _buildCategoryItem(Category.personal),
              _buildCategoryItem(Category.business),
              _buildCategoryItem(Category.study),
            ],
          ),
        );
      },
    );
  }

  _buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
        context.pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: mq.height * 0.015,
          horizontal: mq.width * 0.04,
        ),
        margin: EdgeInsets.only(bottom: mq.height * 0.01),
        decoration: BoxDecoration(
          color: category.color.withAlpha(25),
          borderRadius: BorderRadius.circular(mq.width * 0.03),
          border: Border.all(
            color: selectedCategory == category
                ? category.color
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(mq.width * 0.02),
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.iconData,
                color: Colors.white,
                size: mq.width * 0.05,
              ),
            ),
            SizedBox(width: mq.width * 0.03),
            Text(
              category.label,
              style: TextStyle(
                fontSize: mq.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
