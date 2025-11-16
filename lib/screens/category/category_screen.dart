import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/screen_provider.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Screen'),
        leading: IconButton(
          onPressed: () {
            ref.read(screenProvider.notifier).toggleShowSide();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
    );
  }
}
