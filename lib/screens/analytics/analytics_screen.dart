import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/screen_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
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
