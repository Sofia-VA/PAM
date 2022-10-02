import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'favorite_songs_event.dart';
part 'favorite_songs_state.dart';

class FavoriteSongsBloc extends Bloc<FavoriteSongsEvent, FavoriteSongsState> {
  FavoriteSongsBloc() : super(FavoriteSongsInitial()) {
    on<AddFavoriteSongEvent>(_addSong);
  }

  final String _fileTitle = "FavoriteSongs";

  Future<bool> _requestStoragePermission() async {
    var permiso = await Permission.storage.status;
    if (permiso == PermissionStatus.denied) {
      await Permission.storage.request();
    }
    return permiso == PermissionStatus.granted;
  }

  Future<void> _saveFile(String _title, String _content, Directory dir) async {
    if (!await _requestStoragePermission()) {
      throw Exception();
    }
    final File file = File("${dir.path}/$_title.txt");

    await file.writeAsString(_content);
  }

  Future<List<Map<String, dynamic>>?> _readFile(
      String _title, Directory dir) async {
    try {
      final File file = File("${dir.path}/$_title.txt");
      String _content = await file.readAsString();
      // List _content = (await file.readAsString()).split(',');
      // _content.map((song) => json.decode(song)); //List<dynamic>

      List<Map<String, dynamic>> _songs = (jsonDecode(_content)["data"] as List)
          .map((song) => song as Map<String, dynamic>)
          .toList();

      return _songs;
    } catch (e) {
      return null;
    }
  }

  FutureOr<void> _addSong(
      AddFavoriteSongEvent event, Emitter<FavoriteSongsState> emit) async {
    if (!await _requestStoragePermission()) {
      emit(FailureAddingSong(
          errorMsg:
              "Storage permission is required to save your favorite songs"));
    } else {
      var _extDir = await getExternalStorageDirectory();
      try {
        List<Map<String, dynamic>>? _songs =
            await _readFile(_fileTitle, _extDir!);
        if (_songs == null) {
          // FavoriteList has not been created
          _saveFile(_fileTitle, json.encode(event.song), _extDir);
        } else {
          // Adding song to FavoriteList
          for (var song in _songs) {
            if (song == event.song) {
              throw Exception("Song already in favorites");
            }
          }
          _songs.add(event.song);
          _saveFile(_fileTitle, json.encode(_songs), _extDir);
        }
        emit(SuccessAddingSong());
      } catch (e) {
        emit(FailureAddingSong(errorMsg: '${e}'));
      }
    }
  }
}
