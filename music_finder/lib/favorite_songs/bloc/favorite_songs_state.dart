part of 'favorite_songs_bloc.dart';

@immutable
abstract class FavoriteSongsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteSongsInitial extends FavoriteSongsState {}

class SuccessAddingSong extends FavoriteSongsState {}

class FailureAddingSong extends FavoriteSongsState {
  final String errorMsg;

  FailureAddingSong({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
