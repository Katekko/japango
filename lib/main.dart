import 'package:flutter/material.dart';

import 'core/navigation/navigation.dart';
import 'core/navigation/routes.dart';

void main() async {
  final initialRoute = await Routes.initialRoute;
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: Navigation.router);
  }
}
