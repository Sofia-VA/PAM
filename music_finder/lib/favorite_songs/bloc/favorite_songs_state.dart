part of 'favorite_songs_bloc.dart';

@immutable
abstract class FavoriteSongsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteSongsInitial extends FavoriteSongsState {}

class LoadedSongsState extends FavoriteSongsState {
  final List<dynamic> songs;

  LoadedSongsState({required this.songs});

  @override
  List<Object> get props => [songs];
}

class AddingSong extends FavoriteSongsState {}

class RemovingSong extends FavoriteSongsState {}

class SuccessAddingSong extends FavoriteSongsState {}

class FailureAddingSong extends FavoriteSongsState {
  final String errorMsg;

  FailureAddingSong({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class NoPermissionState extends FavoriteSongsState {
  final String errorMsg;

  NoPermissionState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class SuccessRemovingSong extends FavoriteSongsState {}

class FailureRemovingSong extends FavoriteSongsState {
  final String errorMsg;

  FailureRemovingSong({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
