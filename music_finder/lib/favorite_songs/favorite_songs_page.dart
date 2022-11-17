import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:music_finder/favorite_songs/song_card.dart';
import 'package:music_finder/home/home_page.dart';

import '../login/login.dart';
import 'bloc/favorite_songs_bloc.dart';

class FavoriteSongsPage extends StatelessWidget {
  FavoriteSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showAlertDialog(context);
              })
        ],
      ),
      body: BlocConsumer<FavoriteSongsBloc, FavoriteSongsState>(
          listener: (context, state) {
        if (state is NoPermissionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
        }
      }, builder: (context, state) {
        if (state is LoadedSongsState) {
          return _favoriteSongsArea(state.songs, context);
        } else {
          BlocProvider.of<FavoriteSongsBloc>(context).add(GetFavoritesEvent());
          return _loadingView(state, context);
        }
      }),
    );
  }

  Widget _loadingView(state, context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (state is NoPermissionState) ...[
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 30),
                    child: Text("${state.errorMsg}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15))),
              ],
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _favoriteSongsArea(List<dynamic>? songs, context) {
    if (songs == null || songs.isEmpty)
      return Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/music_note.png',
                  height: MediaQuery.of(context).size.height / 7),
              SizedBox(height: 20),
              Text("No favorite songs so far", style: TextStyle(fontSize: 20)),
            ],
          )),
        ],
      );

    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: _favoriteSongs(songs));
  }

  ListView _favoriteSongs(songs) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: SongCard(
                song: songs[index],
              ));
        });
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget removeButton = TextButton(
    child: Text("LogOut"),
    onPressed: () async {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      BlocProvider.of<FavoriteSongsBloc>(context).add(ResetStateEvent());

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Would you like to logout?"),
    actions: [
      cancelButton,
      removeButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
