import 'package:flutter/material.dart';
import 'Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gasometria Arterial',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Home(),
    );
  }
}
