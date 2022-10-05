import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_songs/bloc/favorite_songs_bloc.dart';
import 'home/bloc/home_bloc.dart';
import 'home/home_page.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(create: (context) => FavoriteSongsBloc()),
    ], child: MyApp()));

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
          splashColor: Colors.purple[800],
          iconTheme: IconThemeData(color: Colors.white)),
      home: HomePage(),
    );
  }
}
