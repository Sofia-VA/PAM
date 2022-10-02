import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongPage extends StatelessWidget {
  //final Map<String, dynamic> song;
  const SongPage({
    super.key,
  }); // required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.keyboard_backspace), onPressed: () {}),
          title: const Text('Here you go!'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
            Padding(padding: EdgeInsets.all(6))
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'http://hikarinoakariost.info/wp-content/uploads/nuevo/2018/01/91ho2djqOIL._SL1252_-372x367.jpg',
                    fit: BoxFit.fitWidth,
                    height: MediaQuery.of(context).size.height / 2.2,
                  ), //song["artwork"]),
                ),
                SizedBox(height: 45),
                Text("Song Title",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text("Album",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Text("Artist",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                Text("Release Date",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.spotify, size: 40),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.headphones, size: 40),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.apple, size: 40),
                          onPressed: () {}),
                    ])
              ],
            )));
  }
}
