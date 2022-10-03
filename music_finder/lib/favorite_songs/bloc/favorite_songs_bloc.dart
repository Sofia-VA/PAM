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
    on<GetFavoritesEvent>(_getSongs);
    on<RemoveFavoriteSongEvent>(_removeSong);
  }

  final String _fileTitle = "favs";

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

  Future<List<dynamic>> _readFile(String _title, Directory dir) async {
    try {
      final File file = File("${dir.path}/$_title.txt");
      String _content = await file.readAsString();

      List<dynamic> songs = json.decode(_content);
      print(songs[0]["title"]);

      return songs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  FutureOr<void> _addSong(
      AddFavoriteSongEvent event, Emitter<FavoriteSongsState> emit) async {
    emit(AddingSong());
    if (!await _requestStoragePermission()) {
      emit(NoPermissionState(
          errorMsg:
              "Storage permission is required to save your favorite songs"));
    } else {
      var _extDir = await getExternalStorageDirectory();
      try {
        print("A leer");
        List<dynamic> _songs = await _readFile(_fileTitle, _extDir!);
        print("Se leyó: ${_songs}");

        if (_songs.isEmpty) {
          // FavoriteList has not been created
          List<Map<String, dynamic>> temp = [event.song];

          _saveFile(_fileTitle, jsonEncode(temp), _extDir);

          print("Se agrega: ${await _readFile(_fileTitle, _extDir)}");
        } else {
          // Adding song to FavoriteList
          print("Fav List existed! Adding...");
          for (var song in _songs) {
            if (song.toString() == event.song.toString()) {
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

  FutureOr<void> _getSongs(
      GetFavoritesEvent event, Emitter<FavoriteSongsState> emit) async {
    if (!await _requestStoragePermission()) {
      emit(NoPermissionState(
          errorMsg:
              "Storage permission is required to save your favorite songs"));
    } else {
      var _extDir = await getExternalStorageDirectory();
      try {
        List<dynamic> _songs = await _readFile(_fileTitle, _extDir!);

        emit(LoadedSongsState(songs: _songs));
      } catch (e) {
        emit(FailureAddingSong(errorMsg: '${e}'));
      }
    }
  }

  FutureOr<void> _removeSong(
      RemoveFavoriteSongEvent event, Emitter<FavoriteSongsState> emit) async {
    emit(RemovingSong());
    if (!await _requestStoragePermission()) {
      emit(NoPermissionState(
          errorMsg:
              "Storage permission is required to save your favorite songs"));
    } else {
      var _extDir = await getExternalStorageDirectory();
      try {
        List<dynamic> _songs = await _readFile(_fileTitle, _extDir!);
        var index = 0;
        for (var song in _songs) {
          if (song.toString() == event.song.toString()) {
            _songs.removeAt(index);
            break;
          }
          index++;
        }
        _saveFile(_fileTitle, json.encode(_songs), _extDir);

        emit(SuccessRemovingSong());
      } catch (e) {
        emit(FailureRemovingSong(errorMsg: '${e}'));
      }
    }
  }
}
