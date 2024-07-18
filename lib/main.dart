import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imageUrl =
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg';
const imageHeight = 300.0;

extension Normalize on num {
  num normalize(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0,
    num normalizedRangeMax = 1,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}

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
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0,
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0);
        final normalized = newOpacity.normalize(0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: false,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizeTransition(
              sizeFactor: size,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: FadeTransition(
                opacity: opacity,
                child: Image.network(
                  imageUrl,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('tile number ${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
