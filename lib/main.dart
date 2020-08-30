import 'package:flutter/material.dart';
import './homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff0A0E21),
        primaryColor: Color(0xff0A0E21),
        accentColor: Color(0xffE99B89B),
        // buttonColor: Colors.cyan
      ),
    );
  }
}
