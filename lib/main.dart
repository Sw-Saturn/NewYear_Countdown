import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'New Year Countdown'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final newYear = DateTime(DateTime.now().year + 1, 1, 1);
  Duration differenceDays;
  DateTime _nowTime;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _nowTime = DateTime.now();
    differenceDays = newYear.difference(_nowTime);
    _timer = new Timer.periodic(const Duration(seconds: 1),_getDifferenceDays);
  }

  void _getDifferenceDays(Timer timer)  {
    setState(() {
      _nowTime = DateTime.now();
      differenceDays = newYear.difference(_nowTime);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _printDuration(Duration duration) {
    if(duration.isNegative){
      return "あけましておめでとうございます!!!!";
    } else {
      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }

      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inDays)}日${twoDigits(
          duration.inHours)}時間$twoDigitMinutes分$twoDigitSeconds秒";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
      ),
      body:
      Center(
        child: Text("2020年まであと${_printDuration(differenceDays)}",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      )
    );
  }
}
