import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

class Timer {
  static CountdownController controller;
  static countDownStart() {
    controller = CountdownController();
    Countdown(
      controller: controller,
      seconds: 50,
      build: (_, timer) => Text(timer.toString()),
      interval: Duration(
        milliseconds: 100,
      ),
      onFinished: () {
        print('Timer is done!');
      },
    );
  }

  static void countDown() {}
}
