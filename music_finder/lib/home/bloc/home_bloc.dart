import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:record/record.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<StartRecordingEvent>(_startRecording);
  }

  FutureOr<void> _startRecording(
      StartRecordingEvent event, Emitter<HomeState> emit) async {
    emit(RecordingState());

    //TODO begin recording + permissions
    await Future.delayed(Duration(seconds: 5));

    emit(RecordingErrorState(errorMsg: ':D'));

    // TODO Use record package
  }
}
