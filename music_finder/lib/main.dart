import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/bloc/home_bloc.dart';
import 'home/home_page.dart';
import 'song/song_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Track App',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(),
          primaryColor: Colors.purple[800],
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(color: Colors.purple[800]),
          iconTheme: IconThemeData(color: Colors.white)),
      home: BlocProvider(create: (context) => HomeBloc(), child: HomePage()),
    );
  }
}
