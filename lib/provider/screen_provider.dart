import 'package:flutter_riverpod/flutter_riverpod.dart';

final screenProvider = NotifierProvider<ScreenNotifier, bool>(() {
  return ScreenNotifier();
});

class ScreenNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggleShowSide() {
    state = !state;
  }
}
