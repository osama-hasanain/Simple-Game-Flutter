import 'package:flutter/material.dart';
import 'package:game_example/Routes/order_images.dart';
import 'package:game_example/routes.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OrderImages.routes,
      routes: routes,
    );
  }
}