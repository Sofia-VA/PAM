import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_finder/favorite_songs/favorite_songs_page.dart';
import 'package:music_finder/home/bloc/home_bloc.dart';
import 'package:music_finder/favorite_songs/song_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is SongSearchSuccessState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SongPage(song: state.song)));
          } else if (state is SongSearchFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg)),
            );
          } else if (state is RecordingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState)
            return _loadingView();
          else
            return _defaultView(context, state);
        },
      ),
    );
  }

  Widget _loadingView() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  SafeArea _defaultView(context, state) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 50),
        Center(
            child: Text(
                state is RecordingState
                    ? "Escuchando..."
                    : "Toque para escuchar",
                style: TextStyle(fontSize: 20))),
        SizedBox(height: 50),
        _recordButton(context, state),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FavoriteSongsPage()));
          },
          shape: CircleBorder(),
          child: CircleAvatar(
            child: Icon(Icons.favorite, color: Colors.black),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    ));
  }

  Column _recordButton(context, state) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      AvatarGlow(
        glowColor: Colors.deepPurpleAccent,
        endRadius: 170,
        animate: state is RecordingState,
        child: Material(
            shape: CircleBorder(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(StartRecordingEvent());
                },
                splashColor: Color.fromARGB(109, 54, 0, 96),
                child: Ink.image(
                    fit: BoxFit.scaleDown,
                    height: 200,
                    image: AssetImage('assets/images/sound_waves_round.png')))),
      ),
    ]);
  }
}
