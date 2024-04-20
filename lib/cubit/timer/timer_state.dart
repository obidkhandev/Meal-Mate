abstract class TimerState{
  const TimerState();
}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final Duration duration;
  final String tag;
  const TimerRunning(this.duration, this.tag);
}

class TimerStopState extends TimerState{}

class TimerPaused extends TimerState {
  final Duration duration;
  const TimerPaused(this.duration);
}
