import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );

class MainApp extends HookWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final time = useStream(getTime());

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(time.data ?? ''),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
