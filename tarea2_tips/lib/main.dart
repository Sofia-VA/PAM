import 'package:flutter/material.dart';
import 'package:tip_time/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          listTileTheme: ListTileThemeData(iconColor: Colors.green)),
      home: HomePage(),
    );
  }
}
