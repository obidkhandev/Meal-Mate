import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/cubit/timer/timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  late Timer _timer;

  TimerCubit() : super(TimerInitial());

  void startTimer(TimeOfDay timeOfDay, String tag) {
    Duration _duration = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

    int durationInSeconds = _duration.inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (durationInSeconds > 0) {
        durationInSeconds -= 1;
        _duration = Duration(seconds: durationInSeconds);
        emit(TimerRunning(_duration, tag));
      } else {
        _timer.cancel();
        emit(TimerStopState());
      }
    });
  }


  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
