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
      title: 'Aftellen naar 2021',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Aftellen naar 2021'),
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
  CountdownTimerController controller;

  @override
  void initState() {
    super.initState();
    // int endTime = DateTime.parse("2021-01-01 00:00:00").millisecondsSinceEpoch;
    int endTime = DateTime.now().millisecondsSinceEpoch + 10000;
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  Future<void> onEnd() async {
    print('END');
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CountdownTimer(
              controller: controller,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  Vibration.vibrate();
                  return Text('Game over');
                }
                return Text('${time.hours}:${time.min}:${time.sec}',
                    style: TextStyle(
                        fontSize: 128.0, fontWeight: FontWeight.bold));
              },
            ),
          ],
        ),
      ),
    );
  }
}
