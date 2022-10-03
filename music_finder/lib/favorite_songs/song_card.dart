import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_finder/favorite_songs/song_page.dart';

import 'bloc/favorite_songs_bloc.dart';

class SongCard extends StatelessWidget {
  final Map<String, dynamic> song;
  const SongCard({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Material(
              color: Colors.purple[600],
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SongPage(song: song)));
                  },
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Stack(children: <Widget>[
                      Ink.image(
                          image: NetworkImage(
                            song["artwork"] ??
                                'http://hikarinoakariost.info/wp-content/uploads/nuevo/2018/01/91ho2djqOIL._SL1252_-372x367.jpg',
                          ),
                          height: MediaQuery.of(context).size.width / 1.5,
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.cover),
                      Positioned(
                        top: 10,
                        left:
                            10, //give the values according to your requirement
                        child: IconButton(
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            icon: Icon(Icons.favorite, size: 40)),
                      ),
                    ]),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text('${song["title"] ?? "Song Title"}'),
                        Text('${song["artist"] ?? "Artist"}')
                      ],
                    ),
                    SizedBox(height: 20),
                  ]))),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget removeButton = TextButton(
      child: Text("Remove"),
      onPressed: () {
        BlocProvider.of<FavoriteSongsBloc>(context)
            .add(RemoveFavoriteSongEvent(song: song));
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("Remove ${song["title"]} from favorites?"),
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
}
