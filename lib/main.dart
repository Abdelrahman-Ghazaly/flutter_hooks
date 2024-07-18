import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            notifier.value.toString(),
          ),
        ),
      ),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (value) => from - value)
        .takeWhile((value) => value >= 0)
        .listen((value) => this.value = value);
  }
  late StreamSubscription sub;
  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
