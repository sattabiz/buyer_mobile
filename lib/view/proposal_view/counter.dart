import 'dart:async';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String validDate;
  Counter({
    Key? key,
    required this.validDate,
  }) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  late DateTime parsedDate;
  late Duration remainingTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    parsedDate = DateTime.parse(widget.validDate);

    calculateRemainingTime();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      calculateRemainingTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void calculateRemainingTime() {
    DateTime now = DateTime.now();
    if (now.isBefore(parsedDate)) {
      remainingTime = parsedDate.difference(now);

      //for update counter
      setState(() {});
    } else {
      //if time is up, cancel timer
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    String remainingTimeString =
      "${remainingTime.inDays} G ${remainingTime.inHours.remainder(24).toString().padLeft(2, '0')}:${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}";

    return Text(
      remainingTimeString,
      style: const TextStyle(color: Colors.black, fontSize: 12),
    );
  }
}
