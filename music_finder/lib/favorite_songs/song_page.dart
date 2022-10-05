import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_finder/favorite_songs/bloc/favorite_songs_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SongPage extends StatelessWidget {
  final Map<String, dynamic> song;
  const SongPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text('Here you go!'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  context
                      .read<FavoriteSongsBloc>()
                      .add(AddFavoriteSongEvent(song: song));
                }),
            Padding(padding: EdgeInsets.all(6))
          ],
        ),
        body: BlocConsumer<FavoriteSongsBloc, FavoriteSongsState>(
          listener: (context, state) {
            if (state is AddingSong) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Adding song...")),
              );
            }
            if (state is SuccessAddingSong) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Successfully added ${song["title"]} to favorites!")),
              );
            } else if (state is FailureAddingSong) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMsg)),
              );
            } else if (state is NoPermissionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMsg)),
              );
            }
          },
          builder: (context, state) {
            return _displayContent(context);
          },
        ));
  }

  Container _displayContent(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                song["artwork"] ??
                    'http://hikarinoakariost.info/wp-content/uploads/nuevo/2018/01/91ho2djqOIL._SL1252_-372x367.jpg',
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height / 2.2,
              ),
            ),
            SizedBox(height: 45),
            Text("${song["title"] ?? "Song Title"}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text("${song["album"] ?? "Album"}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Text("${song["artist"] ?? "Artist"}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            Text("${song["release_date"] ?? "Release Date"}",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.spotify, size: 40),
                  onPressed: () {
                    _launchSpotify(context);
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.headphones, size: 40),
                  onPressed: () {
                    _launchSongLink(context);
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.apple, size: 40),
                  onPressed: () {
                    _launchAppleMusic(context);
                  }),
            ])
          ],
        ));
  }

  Future<void> _launchSpotify(context) async {
    if (!await launchUrl(Uri.parse(song["spotify"]))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No link available"),
      ));
    }
  }

  Future<void> _launchSongLink(context) async {
    if (!await launchUrl(Uri.parse(song["song_link"]))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No link available"),
      ));
    }
  }

  Future<void> _launchAppleMusic(context) async {
    if (!await launchUrl(Uri.parse(song["apple_music"]))) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No link available"),
      ));
    }
  }
}
