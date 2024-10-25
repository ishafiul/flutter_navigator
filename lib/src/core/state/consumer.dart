import 'package:flutter/widgets.dart';

class ConsumerState<T> extends StatelessWidget {
  const ConsumerState({
    required this.notifier,
    required this.listener,
    required this.builder,
    super.key,
  });
  final ValueNotifier<T> notifier;
  final void Function(T) listener;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: notifier,
      builder: (context, value, child) {
        listener(value); // Trigger the listener whenever the value changes
        return builder(context, value);
      },
    );
  }
}
