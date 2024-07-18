import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const imageUrl =
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg';

enum Actions {
  rotateLeft,
  rotateRight,
  moreVisible,
  lessVisible,
}

class State {
  final double rotationDegrees;
  final double opacity;

  const State({
    required this.rotationDegrees,
    required this.opacity,
  });

  const State.zero()
      : rotationDegrees = 0,
        opacity = 1;

  State rotateRight() => State(
        rotationDegrees: rotationDegrees + 10,
        opacity: opacity,
      );

  State rotateLeft() => State(
        rotationDegrees: rotationDegrees - 10,
        opacity: opacity,
      );

  State increaseOpacity() => State(
        rotationDegrees: rotationDegrees,
        opacity: min(opacity + 0.1, 1),
      );

  State decreaseOpacity() => State(
        rotationDegrees: rotationDegrees,
        opacity: max(opacity - 0.1, 0),
      );
}

State reducer(State oldState, Actions? actoins) => switch (actoins) {
      null => oldState,
      Actions.rotateLeft => oldState.rotateLeft(),
      Actions.rotateRight => oldState.rotateRight(),
      Actions.moreVisible => oldState.increaseOpacity(),
      Actions.lessVisible => oldState.decreaseOpacity(),
    };

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Actions?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: AppBar(
            title: Row(
              children: [
                TextButton(
                  onPressed: () {
                    store.dispatch(Actions.rotateRight);
                  },
                  child: const Text('Rotate right'),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(Actions.rotateLeft);
                  },
                  child: const Text('Rotate left'),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(Actions.moreVisible);
                  },
                  child: const Text('+ Opacaity'),
                ),
                TextButton(
                  onPressed: () {
                    store.dispatch(Actions.lessVisible);
                  },
                  child: const Text('- Opacity'),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: store.state.opacity,
              child: RotationTransition(
                turns:
                    AlwaysStoppedAnimation(store.state.rotationDegrees / 360),
                child: Image.network(imageUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}
