import 'package:flutter/material.dart';
import 'pages/tabs/tab.dart';
import 'routers/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Tabs(), initialRoute: "/", onGenerateRoute: onGenerateRoute);
  }
}
