part of 'favorite_songs_bloc.dart';

@immutable
abstract class FavoriteSongsEvent extends Equatable {
  const FavoriteSongsEvent();

  @override
  List<Object> get props => [];
}

class ResetStateEvent extends FavoriteSongsEvent {}

class GetFavoritesEvent extends FavoriteSongsEvent {}

class AddFavoriteSongEvent extends FavoriteSongsEvent {
  final Map<String, dynamic> song;

  AddFavoriteSongEvent({required this.song});

  @override
  List<Object> get props => [song];
}

class RemoveFavoriteSongEvent extends FavoriteSongsEvent {
  final Map<String, dynamic> song;

  RemoveFavoriteSongEvent({required this.song});

  @override
  List<Object> get props => [song];
}
