part of 'home_bloc.dart';

class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class RecordingState extends HomeState {}

class RecordingErrorState extends HomeState {
  final String errorMsg;

  RecordingErrorState({required this.errorMsg});
  List<Object> get props => [errorMsg];
}

class SongSearchSuccessState extends HomeState {
  //TODO Recording format
  final String song;

  SongSearchSuccessState({required this.song});
  List<Object> get props => [song];
}

class SongSearchFailedState extends HomeState {
  final String msg;

  SongSearchFailedState({required this.msg});
  List<Object> get props => [msg];
}
