import 'package:flutter/material.dart';
import 'src/pages/home/home_page.dart';


void main() => runApp(MyApp());

/* ============================================================================================= */

class MyApp extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
