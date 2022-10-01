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

class RecordingSuccessState extends HomeState {
  //TODO Recording format
  final String recording;

  RecordingSuccessState({required this.recording});
  List<Object> get props => [recording];
}
