import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_finder/utils/secrets.dart';

class AudDRequest {
  static final AudDRequest _singleton = AudDRequest._internal();
  final String _API_URL = 'https://api.audd.io/';

  factory AudDRequest() {
    return _singleton;
  }

  AudDRequest._internal();

  Future searchSong(String path) async {
    var request = await http.MultipartRequest('POST', Uri.parse(_API_URL))
      ..fields['api_token'] = API_TOKEN
      ..fields['return'] = 'spotify,deezer,apple_music'
      ..files.add(await http.MultipartFile.fromPath('file', path));

    var _response = await request.send();
    final respStr = await _response.stream.bytesToString();

    if (_response.statusCode == 200) {
      var _res = jsonDecode(respStr)["result"];
      if (_res == null) {
        throw Exception("Song not found");
      }

      Map<String, dynamic> _song = {
        "title": _res["title"],
        "album": _res["album"],
        "artist": _res["artist"],
        "release_date": _res["release_date"],
        "song_link": _res["song_link"],
        "apple_music": _res["apple_music"]["url"] ?? _res["song_link"],
        "spotify": _res["spotify"]["href"] ?? _res["song_link"],
        "deezer": _res["deezer"]["link"] ?? _res["song_link"],
        "artwork": _res["apple_music"]["artwork"]["url"] ??
            _res["spotify"]["album"]["images"][0]["url"] ??
            _res["deezer"]["picture"],
      };

      return _song;
    }
  }
}
