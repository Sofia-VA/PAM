import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Track App',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(), primaryColor: Colors.purple),
      home: HomePage(),
    );
  }
}
