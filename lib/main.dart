import 'package:aftellen/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aftellen naar 2022',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Aftellen naar 2022'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountdownTimerController _countdownTimerController;

  @override
  void initState() {
    super.initState();
    // count down
    int endTime = DateTime.parse("2022-01-01 00:00:00").millisecondsSinceEpoch;
    // for testing
    // int endTime = DateTime.now().millisecondsSinceEpoch + 10000;
    _countdownTimerController =
        CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    _countdownTimerController.dispose();
    super.dispose();
  }

  Future<void> onEnd() async {
    vibrateOnDevices();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Video()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CountdownTimer(
              controller: _countdownTimerController,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return Video();
                }

                double width = MediaQuery.of(context).size.width;

                return Column(
                  children: [
                    Text('2022',
                        style: TextStyle(
                            fontSize: width * 0.1,
                            color: Colors.red[500],
                            fontWeight: FontWeight.w900)),
                    Text('${time.days ?? 0} dagen',
                        style: TextStyle(
                            fontSize: width * 0.03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w900)),
                    Text(
                        '${time.hours ?? 0} uur ${time.min ?? 0} min ${time.sec ?? 0} sec',
                        style: TextStyle(
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w900)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> vibrateOnDevices() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 2000);
    }
  }
}
