import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/screens/timer/timer_home.dart';

import '../../cubit/timer/timer_cubit.dart';
import '../../cubit/timer/timer_state.dart';
import '../../utils/tools/file_importer.dart';

class TimerBlock extends StatelessWidget {
  final TimeOfDay timeOfDay;
  final String tag;

  const TimerBlock({super.key, required this.timeOfDay, required this.tag});

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
              } else if (state is TimerStopState) {
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

  const TimerRunningWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Your logic here, return true to allow back navigation, false to prevent it
          // For example, show a confirmation dialog
          return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to completed task?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
              ],
            ),
          ) ?? false; // Handle null when the dialog is dismissed
        },
        child: Scaffold(
          backgroundColor: const Color(0xffC5EFAB),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.tag,
                  style: AppTextStyle.recolateBold
                      .copyWith(fontSize: 42),
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
                  height: 80,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xffC5EFAB),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tips or suggestions",
                        style: AppTextStyle.recolateBold,
                      ),
                      Text(
                        "Supporting line text lorem ipsum dolor sit amet, consectetur.",
                        style: AppTextStyle.recolateMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 60,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        )
    );

  }
}

class TimerPausedWidget extends StatelessWidget {
  const TimerPausedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade500
              ),
              alignment: Alignment.center,
              child: Icon(Icons.category,size: 60,color: Colors.white),
            ),
            Text(
              "CONGRATS",
              style: AppTextStyle.recolateMedium.copyWith(fontSize: 50),
            ),
            const SizedBox(height: 30),
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
                  backgroundColor: const Color(0xff00696B),
                ),
                child: const Text("Keep Busy",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
