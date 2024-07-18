import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imageUrl =
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController(onListen: () {
      controller.sink.add(0);
    });
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<double>(
            stream: controller.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final rotaion = snapshot.data ?? 0;
              return GestureDetector(
                onTap: () {
                  controller.sink.add(rotaion + 10);
                },
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(rotaion / 360),
                  child: Center(
                    child: Image.network(imageUrl),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
