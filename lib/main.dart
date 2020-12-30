import 'package:aftellen/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';

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
  CountdownTimerController _countdownTimerController;

  @override
  void initState() {
    super.initState();
    int endTime = DateTime.parse("2021-01-01 00:00:00").millisecondsSinceEpoch;
    // for testing
    // int endTime = DateTime.now().millisecondsSinceEpoch + 5000;
    _countdownTimerController =
        CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    _countdownTimerController.dispose();
    super.dispose();
  }

  Future<void> onEnd() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Video()),
    );
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
              controller: _countdownTimerController,
              widgetBuilder: (_, CurrentRemainingTime time) {
                if (time == null) {
                  return Video();
                }

                return Text('${time.hours} uur ${time.min} min ${time.sec} sec',
                    style:
                        TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold));
              },
            ),
          ],
        ),
      ),
    );
  }
}
