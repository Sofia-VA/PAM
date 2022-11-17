import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'favorite_songs_event.dart';
part 'favorite_songs_state.dart';

class FavoriteSongsBloc extends Bloc<FavoriteSongsEvent, FavoriteSongsState> {
  FavoriteSongsBloc() : super(FavoriteSongsInitial()) {
    on<AddFavoriteSongEvent>(_addSong);
    on<GetFavoritesEvent>(_getSongs);
    on<RemoveFavoriteSongEvent>(_removeSong);
  }

  Future<void> _createUserCollectionFirebase(String uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();
    // Si no exite el doc, lo crea con valor default lista vacia
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection("user").doc(uid).set(
        {
          "favoriteSongs": [],
        },
      );
    } else {
      // Si ya existe el doc return
      return;
    }
  }

  Future<void> _createSongsCollectionFirebase(song) async {
    String songUID = song["song_link"].replaceAll("/", "-");
    var songDoc =
        await FirebaseFirestore.instance.collection("songs").doc(songUID).get();
    // Si no exite el doc, lo crea con valor default lista vacia
    if (!songDoc.exists) {
      await FirebaseFirestore.instance
          .collection("songs")
          .doc(songUID)
          .set(song);
    } else {
      // Si ya existe el doc return
      return;
    }
  }

  FutureOr<void> _addSong(
      AddFavoriteSongEvent event, Emitter<FavoriteSongsState> emit) async {
    emit(AddingSong());

    try {
      var userUID = FirebaseAuth.instance.currentUser!.uid;
      _createUserCollectionFirebase(userUID);

      List listIds = await _getUserFavSongsIds(userUID);
      print('listaaa');

      // song_link of song used as songUID
      _createSongsCollectionFirebase(event.song);

      print(listIds);
      String songUID = event.song["song_link"].replaceAll("/", "-");
      print(songUID);

      if (listIds.contains(songUID)) {
        print('Song is already in favs');

        throw Exception("Song already in favorites");
      } else {
        FirebaseFirestore.instance.collection("user").doc(userUID).set({
          'favoriteSongs': FieldValue.arrayUnion([songUID])
        }, SetOptions(merge: true));
      }

      emit(SuccessAddingSong());
    } catch (e) {
      print(e);
      emit(FailureAddingSong(errorMsg: '${e}'));
    }
  }

  FutureOr<void> _getSongs(
      GetFavoritesEvent event, Emitter<FavoriteSongsState> emit) async {
    try {
      var userUID = FirebaseAuth.instance.currentUser!.uid;
      _createUserCollectionFirebase(userUID);

      List listIds = await _getUserFavSongsIds(userUID);

      // Query to get Songs docs
      var querySongs =
          await FirebaseFirestore.instance.collection("songs").get();

      // Filter songs with ids
      var userFavoriteSongs = querySongs.docs
          .where((doc) => listIds.contains(doc.id))
          .map((doc) => doc.data().cast<String, dynamic>())
          .toList();

      // List of user's favorites
      emit(LoadedSongsState(songs: userFavoriteSongs));
    } catch (e) {
      emit(FailureAddingSong(errorMsg: '${e}'));
    }
  }

  FutureOr<void> _removeSong(
      RemoveFavoriteSongEvent event, Emitter<FavoriteSongsState> emit) async {
    emit(RemovingSong());
    try {
      var userUID = FirebaseAuth.instance.currentUser!.uid;
      String songUID = event.song["song_link"].replaceAll("/", "-");

      FirebaseFirestore.instance.collection("user").doc(userUID).set({
        'favoriteSongs': FieldValue.arrayRemove([songUID])
      }, SetOptions(merge: true));

      emit(SuccessRemovingSong());
    } catch (e) {
      emit(FailureRemovingSong(errorMsg: '${e}'));
    }
  }

  _getUserFavSongsIds(String userUID) async {
    // Document of User with ID
    var queryUser =
        await FirebaseFirestore.instance.collection("user").doc("${userUID}");
    // Get user data
    var docsRef = await queryUser.get();
    return docsRef.data()?["favoriteSongs"];
  }
}
