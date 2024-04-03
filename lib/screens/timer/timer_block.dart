import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/screens/timer/timer_home.dart';

import '../../cubit/timer/timer_cubit.dart';
import '../../cubit/timer/timer_state.dart';
import '../../utils/tools/file_importer.dart';

class TimerBlock extends StatelessWidget {
  final TimeOfDay timeOfDay;
  final String tag;

  const TimerBlock({Key? key, required this.timeOfDay, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(),
      child: Builder(
        builder: (context) {
          final timerCubit = BlocProvider.of<TimerCubit>(context);

          timerCubit.startTimer(timeOfDay, tag);
          return BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              if (state is TimerInitial) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is TimerRunning) {
                return TimerRunningWidget(state: state);

              }  else if (state is TimerStopState) {
                return TimerPausedWidget();
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}


class TimerRunningWidget extends StatelessWidget {
  final TimerRunning state;

  const TimerRunningWidget({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC5EFAB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.tag,
              style: AppTextStyle.recolateBold.copyWith(fontSize: 42, color: Colors.white),
            ),
            const SizedBox(height: 50),
            Stack(
              children: [
                 Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                      value: state.duration.inSeconds.toDouble() / 60,
                      strokeWidth: 3,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2 - 95,
                  child: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      state.duration.toString().substring(0, 7),
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              height: 72,
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xffC5EFAB),
                borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,4),
                  color: Colors.black.withOpacity(0.2),
                ),
              ]
              ),
              child: Column(
                children: [
                  Text("Tips or suggestions"),
                  Text("Supporting line text lorem ipsum dolor sit amet, consectetur."),
                ],
              ),
            ),
            Icon(Icons.lock,size: 42,color: Colors.black,),
          ],
        ),
      ),
    );
  }
}

class TimerPausedWidget extends StatelessWidget {
  const TimerPausedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CONGRATS",
              style: AppTextStyle.recolateMedium.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40.h,
              width: width(context) * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimerHomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text("Keep Busy"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
