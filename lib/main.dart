import 'dart:math';

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
    final state = useAppLifecycleState();
    return MaterialApp(
      home: Scaffold(
          body: Opacity(
        opacity: state == AppLifecycleState.resumed ? 1 : 0,
        child: Center(
          child: Image.network(
            imageUrl,
          ),
        ),
      )),
    );
  }
}
