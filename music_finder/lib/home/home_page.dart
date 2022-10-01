import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_finder/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is RecordingSuccessState) {
            // TODO
          } else if (state is RecordingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error en la grabación")),
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
      child: Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
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
          onPressed: () {},
          shape: CircleBorder(),
          child: CircleAvatar(
            child: Icon(Icons.favorite, color: Colors.black),
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 230),
      ],
    ));
  }

  Expanded _recordButton(context, state) {
    return Expanded(
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        AvatarGlow(
          glowColor: Colors.deepPurpleAccent,
          endRadius: 170,
          animate: state is RecordingState,
          child: Material(
              shape: CircleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(StartRecordingEvent());
                  },
                  splashColor: Color.fromARGB(109, 54, 0, 96),
                  child: Ink.image(
                      fit: BoxFit.scaleDown,
                      height: 200,
                      image:
                          AssetImage('assets/images/sound_waves_round.png')))),
        ),
      ]),
    );
  }
}
