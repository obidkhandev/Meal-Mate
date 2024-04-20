import 'package:meal_mate/screens/timer/timer_block.dart';
import 'package:meal_mate/screens/timer/widget/my_dialog.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class TimerHomeScreen extends StatefulWidget {
  const TimerHomeScreen({super.key});

  @override
  State<TimerHomeScreen> createState() => _TimerHomeScreenState();
}

class _TimerHomeScreenState extends State<TimerHomeScreen> {
  String _selected = timerCategory.first;
  DateTime dataTime = DateTime.now();
  TimeOfDay? timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                      value: 1,
                      strokeWidth: 3,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2 -
                      95, // Adjusted position
                  child: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      "01:00",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              "Study",
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 46.h,
              width: width(context) * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  myModalBottomSheet(
                    context: context,
                    dropDown: SizedBox(
                      width: 150,
                      height: 60,
                      child: DropdownButton(
                        value: _selected,
                        items: timerCategory.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                            setState(() {
                              _selected = newValue!;
                            });
                        },
                      ),
                    ),
                    onTap: () async {
                      timeOfDay = await showTimePicker(
                          context: context,
                          initialEntryMode: TimePickerEntryMode.input,
                          initialTime: const TimeOfDay(
                            hour: 0,
                            minute: 0,
                          ),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: true,
                              ),
                              child: child!,
                            );
                          });
                    },
                    onSaveButtonTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TimerBlock(tag: _selected,timeOfDay: timeOfDay!,),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text("Start"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
