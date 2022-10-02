import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_finder/home/repositories/AudD_repo.dart';
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

    final record = Record();

    try {
      if (await record.hasPermission()) {
        // Start recording
        await record.start(
            encoder: AudioEncoder.aacLc, // by default
            bitRate: 128000, // by default
            samplingRate: 44100 // by default
            );
        await Future.delayed(Duration(seconds: 5));
        final path = await record.stop();
        if (path == null) throw new Exception();

        // Load screen
        emit(LoadingState());

        //API Search
        try {
          var _song = (await AudDRequest().searchSong(path))["result"];
          emit(SongSearchSuccessState(song: _song));
        } catch (e) {
          emit(SongSearchFailedState(msg: '${e}'));
        }
      } else {
        emit(RecordingErrorState(
            errorMsg: 'Recording permissions are required'));
      }
    } catch (e) {
      emit(RecordingErrorState(errorMsg: 'Something failed: ${e}'));
    }
  }
}
