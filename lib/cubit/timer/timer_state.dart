abstract class TimerState{
  const TimerState();

  @override
  List<Object?> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final Duration duration;
  final String tag;
  const TimerRunning(this.duration, this.tag);

  @override
  List<Object?> get props => [duration];
}

class TimerStopState extends TimerState{}

class TimerPaused extends TimerState {
  final Duration duration;

  const TimerPaused(this.duration);

  @override
  List<Object?> get props => [duration];
}
