import 'package:flutter/material.dart';
import 'package:sub7a/pages/home_page.dart';

void main() {
  runApp(const Sub7aApp());
}

class Sub7aApp extends StatelessWidget {
  const Sub7aApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sub7a',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
