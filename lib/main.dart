import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final controller2 = useTextEditingController();
    final text = useState("");

    useEffect(
      () {
        controller.addListener(() {
          text.value = controller.text;
        });
        return null;
      },
      [controller, controller2],
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: controller),
              TextField(controller: controller2),
              Text('Text you typed in the first field: ${text.value}'),
            ],
          ),
        ),
      ),
    );
  }
}
