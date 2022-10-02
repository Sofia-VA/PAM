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
      ..fields['return'] = 'spotify, deexer, apple_music'
      ..files.add(await http.MultipartFile.fromPath('file', path));

    var _response = await request.send();
    final respStr = await _response.stream.bytesToString();

    print(respStr);

    if (_response.statusCode == 200) {
      var _song = jsonDecode(respStr);
      if (_song["result"] == null) {
        throw Exception("Song not found");
      }
      return _song;
    }
  }
}
