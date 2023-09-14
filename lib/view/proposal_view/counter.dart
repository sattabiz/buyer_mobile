import 'dart:async';

import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({ 
    Key? key,
     }) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {

  Timer? countdownTimer;
  Duration duration = const Duration(days: 4);

  void startTimer() {
    countdownTimer =
      Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }


  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(duration.inDays); // <-- SEE HERE
    final hours = strDigits(duration.inHours.remainder(24));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));
    return Text(
      '$days:$hours:$minutes:$seconds',
      style: const TextStyle(
          color: Colors.black,
          fontSize: 12),
    );
  }
}